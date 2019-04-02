#!/bin/bash

S3_CONTAINER=ccc1-aviation-data

sudo apt-get install awscli unzip
aws configure # enter AWS credentials that have access to S3 bucket
sudo fdisk -l # show available disks to identify aviation data disk
sudo mkdir /mnt/data
sudo mount /dev/xvdf /mnt/data # mount volume with aviation data
mkdir -p ~/aviation/airline_ontime
cd ~/aviation/airline_ontime
cp -r /mnt/data/aviation/airline_ontime/* . # copying to local disk since mounted volume is read-only
find . -name '*.zip' -exec sh -c 'unzip -o -d `dirname {}` {}' ';' # requires ~38 GB of disk space
aws s3 sync . "s3://$S3_CONTAINER/aviation/airline_ontime # uploading to S3 bucket
