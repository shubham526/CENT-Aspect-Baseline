mainDir=/home/sc1242/work/sigir2022-iain/
codecDocs=$mainDir/iain_data/codec_docs.jsonl
codecQueries=$mainDir/iain_data/codec_queries.json
codecQrels=$mainDir/iain_data/codec.qrels
codecFolds=$mainDir/data/codec/all/folds.jsonl
robustDocs=$mainDir/iain_data/robust_docs.jsonl
robustQueries=$mainDir/iain_data/robust_queries.json
robustQrels=$mainDir/iain_data/robust.qrels
robustFolds=$mainDir/data/robust/all/folds.jsonl
entityMeta=$mainDir/iain_data/entity_metadata.jsonl

# 1. Create the qrels file
echo "Creating qrels for CODEC"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/make_qrels_file.py \
  --qrels "$codecQrels" \
  --docs "$codecDocs" \
  --save /home/sc1242/work/sigir2022-iain/data/codec/all/entity.qrels
echo "===================="

echo "Creating qrels for Robust"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/make_qrels_file.py \
  --qrels "$robustQrels" \
  --docs "$robustDocs" \
  --save /home/sc1242/work/sigir2022-iain/data/robust/all/entity.qrels
echo "===================="

# 2. Create data
echo "Creating data for CODEC"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/make_data.py \
  --mode 'pointwise' \
  --queries $codecQueries \
  --qrels $codecQrels \
  --desc $entityMeta \
  --save /home/sc1242/work/sigir2022-iain/data/codec/all
echo "===================="

echo "Creating data for Robust"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/make_data.py \
  --mode 'pointwise' \
  --queries $robustQueries \
  --qrels $robustQrels \
  --desc $entityMeta \
  --save /home/sc1242/work/sigir2022-iain/data/robust/all
echo "===================="

# 3. Split qrels by fold
echo "Splitting CODEC qrels by fold"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_run_or_qrels_by_fold.py \
  --folds $codecFolds \
  --file /home/sc1242/work/sigir2022-iain/data/codec/all/entity.qrels \
  --save /home/sc1242/work/sigir2022-iain/data/codec \
  --train train.jsonl \
  --test test.jsonl
echo "===================="

echo "Splitting Robust qrels by fold"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_run_or_qrels_by_fold.py \
  --folds $robustFolds \
  --file /home/sc1242/work/sigir2022-iain/data/robust/all/entity.qrels \
  --save /home/sc1242/work/sigir2022-iain/data/robust \
  --train train.jsonl \
  --test test.jsonl
echo "===================="

# 4. Split data by fold
echo "Splitting CODEC data by fold"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_data_by_fold.py \
  --fold-file $codecFolds \
  --data /home/sc1242/work/sigir2022-iain/data/codec/all/data.pointwise.jsonl \
  --save /home/sc1242/work/sigir2022-iain/data/codec \
  --train

python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_data_by_fold.py \
  --fold-file $codecFolds \
  --data /home/sc1242/work/sigir2022-iain/data/codec/all/data.pointwise.jsonl \
  --save /home/sc1242/work/sigir2022-iain/data/codec
echo "===================="

echo "Splitting Robust data by fold"
python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_data_by_fold.py \
  --fold-file $robustFolds \
  --data /home/sc1242/work/sigir2022-iain/data/robust/all/data.pointwise.jsonl \
  --save /home/sc1242/work/sigir2022-iain/data/robust \
  --train

python3 /home/sc1242/work/PyCharmProjects/eal2/venv/src/sigir2022-iain/split_data_by_fold.py \
  --fold-file $robustFolds \
  --data /home/sc1242/work/sigir2022-iain/data/robust/all/data.pointwise.jsonl \
  --save /home/sc1242/work/sigir2022-iain/data/robust
echo "===================="