#!/bin/bash
echo "ESto es una prueba" >> /tmp/prueba
BIN_USERADD=`/usr/bin/which useradd`
$BIN_USERADD -d /opt/kafka -s /bin/bash kafka
echo "ESto es otra prueba" >> /tmp/prueba
