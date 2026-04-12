# Login as root

# Update packages
apt update && apt upgrade -y

# Install needed packages
apt install fzf jq yq git curl wget ecryptfs-utils cryptsetup -y

# NOTE: if you're tempted to switch to systemd-homed (homectl) for home encryption, consider this:
# systemd-homed will automatically re-encrypt your home directory when you log out, which is a major no-go for servers.
# as of the time of writing, there's not a good way to get around that (that I've found).
# Lingering is completely broken with systemd-homed: https://github.com/systemd/systemd/issues/34151

# Temporarily enable ssh password authentication so you will be able to login to the user account
rm /etc/ssh/sshd_config.d/50-cloud-init.conf
vim /etc/ssh/sshd_config # PasswordAuthentication yes
systemctl restart sshd

# Create a user
useradd -s /bin/bash -m -G sudo e
passwd e
ecryptfs-migrate-home -u e

# Login to e (DON'T REBOOT FIRST)

# Then, re-login to user account

# Setup ssh key authentication
mkdir ~/.ssh
vim ~/.ssh/authorized_keys

# Logout and log back in

# In the VPS console, block all traffic except SSH (22), HTTP (80), and HTTPS (443)

# clone this repository
mkdir -p ~/programs
git clone https://github.com/ethmth/debian-install ~/programs/debian-install