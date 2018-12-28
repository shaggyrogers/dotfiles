###############################################################################
#
# start_digitalocean_sshfs.sh
# ===========================
#
# Description:              Unmount the digitalocean server.
# Author:                   Michael De Pasquale
# Creation Date:            2018-12-12
# Modification Date:        2018-12-12
#
###############################################################################

# Create directory if it does not exist
if ! fusermount -u ~/digitalocean 2> /dev/null; then
    echo "Failed!"
else
    echo "success"
    rmdir ~/digitalocean
fi

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
