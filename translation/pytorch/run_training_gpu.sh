# Start timing
START=$(date +%s)
START_FMT=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT ${START_FMT}"

SEED=${SEED:-1}
MAX_TOKENS=${MAX_TOKENS:-5120}
DATASET_DIR="./data"

# Includes online scoring
python  train.py ${DATASET_DIR} \
  --seed ${SEED} \
  --arch transformer_wmt_en_de_big_t2t \
  --share-all-embeddings \
  --optimizer adam \
  --adam-betas '(0.9, 0.997)' \
  --adam-eps "1e-9" \
  --clip-norm "0.0" \
  --lr-scheduler inverse_sqrt \
  --warmup-init-lr "0.0" \
  --warmup-updates "3000" \
  --lr "0.00045" \
  --min-lr "0.0" \
  --dropout "0.1" \
  --weight-decay "0.0" \
  --criterion label_smoothed_cross_entropy \
  --label-smoothing "0.1" \
  --max-tokens ${MAX_TOKENS} \
  --max-epoch 1 \
  --target-bleu "25.0" \
  --ignore-case \
  --no-save \
  --update-freq 1 \
  --cuda\
  ${EXTRA_PARAMS}

# End timing
END=$(date +%s)
END_FMT=$(date +%Y-%m-%d\ %r)
echo "ENDING TIMING RUN AT ${END_FMT}"

# Report result
RESULT=$(( ${END} - ${START} ))
RESULT_NAME="transformer"
echo "RESULT,${RESULT_NAME},${SEED},${RESULT},${USER},${START_FMT}"
