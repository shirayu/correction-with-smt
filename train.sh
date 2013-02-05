#!/usr/bin/env sh 

MOSES_DIR=$1
SUFFIX=$2
WORK=$3


#### Related variables ####
INCOR=${SUFFIX}.incor
COR=${SUFFIX}.corr

INCOR_TOK=${INCOR}.tok
COR_TOK=${COR}.tok
LMK=${COR}.lm
LOG=${WORK}/log.txt
###########################


#Tokenize inputs
eval ${MOSES_DIR}/tokenizer/tokenizer.perl < ${INCOR} > ${INCOR_TOK}
eval ${MOSES_DIR}/tokenizer/tokenizer.perl < ${COR} > ${COR_TOK}


#Make LM (language model)
eval ${MOSES_DIR}/irstlm/bin/add-start-end.sh < ${COR_TOK} > __a
export IRSTLM=${MOSES_DIR}/irstlm
eval ${MOSES_DIR}/irstlm/bin/build-lm.sh -i a -t ./tmp -p -s improved-kneser-ney -o __b
eval ${MOSES_DIR}/irstlm/bin/compile-lm --text yes b __c
eval ${MOSES_DIR}/bin/build_binary ${LM}
rm a b c


#Train
mkdir -p ${WORK}
eval ${MOSES_DIR}/scripts/training/train-model.perl \
	-corpus ${SUFFIX} -f ${INCOR_TOK} -e ${COR_TOK} \
	-alignment grow-diag-final-and \
	-reordering msd-bidirectional-fe \
	-lm 0:3:${LM}:8 \
	-external-bin-dir ${MOSES_DIR}/giza  \
	-root-dir ${WORK} \
	 2>&1 | tee ${LOG}


