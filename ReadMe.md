# Instructions

Define the credentials for the S3 backend (change as needed):

```
export ACCESS_KEY=XXXXX
export SECRET_ACCESS_KEY=YYYYY
export BUCKET_REGION=us-east-1

# # this is needed only for ObjectiveFS test
export OBJECTIVEFS_LICENSE=ZZZZZ 

# this is needed only for JuiceFs 
# you must create a "File System" (see https://juicefs.com/console/)
# with name `nsdf-fuse-test-juicefs`
export JUICE_TOKEN=KKKKK
```

Run one of the test:

```
git clone https://github.com/nsdf-fabric/nsdf-fuse-test
cd nsdf-fuse-test

# NOTE: each test will use the following base directory (see InitFuseTest)
#       ${HOME}/mount/${BUCKET_NAME} where BUCKET_NAME is for example nsdf-fuse-test-s3fs


# very very good
./juicefs.sh

# very very good
.gfoofys.sh

# slow
./geesefs.sh

# slow 
./objectivefs.sh

# slow (very interesting for POSIX compatibility but cannot get more than 100MiB/sec)
./s3backer.sh

# slow
./s3fs.sh

# slow and not concurrent mount see http://www.rath.org/s3ql-docs/faq.html
./s3ql.sh
```


# Benchmarks

```
TODO
```