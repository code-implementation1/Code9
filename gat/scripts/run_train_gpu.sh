#!/bin/bash
# Copyright 2021 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

if [ $# != 2 ]
then 
    echo "Usage: bash run_train_gpu.sh [DATASET_NAME] [DATA_DIR]"
exit 1
fi

DATASET_NAME=$1
DATA_DIR=$2
echo $DATASET_NAME

if [ -d "train" ];
then
    rm -rf ./train
fi
mkdir ./train
cp ../*.py ./train
cp ../*.yaml ./train
cp *.sh ./train
cp -r ../src ./train
cd ./train || exit
env > env.log
echo "start training"


if [ $DATASET_NAME == cora ]
then
    python train.py --data_dir=$DATA_DIR/$DATASET_NAME --dataset=$DATASET_NAME --device_target="GPU" &> log &
fi

if [ $DATASET_NAME == citeseer ]
then 
    python train.py --data_dir=$DATA_DIR/$DATASET_NAME --train_nodes_num=120 --dataset=$DATASET_NAME --device_target="GPU" &> log &
fi
cd ..
