import json
import sys
from tqdm import tqdm
import os
import argparse
from typing import List, Dict, Set, Tuple, Any


def read_entity_data_file(file: str) -> Dict[str, str]:
    docs: Dict[str, str] = {}
    with open(file, 'r') as f:
        for line in f:
            d = json.loads(line)
            docs[d['id']] = d['contents'].strip()
    return docs


def read_qrels(file: str) -> Dict[str, Tuple[List[str], List[str]]]:
    qrels: Dict[str, Tuple[List[str], List[str]]] = {}
    with open(file, 'r') as f:
        for line in f:
            if line.split()[0] in qrels:
                if int(line.split()[3]) >= 1:
                    qrels[line.split()[0]][0].append(line.split()[2])
                else:
                    qrels[line.split()[0]][1].append(line.split()[2])
            else:
                if int(line.split()[3]) >= 1:
                    qrels[line.split()[0]] = ([line.split()[2]], [])
                else:
                    qrels[line.split()[0]] = ([], [line.split()[2]])
    return qrels


def read_queries(file: str):
    with open(file, 'r') as f:
        return json.load(f)


def to_pointwise_data_string(query_id, query, entities, desc, label, data):
    for entity_id in entities:
        if entity_id in desc:
            data.append(json.dumps({
                'query_id': query_id,
                'query': query,
                'doc': desc[entity_id],
                'doc_id': entity_id,
                'label': label,
            }))


def write_to_file(data: List[str], save: str):
    with open(save, 'w') as f:
        for d in data:
            f.write('%s\n' % d)


def to_data(query_id, query, pos_entities, neg_entities, desc, mode, data):
    k = min(len(pos_entities), len(neg_entities))
    pos_entities = list(pos_entities)[:k]
    neg_entities = list(neg_entities)[:k]

    if mode == 'pairwise':
        entity_pairs: List[List[str]] = [[a, b] for a in pos_entities for b in neg_entities if a != b]
        for pos_entity, neg_entity in entity_pairs:
            if pos_entity in desc and neg_entity in desc:
                data.append(json.dumps({
                    'query_id': query_id,
                    'query': query,
                    'doc_pos': desc[pos_entity],
                    'doc_neg': desc[neg_entity],
                    'doc_pos_id': pos_entity,
                    'doc_neg_id': neg_entity
                }))
    else:
        to_pointwise_data_string(query_id=query_id, query=query, entities=pos_entities, desc=desc, label=1, data=data)
        to_pointwise_data_string(query_id=query_id, query=query, entities=neg_entities, desc=desc, label=0, data=data)


def create_data(
        mode: str,
        desc: Dict[str, str],
        qrels: Dict[str, Tuple[List[str], List[str]]],
        queries
):
    data: List[str] = []

    for query_id in tqdm(queries, total=len(queries)):
        if query_id in qrels:
            to_data(
                query_id=query_id,
                query=queries[query_id]['title'],
                pos_entities=qrels[query_id][0],
                neg_entities=qrels[query_id][1],
                desc=desc,
                mode=mode,
                data=data
            )

    return data


def main():
    parser = argparse.ArgumentParser("Create a training file.")
    parser.add_argument("--mode", help="Type of data (pairwise|pointwise).", required=True, type=str)
    parser.add_argument("--queries", help="Queries file.", required=True, type=str)
    parser.add_argument("--qrels", help="Entity ground truth file.", required=True, type=str)
    parser.add_argument("--save", help="Output directory.", required=True, type=str)
    parser.add_argument("--desc", help='File containing entity description.', required=True, type=str)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])

    print('Reading description file....')
    desc: Dict[str, str] = read_entity_data_file(args.desc)
    print('[Done].')

    print('Reading entity ground truth file...')
    qrels: Dict[str, Tuple[List[str], List[str]]] = read_qrels(args.qrels)
    print('[Done].')

    print('Reading queries file...')
    queries = read_queries(args.queries)
    print('[Done].')

    print('Creating data...')
    data = create_data(
        mode=args.mode,
        desc=desc,
        qrels=qrels,
        queries=queries
    )
    print('[Done].')

    print('Writing to file...')
    write_to_file(data, args.save)
    print('[Done].')

    print('File written to ==> {}'.format(args.save))


if __name__ == '__main__':
    main()
