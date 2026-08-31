#!/bin/sh
set -eu

cp /keys/ec2.pem /tmp/ec2.pem
chmod 600 /tmp/ec2.pem

exec ansible-playbook "$@"
