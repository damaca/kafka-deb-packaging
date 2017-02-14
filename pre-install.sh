#!/bin/bash
BIN_USERADD=`/usr/bin/which useradd`
$BIN_USERADD -d /opt/kafka -s /bin/bash kafka
