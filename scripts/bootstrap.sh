#!/bin/bash
# Must be run as root (e.g. sudo ./bootstrap.sh <hostname>)

NEW_HOSTNAME=$1

if [ -z "$NEW_HOSTNAME" ]; then
  echo "Usage: sudo ./bootstrap.sh <hostname>"
  exit 1
fi

echo "==> Setting hostname to $NEW_HOSTNAME"
hostnamectl set-hostname $NEW_HOSTNAME

echo "==> Updating system packages"
apt-get update -y

echo "==> Installing basic system tools"
apt-get install -y htop curl wget unzip software-properties-common python3 python3-pip

echo "==> Creating 2GB Swap space (CRITICAL for t3.micro so Jenkins doesn't crash)"
if [ ! -f /swapfile ]; then
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
    echo "Swap created!"
else
    echo "Swapfile already exists."
fi

echo "==> Bootstrap complete for $NEW_HOSTNAME"
