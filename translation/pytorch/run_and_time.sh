#! /bin/bash
# Options

set -x

SEED=${SEED:-$RANDOM}
MAX_TOKENS=${MAX_TOKENS:-4000}
DATASET_DIR="./data"
MODE=${MODE:-TRAIN}

case "$MODE" in
  PREPROCESS) source run_preprocessing.sh;;
  TRAIN)      source run_training.sh;;
esac

set +x
