#!/bin/bash
# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_sle

# Check if log file with root group-owner in rsyslog.conf passes.

source $SHARED/rsyslog_log_utils.sh

GROUP=root

# setup test data
create_rsyslog_test_logs 1

# setup test log file ownership
chgrp $GROUP ${RSYSLOG_TEST_LOGS[0]}

# add rule with root group owned log file
cat << EOF > $RSYSLOG_CONF
# rsyslog configuration file

#### RULES ####

*.*        ${RSYSLOG_TEST_LOGS[0]}

EOF
