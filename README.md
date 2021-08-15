# INFRA

This terraform repo provisions an EC2 t2.micro instance in a custom VPC

## Network 

* A vpc "main"
* A subnet "main-public-1" that receives elastic IP
* An Internet Gateway
* Routing so the subnet can communicate with the IGW
* A security group "allow-ssh-http" that allows 22 and 80 for ingress, everything for egress

## Instance

* An EC2 instance with Amazon Linux 2c connected to the main-public-1 subnet in the security group allowing http and ssh ports
* start.sh as user data that install git and deploys project from https://github.com/thekindlyone/qrious-project


# Application

Source: https://github.com/thekindlyone/qrious-project
The application consists of a docker-compose of 
* flask api server
* nginx 

and a script docker_tail.py to generate the docker log file 

The install script invoked by user_data
* installs packages like iptables and docker
* sets firewall rules to disallow all incoming traffic other than 22 and 80(even though security group already enforces this)
* installs a systemd service for the project and enables it

The systemd service
* invokes docker-compose
* invokes the docker_tail script



# To Run

```bash
terraform apply
```
Variables can be input via stdin, cli options or via `tfvars` file. 

Example `tfvars` :

```
AWS_REGION     = "us-west-1"
AWS_ACCESS_KEY = "xxxxxxxxxx"
AWS_SECRET_KEY = "xxxxxxxxxx"
```



After it is ready
```bash
curl --header "Content-Type: application/json" \
  --request GET \
  --data '{"start":1628946332,"end":1628946656}' \
  http://<public ip>/api/metrics/period
```

The root endpoint `http://<public ip>/` will return a html table of the last 100 metrics recorded 

# Flaws and improvements 

* https for the apiserver
* Remove ssh key. Kept for debug purposes. terraform state file contains the privatekey currently
* sync terraform state to S3
* Since the data is timeseries metrics populated every 10 seconds, it is going to grow. Ideally this would be consumed by something like influxdb to aid storage and optimized searching.
* A metric monitoring system like this should really by implemented using prometheus/grafana or something similar
