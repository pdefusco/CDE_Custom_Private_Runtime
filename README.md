# CDE_Custom_Private_Runtime

### Build custom runtime:

```
docker build \
  --network=host -t pauldefusco/cde-custom-runtime-3.5.4:latest . \
  -f Dockerfile
```

```
docker push \
  pauldefusco/cde-custom-runtime-3.5.4:latest
```

### CDE Steps

```
cde credential create \
  --name docker-creds \
  --type docker-basic \
  --docker-server hub.docker.com \
  --docker-username pauldefusco \
  --vcluster-endpoint https://gvn2mdhd.cde-z96vtc5p.se-sandb.a465-9q4k.cloudera.site/dex/api/v1
```

```
cde resource create \
  --name cde-custom-runtime \
  --image pauldefusco/cde-custom-runtime-3.5.4 \
  --image-engine spark3 \
  --type custom-runtime-image \
  --vcluster-endpoint https://gvn2mdhd.cde-z96vtc5p.se-sandb.a465-9q4k.cloudera.site/dex/api/v1
```

```
cde spark submit \
  sparkapp.py \
  --runtime-image-resource-name=cde-custom-runtime \
  --vcluster-endpoint https://gvn2mdhd.cde-z96vtc5p.se-sandb.a465-9q4k.cloudera.site/dex/api/v1
```
