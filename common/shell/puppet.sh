version = $1

# Prepare puppetlabs repo
echo "packer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/packer
chmod 440 /etc/sudoers.d/packer

wget http://apt.puppetlabs.com/puppetlabs-release-${version}.deb
dpkg -i puppetlabs-release-${version}.deb
apt-get update

# Install puppet/facter
apt-get install -y puppet facter
