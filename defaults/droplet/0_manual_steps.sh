# Login as root

# Update packages
apt update && apt upgrade -y

# Install and enable systemd-homed
apt install fzf jq yq git curl wget systemd-homed cryptsetup -y
systemctl enable --now systemd-homed

# Create a user
homectl create e \
  --storage=luks \
  --disk-size=10G \
  --shell=/bin/bash \
  --member-of=sudo


# Temporarily enable ssh password authentication so you can login to the user account
rm /etc/ssh/sshd_config.d/50-cloud-init.conf
vim /etc/ssh/sshd_config # PasswordAuthentication yes
systemctl restart sshd

# Then, re-login to user account

# Setup ssh key authentication
mkdir ~/.ssh
vim ~/.ssh/authorized_keys

# While logged in as e, run this as root in a separate terminal:
homectl update e --ssh-authorized-keys=/home/e/.ssh/authorized_keys

# Logout and log back in

# In the VPS console, block all traffic except SSH (22), HTTP (80), and HTTPS (443)

# clone this repository
mkdir -p ~/programs
git clone https://github.com/ethmth/debian-install ~/programs/debian-install