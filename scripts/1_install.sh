sudo yum -y install docker python3
sudo service docker start
sudo usermod -aG docker $USER
sudo chkconfig docker on
