###############################################################################
#
# start_delugeweb_tunnel.sh
# =========================
#
# Description:              Creates a tunnel for a remote deluge web UI.
# Author:                   Michael De Pasquale
# Creation Date:            2018-12-11
# Modification Date:        2020-02-23
#
###############################################################################

# Check for existing instance
printf "Checking for existing instances..." 2>&1
NUM_INSTANCES=$(ps -u michael -o command | grep "^ssh -CfN -L 8008:localhost:8008" | wc -l)

if [ "$NUM_INSTANCES" = "1" ]; then
    printf "already running!\n" 2>&1
    exit 1
else
    printf "none found.\n" 2>&1
    printf "Starting...\n" 2>&1

    # Start deluge-web tunnel
    ssh -CfN -L 8008:localhost:8008 digitalocean
    echo "Done." 2>&1
    exit 0
fi

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
