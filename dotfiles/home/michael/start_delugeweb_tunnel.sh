###############################################################################
#
# start_delugeweb_tunnel.sh
# =========================
#
# Description:              Creates a tunnel for a remote deluge web UI.
# Author:                   Michael De Pasquale
# Creation Date:            2018-12-11
# Modification Date:        2018-12-11
#
###############################################################################

# Check for existing instance
NUM_INSTANCES=$(ps -u michael -o command | grep "^ssh -CfN -L 8008:localhost:8008" | wc -l)

if [ "$NUM_INSTANCES" = "1" ]; then
    echo "Already running."
else
    # Start deluge-web tunnel
    ssh -CfN -L 8008:localhost:8008 digitalocean
    echo "Done."
fi

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
