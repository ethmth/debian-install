# Login as root

# Update packages
apt update && apt upgrade -y

# Install and enable systemd-homed
apt install systemd-homed cryptsetup -y
systemctl enable --now systemd-homed

# Create a user
homectl create e \
  --storage=luks \
  --shell=/bin/bash \
  --member-of=sudo


# Temporarily enable ssh password authentication so you can login to the user account
vim /etc/ssh/sshd_config # PasswordAuthentication yes
vim /etc/ssh/sshd_config.d/50-cloud-init.conf # PasswordAuthentication yes
systemctl restart sshd

# Then, re-login to user account

# Setup ssh key authentication
mkdir ~/.ssh
vim ~/.ssh/authorized_keys

# Logout and log back in

# Re-disable ssh password authentication
sudo vim /etc/ssh/sshd_config # PasswordAuthentication no
sudo vim /etc/ssh/sshd_config.d/50-cloud-init.conf # PasswordAuthentication no
systemctl restart sshd

# Harden SSH
sudo sh -c "echo 'PermitRootLogin no' > /etc/ssh/sshd_config.d/10-disable-root.conf"
sudo systemctl restart sshd

# In the VPS console, block all traffic except SSH (22), HTTP (80), and HTTPS (443)

# Install git and clone this repository
sudo apt install fzf jq yq git curl wget -y
mkdir -p ~/programs
git clone https://github.com/ethmth/debian-install ~/programs/debian-install