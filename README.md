# Predicting Guiding Entities for Document Ranking
This repositiory contains data and code for document ranking based on method described in the paper: Shubham Chatterjee and Laura Dietz. 2022. [Predicting Guiding Entities for Entity Aspect Linking](https://www.dcs.gla.ac.uk/~shubham/publications/pdf/cikm2022.pdf). The code and data for this paper can be found [here](https://github.com/shubham526/CIKM2022-EAL).

Shield: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

All data associated with this work is licensed and released under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg

## 1. Downloads
| Resource | Comments |
|:--------|:-------------|
| [CODEC and Robust Data](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/EeRk4TjhhrBCr7C7lnCsEOwBofSubvN8zoGpUqP-93iGVg?e=SMDmY6) | Queries, ground truth, and runs.|
| [Entity Metadata](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/Ec2X4GwOAS5EgJ5am56V4dkBxbuPGB4M9f4xJvCt7dazUg?e=P36oDB) | Metadata for entities.|
| [Folds for CODEC](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/EaxEBZHvwehPkBaIOR2ktDABPspIAeu9Y26oDKu6Q6yn-g?e=vTedYm)| CODEC queries divided into 5-folds for CV.|
| [Folds for Robust04](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/EcVTtfRMYH9LqHQmx9x985kBF8F81zmogGNYBBIkaBcRgA?e=GOGkch)| Robust04 queries divided into 5-folds for CV.|
| [Fold-wise data for CODEC](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/EbCHwUHiDz9DhbXabVPPU-cBDIdmMqQ9TrsyBF3Nn_b8Ww?e=uRgCUU)| Entity ranking data for CODEC split into 5-folds for CV.|
| [Fold-wise data for Robust04](https://gla-my.sharepoint.com/:u:/g/personal/shubham_chatterjee_glasgow_ac_uk/EfzMO1iNXtVIumYpLLkwm5ABvAfJsUKNqTTYBBoexYUegQ?e=GnhGCG)| Entity ranking data for Robust04 split into 5-folds for CV.|

## 2. Running the code
You can download all the data for this work above. Alternatively, you can also use the code provided in this repository to create the data yourself. The data required as input to the code can be downloaded using the `CODEC and Robust Data` link above. 

For all scripts, executing the script with the `-h` or `--help` option will display the list of arguments that the script expects and what each argument means. 

The order in which you must execute the scripts is given in the table below.
| Script | Comments |
|:--------|:-------------|
| [`make_qrels_file.py`](https://github.com/shubham526/doc-ranking-with-entity-guides/blob/main/make_qrels_file.py) | Create an entity ground truth file from document groud truth.|
| [`make_data.py`](https://github.com/shubham526/doc-ranking-with-entity-guides/blob/main/make_data.py) | Create entity ranking data.|
| [`make_fold_queries.py`](https://github.com/shubham526/doc-ranking-with-entity-guides/blob/main/make_fold_queries.py)| Divide the queries into k folds for k-fold cross-validation.|
| [`split_data_by_fold,py`](https://github.com/shubham526/doc-ranking-with-entity-guides/blob/main/split_data_by_fold.py)| Split the data created using `make_data.py` into k folds for CV.|
| [`split_run_or_qrels_by_fold.py`](https://github.com/shubham526/doc-ranking-with-entity-guides/blob/main/split_run_or_qrels_by_fold.py)| Split a run file or qrels file into folds for CV.|

## 3. Training BERT for entity ranking
We use the code [here](https://github.com/shubham526/SIGIR2022-BERT-ER/tree/main/python/bert_ranking) to BERT for entity ranking using the data above.

