version = $1

# Prepare puppetlabs repo
echo "packer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/packer
chmod 440 /etc/sudoers.d/packer

if [ ! -f puppetlabs-release-${version}.deb ]
then
    wget http://apt.puppetlabs.com/puppetlabs-release-${version}.deb
fi

dpkg -i puppetlabs-release-${version}.deb
apt-get update

# Install puppet/facter
apt-get install -y puppet facter
