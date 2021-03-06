#!/bin/bash
# platform = Red Hat Enterprise Linux 8,multi_platform_fedora,Oracle Linux 8,multi_platform_sle

# Check rsyslog.conf with root group-owner log from rules and
# root group-owner log from include() passes.

source $SHARED/rsyslog_log_utils.sh

GROUP=root

# setup test data
create_rsyslog_test_logs 2

# setup test log files ownership
chgrp $GROUP ${RSYSLOG_TEST_LOGS[0]}
chgrp $GROUP ${RSYSLOG_TEST_LOGS[1]}

# create test configuration file
test_conf=${RSYSLOG_TEST_DIR}/test1.conf
cat << EOF > ${test_conf}
# rsyslog configuration file

#### RULES ####

*.*     ${RSYSLOG_TEST_LOGS[1]}
EOF

# create rsyslog.conf configuration file
cat << EOF > $RSYSLOG_CONF
# rsyslog configuration file

#### RULES ####

*.*     ${RSYSLOG_TEST_LOGS[0]}

#### MODULES ####

include(file="${test_conf}")
EOF
