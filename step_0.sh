#!/bin/bash

# Download
# - Web
# - Cloud Connectors
# - JDBC
# - MySQL
# - H2

set -x

cf login -a api.run.pivotal.io -o NY -s micah -u myoung@pivotal.io

cf delete -f twelve-factor

cf delete-service -f twelve-factor-mysql

