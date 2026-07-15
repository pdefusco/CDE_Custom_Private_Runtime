# THESE STEPS ARE NOT SUPPORTED AT TIME OF THIS WRITING

Build custom runtime:

cloudera/dex/dex-spark-runtime-3.5.4-7.3.2.0

docker-private.infra.cloudera.com/cloudera/dex/dex-spark-runtime-3.5.4-7.3.2.0@sha256:0193352e392791b26e8af87cce64925ad9915ab435e0e2623279eca7a29fd909

Create ECR Private repository:

```
aws ecr create-repository \
  --repository-name cde-custom-runtime \
  --region us-west-2
```

{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-west-2:981304421142:repository/cde-custom-runtime",
        "registryId": "981304421142",
        "repositoryName": "cde-custom-runtime",
        "repositoryUri": "981304421142.dkr.ecr.us-west-2.amazonaws.com/cde-custom-runtime",
        "createdAt": "2026-07-14T19:46:06.179000-03:00",
        "imageTagMutability": "MUTABLE",
        "imageScanningConfiguration": {
            "scanOnPush": false
        },
        "encryptionConfiguration": {
            "encryptionType": "AES256"
        }
    }
}

```
aws ecr get-login-password --region us-west-2 | \
  docker login --username AWS --password-stdin 981304421142.dkr.ecr.us-west-2.amazonaws.com/cde-custom-runtime
```

```
docker build --network=host -t cde-custom-runtime-3.5.4 . -f Dockerfile
```

```
docker tag cde-custom-runtime-3.5.4:latest \
  981304421142.dkr.ecr.us-west-2.amazonaws.com/cde-custom-runtime:latest  
```

```
docker push \
  981304421142.dkr.ecr.us-west-2.amazonaws.com/cde-custom-runtime
```

```
aws ecr describe-images \
  --repository-name cai-sparklyr-rm \
  --region us-west-2
```

CDE Steps

```
cde credential create \
  --name docker-creds \
  --type docker-basic \
  --docker-server hub.docker.com \
  --docker-username pauldefusco \
  --vcluster-endpoint https://gvn2mdhd.cde-z96vtc5p.se-sandb.a465-9q4k.cloudera.site/dex/api/v1
```
