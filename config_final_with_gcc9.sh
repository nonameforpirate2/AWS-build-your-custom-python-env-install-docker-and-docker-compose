#!/bin/bash
set -e

echo "****Activating anaconda3...****"
source /home/ec2-user/anaconda3/bin/activate
echo "****updating anaconda3...****"
conda update -n base -c conda-forge conda -y
echo "****creating environment...****"
conda create --name petroleo python=3.12.3 -y
echo "****activating environment...****"
conda activate petroleo
echo "****Installing ipykernel...****"
pip install ipykernel
echo "****creating jupyter spec...****"
python -m ipykernel install --user --name=petroleo --display-name "petroleo"

echo "****Installing Docker...****"
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user

echo "****Installing Docker Compose...****"
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "****Docker and Docker Compose installed!****"
echo "****Update amazon linux os****"
sudo yum update -y
echo "****installing group development tools****"
sudo yum groupinstall "Development Tools" -y
sudo yum install -y wget tar bzip2 xz-devel gcc libmpc-devel mpfr-devel gmp-devel
echo "****installing centos-release-scl****"
sudo yum install -y centos-release-scl
echo "****swap repo centos****"
sudo yum-config-manager --disable centos-sclo-rh
echo "****rebuild repo****"
sudo tee /etc/yum.repos.d/CentOS-Vault.repo > /dev/null <<EOF
[base]
name=CentOS-7.9.2009 - Base
baseurl=http://vault.centos.org/7.9.2009/os/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-7.9.2009 - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-7.9.2009 - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

echo "****Adding CentOS SCLo Vault repos...****"
sudo tee /etc/yum.repos.d/CentOS-SCLo-Vault.repo > /dev/null <<EOF
[centos-sclo-rh]
name=CentOS-7 - SCLo rh
baseurl=http://vault.centos.org/7.9.2009/sclo/x86_64/rh/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo

[centos-sclo-sclo]
name=CentOS-7 - SCLo sclo
baseurl=http://vault.centos.org/7.9.2009/sclo/x86_64/sclo/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo
EOF

echo "****runing clean all****"
sudo yum clean all
echo "****run makecache****"
sudo yum makecache
echo "****reinstalling centos release****"
sudo yum install -y centos-release-scl
echo "****installing devtoolset-9****"
sudo yum install -y devtoolset-9
echo "****enable devtoolset-9****"
scl enable devtoolset-9 bash
echo "****check gcc version working****"
gcc --version