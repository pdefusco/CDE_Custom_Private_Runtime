FROM docker-private.infra.cloudera.com/cloudera/dex/dex-spark-runtime-3.5.4-7.3.2.0@sha256:0193352e392791b26e8af87cce64925ad9915ab435e0e2623279eca7a29fd909

RUN mkdir -p /tmp/my-jars

COPY sqlite-jdbc-3.46.1.3.jar /tmp/my-jars/
