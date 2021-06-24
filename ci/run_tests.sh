#!/usr/bin/env bash
set -e

WARNINGS="-Werror -Wall -Wextra -Wformat -Werror=format-security"
WARNINGS_DISABLED="-Wno-unused-parameter -Wno-implicit-fallthrough -Wno-unknown-warning-option -Wno-cast-function-type"

# Standard flags, as we might build PostGIS for production
CFLAGS="-g -O2 -mtune=generic -fno-omit-frame-pointer ${WARNINGS} ${WARNINGS_DISABLED}"
#LDFLAGS="-Wl,-Bsymbolic-functions -Wl,-z,relro"

export CUNIT_WITH_VALGRIND=YES
export CUNIT_VALGRIND_FLAGS="--leak-check=full --error-exitcode=1"

/usr/local/pgsql/bin/pg_ctl -c -l /tmp/logfile -o '-F' start

# Standard build

make
make install
make installcheck


