#!/bin/sh

KEY=`jq -r .s3key /data/options.json`
SECRET=`jq -r .s3secret /data/options.json`
BUCKET=`jq -r .bucketname /data/options.json`
REGION=`jq -r .s3region /data/options.json`

aws configure set aws_access_key_id $KEY
aws configure set aws_secret_access_key $SECRET
aws configure set default.region $REGION
aws configure set default.s3.endpoint_url https://s3.$REGION.scw.cloud
aws configure set default.signature_version = s3v4
aws configure set default.max_concurrent_requests = 100
aws configure set default.max_queue_size = 1000
aws configure set default.multipart_threshold = 50MB
aws configure set default.multipart_chunksize = 10MB
aws configure set default.s3api.endpoint_url https://s3.$REGION.scw.cloud

aws s3 sync /backup/ s3://$BUCKET/

echo "Done"
