#!/bin/bash
# 2015-Mar-18 Updated to latest Kafka stable: 0.8.2.1
set -e
set -u
name=kafka
version=${1:-"0.8.1.1"}
scala_version=${2:-"2.8.0"}
description="Apache Kafka is a distributed publish-subscribe messaging system."
url="https://kafka.apache.org/"
arch="all"
section="misc"
license="Apache Software License 2.0"
package_version="-1"
src_package="kafka_${scala_version}-${version}.tgz"
download_url="http://apache.rediris.es/kafka/${version}/${src_package}"
origdir=$(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0/..)

#_ MAIN _#
rm -rf ${name}*.deb
if [[ ! -f "${src_package}" ]]; then
  wget ${download_url} -P $origdir
fi
mkdir -p tmp && pushd tmp
rm -rf kafka
mkdir -p kafka
cd kafka
mkdir -p build/opt/kafka
mkdir -p build/etc/default
mkdir -p build/etc/init
mkdir -p build/var/log/kafka

cp ${origdir}/kafka.default build/etc/default/kafka
cp ${origdir}/kafka.upstart.conf build/etc/init/kafka.conf

tar zxf ${origdir}/${src_package}
cd kafka_${scala_version}-${version}
#sbt update
#sbt package
#mv config/log4j.properties config/server.properties ../build/etc/kafka
#mv * ../build/usr/lib/kafka
mv * ../build/opt/kafka
cd ../build

fpm -t deb \
    -n ${name} \
    -v ${version}${package_version} \
    --description "${description}" \
    --url="{$url}" \
    -a ${arch} \
    --category ${section} \
    --vendor "" \
    --license "${license}" \
    -m "root@localhost" \
    --prefix=/ \
    -s dir \
    -- .
mv kafka*.deb ${origdir}/..
popd
