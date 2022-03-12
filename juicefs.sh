#!/bin/bash
set -e # exit when any command fails

source ./utils.sh
InitFuseBenchmark juicefs

echo "///////////////////////////////////////////////////////////////////////"
echo "WARNING the JuiceFs file system must have been created in juicefs      "
echo "WARNING the File system to create must have a name nsdf-test-juicefs   "
echo "WARNING see https://juicefs.com/console/create                         "
echo "WARNING the token must be set as environment variable                  "
echo "///////////////////////////////////////////////////////////////////////"

export JUICE_TOKEN=${JUICE_TOKEN:-XXXXX}

# install juicefs
wget -q https://juicefs.com/static/juicefs
chmod +x juicefs 
sudo mv juicefs /usr/bin

# create the bucket if necessary
aws s3 mb s3://${BUCKET_NAME} --region ${BUCKET_REGION} 

juicefs auth \
    ${BUCKET_NAME} \
    --token ${JUICE_TOKEN} \
    --accesskey ${ACCESS_KEY} \
    --secretkey ${SECRET_ACCESS_KEY} 

# TODO: make sure juicefs is not using RAM cache
juicefs mount \
    ${BUCKET_NAME} \
    ${TEST_DIR} \
    --log=${LOG_DIR}/log.log \
    --max-uploads=150 \
    --cache-dir=${CACHE_DIR} \
    --cache-size=${DISK_CACHE_SIZE_MB}  

CheckFuseMount juicefs
RunDiskTest ${TEST_DIR}    
TerminateFuseBenchmark juicefs


