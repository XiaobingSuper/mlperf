# Note

This repo base on mlperf [benchmark](https://github.com/mlperf/training/tree/master/recommendation), I just give a running script for running well on CPU device, you can also use the original code.

# 1. Problem
This task benchmarks recommendation with implicit feedback on the [MovieLens 20 Million (ml-20m) dataset](https://grouplens.org/datasets/movielens/20m/) with a [Neural Collaborative Filtering](http://dl.acm.org/citation.cfm?id=3052569) model.
The model trains on binary information about whether or not a user interacted with a specific item.

# 2. Directions
### Steps to configure machine

#### From Source

1. Install [PyTorch](https://pytorch.org/) for CPU and GPU version by conda.
2. Install `unzip` and `curl`

```bash
sudo apt-get install unzip curl
```
3. Checkout the MLPerf repo
```bash
git clone https://github.com/XiaobingSuper/mlperf.git
```

4. Install other python packages

```bash
cd mlperf/recommendation/pytorch
pip install -r requirements.txt
```

#### From Docker

please see orginal [benchmark] (https://github.com/mlperf/training/tree/master/recommendation/pytorch)

### Steps to download and verify data

You can download and verify the dataset by running the `download_dataset.sh` and `verify_dataset.sh` scripts in the parent directory:

```bash
# Creates ml-20.zip
source ../download_dataset.sh
# Confirms the MD5 checksum of ml-20.zip
source ../verify_dataset.sh
```

### Steps to run and time

#### From Source

Run the `run_and_time_gpu.sh` fro GPU device script with an integer seed value between 1 and 5

```bash
source run_and_time_gpu.sh SEED
```

Run the `run_and_time_cpu.sh` script for CPU device with an integer seed value between 1 and 5
```bash
source run_and_time_cpu.sh SEED
```

#### Docker Image

please see orginal [benchmark] (https://github.com/mlperf/training/tree/master/recommendation/pytorch)

# 3. Dataset/Environment
### Publication/Attribution
Harper, F. M. & Konstan, J. A. (2015), 'The MovieLens Datasets: History and Context', ACM Trans. Interact. Intell. Syst. 5(4), 19:1--19:19.

### Data preprocessing

1. Unzip
2. Remove users with less than 20 reviews
3. Create training and test data separation described below

### Training and test data separation
Positive training examples are all but the last item each user rated.
Negative training examples are randomly selected from the unrated items for each user.

The last item each user rated is used as a positive example in the test set.
A fixed set of 999 unrated items are also selected to calculate hit rate at 10 for predicting the test item.

### Training data order
Data is traversed randomly with 4 negative examples selected on average for every positive example.


# 4. Model
### Publication/Attribution
Xiangnan He, Lizi Liao, Hanwang Zhang, Liqiang Nie, Xia Hu and Tat-Seng Chua (2017). [Neural Collaborative Filtering](http://dl.acm.org/citation.cfm?id=3052569). In Proceedings of WWW '17, Perth, Australia, April 03-07, 2017.

The author's original code is available at [hexiangnan/neural_collaborative_filtering](https://github.com/hexiangnan/neural_collaborative_filtering).

# 5. Quality
### Quality metric
Hit rate at 10 (HR@10) with 999 negative items.

### Quality target
HR@10: 0.635

### Evaluation frequency
After every epoch through the training data.

### Evaluation thoroughness

Every users last item rated, i.e. all held out positive examples.
