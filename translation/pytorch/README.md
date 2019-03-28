
# 1. Problem 

This problem uses Attention mechanisms to do language translation.

## Requirements
* [PyTorch](https://pytorch.org/) for CPU and GPU version.

# 2. Directions

### Steps to download and verify data

Downloading and preprocessing the data is handled inside submission scripts. To do this manually run 
    DATASET_DIR='/your/path/to/dataset/' bash run_preprocessing.sh
    
### Steps to run and time

## Steps to launch training

Run the `run_and_time_gpu.sh` for GPU device

```bash
source run_and_time_gpu.sh
```

Run the `run_and_time_cpu.sh` script for CPU device(multi-instance)
```bash
source run_and_time_cpu.sh
```
Note:  You can change the seed number in `run_and_training_cpu.sh` or `run_and_training_gpu.sh`

# 3. Dataset/Environment
### Publication/Attribution
We use WMT17 ende training for tranding, and we evaluate using the WMT 2014 English-to-German translation task. See http://statmt.org/wmt17/translation-task.html for more information. 


### Data preprocessing
We combine all the files together and subtokenize the data into a vocabulary.  

### Training and test data separation
We use the train and evaluation sets provided explicitly by the authors.

### Training data order
We split the data into 100 blocks, and we shuffle internally in the blocks. 


# 4. Model
### Publication/Attribution

This is an implementation of the Transformer translation model as described in the [Attention is All You Need](https://arxiv.org/abs/1706.03762) paper. Based on the code provided by the authors: [Transformer code](https://github.com/tensorflow/tensor2tensor/blob/master/tensor2tensor/models/transformer.py) from [Tensor2Tensor](https://github.com/tensorflow/tensor2tensor).

### Structure 

Transformer is a neural network architecture that solves sequence to sequence problems using attention mechanisms. Unlike traditional neural seq2seq models, Transformer does not involve recurrent connections. The attention mechanism learns dependencies between tokens in two sequences. Since attention weights apply to all tokens in the sequences, the Tranformer model is able to easily capture long-distance dependencies.

Transformer's overall structure follows the standard encoder-decoder pattern. The encoder uses self-attention to compute a representation of the input sequence. The decoder generates the output sequence one token at a time, taking the encoder output and previous decoder-outputted tokens as inputs.

The model also applies embeddings on the input and output tokens, and adds a constant positional encoding. The positional encoding adds information about the position of each token.


### Weight and bias initialization

We have two sets of weights to initialize: embeddings and the transformer network. 

The transformer network is initialized using the standard tensorflow variance initalizer. The embedding are initialized using the tensorflow random uniform initializer. 

### Loss function
Cross entropy loss while taking the padding into consideration, padding is not considered part of loss.

### Optimizer
We use the same optimizer as the original authors, which is the Adam Optimizer. We batch for a single P100 GPU of 4096. 

# 5. Quality

### Quality metric
We use the BLEU scores with data from [Attention is All You Need](https://arxiv.org/abs/1706.03762). 


    https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.en
    https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.de


### Quality target
We currently run to a BLEU score (uncased) of 25. This was picked as a cut-off point based on time. 


### Evaluation frequency
Evaluation of BLEU score is done after every epoch.


### Evaluation thoroughness
Evaluation uses all of `newstest2014.en`.
