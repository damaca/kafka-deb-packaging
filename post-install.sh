#!/bin/bash
mkdir /var/lib/kafka
mkdir /var/run/kafka
chown -R kafka:kafka /opt/kafka* /var/lib/kafka /var/log/kafka
