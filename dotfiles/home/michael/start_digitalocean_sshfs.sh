###############################################################################
#
# start_digitalocean_sshfs.sh
# ===========================
#
# Description:              Mount the digitalocean server over ssh.
# Author:                   Michael De Pasquale
# Creation Date:            2018-12-12
# Modification Date:        2019-08-29
#
###############################################################################


# Create directory if it does not exist
if ! [ -d ~/digitalocean ]; then
    mkdir -p ~/digitalocean
fi

# Mount - cache, enable large reads/writes, use fast (insecure!) cipher
# and reconnect automatically
if ! sshfs \
        -o reconnect digitalocean:/ ~/digitalocean 2>/dev/null \
        -o cache=yes,auto_cache,kernel_cache \
        -o large_read,big_writes \
        ; then
    echo "failed!"
fi

# -o Ciphers=arcfour

# vim: set ts=4 sw=4 tw=79 fdm=manual et :
