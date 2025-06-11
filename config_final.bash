#!/bin/bash
set -e

echo "Activating anaconda3..."
source /home/ec2-user/anaconda3/bin/activate
echo "updating anaconda3..."
conda update -n base -c conda-forge conda -y
echo "creating environment..."
conda create --name petroleo python=3.12.3 -y
echo "activating environment..."
conda activate petroleo
echo "Installing ipykernel..."
pip install ipykernel
echo "creating jupyter spec..."
python -m ipykernel install --user --name=petroleo --display-name "petroleo"

echo "Installing Docker..."
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user

echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker and Docker Compose installed!"