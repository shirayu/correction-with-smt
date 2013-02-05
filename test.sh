#!/usr/bin/env sh 

MOSES_DIR=$1
MODEL=$2
INPUT=$3
OUTPUT=$4


TEMP_FILTER="./filter"
TEMP_OUT=${TEMP_FILTER}/out


trap "rm -rf ${TEMP_FILTER}; exit;" 0 1 2 3 15

eval ${MOSES_DIR}/scripts/training/filter-model-given-input.pl ${TEMP_FILTER} ${MODEL}/moses.ini ${INPUT}
eval ${MOSES_DIR}/bin/moses -config ${TEMP_FILTER}/moses.ini -i ${INPUT} > ${TEMP_OUT}

eval ${MOSES_DIR}/scripts/tokenizer/detokenizer.perl < ${TEMP_OUT} > ${OUTPUT}
