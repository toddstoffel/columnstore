#### Before editing this file, be sure to read the AWS documentation on:
####
####  * VPCs
####  * Programmatic Access
####
#### Grab your enterprise token from the MariaDB website (https://customers.mariadb.com/downloads/token/).

#### EDIT THESE ITEMS

variable "mariadb_enterprise_token" {
  type    = string
  default = "YOUR_ENTERPRISE_TOKEN"
}

variable "aws_access_key" {
  type    = string
  default = "YOUR_AWS_ACCESS_KEY"
}

variable "aws_secret_key" {
  type    = string
  default = "YOUR_AWS_SECRET_KEY"
}

variable "key_pair_name" {
  type    = string
  default = "YOUR_AWS_KEY_PAIR_NAME"
}

variable "ssh_key_file" {
  type    = string
  default = "/PATH/TO/YOUR/PEM.KEY"
}

variable "aws_vpc" {
  type    = string
  default = "vpc-##########"
}

variable "aws_subnet" {
  type    = string
  default = "subnet-##########"
}

#### This allows you to work with the ColumnStore Cluster Manager API
#### The cmapi_key can be any key that you choose. One method to create a random key would be:
#### $> openssl rand -hex 32

variable "cmapi_key" {
  type    = string
  default = "YOUR_CMAPI_KEY"
}

#### DATABASE CREDENTIALS

variable "admin_user" {
  type    = string
  default = "YOUR_ADMIN_USERNAME"
}

variable "admin_pass" {
  type    = string
  default = "YOU_ADMIN_PASSWORD"
}

variable "maxscale_user" {
  type    = string
  default = "YOUR_MAXSCALE_USERNAME"
}

variable "maxscale_pass" {
  type    = string
  default = "YOUR_MAXSCALE_USER_PASS"
}

variable "cej_user" {
  type    = string
  default = "YOUR_CROSS_ENGINE_USERNAME"
}

variable "cej_pass" {
  type    = string
  default = "YOUR_CROSS_ENGINE_PASS"
}

#### DO NOT EDIT BELOW THIS POINT UNLESS YOU ARE FAMILIAR WITH THESE PARAMETERS

variable "mariadb_version" {
  type    = string
  default = "10.6"
}

variable "maxscale_version" {
  type    = string
  default = "latest"
}

variable "mariadb_port" {
  type    = string
  default = "6603"
}

variable "maxscale_port" {
  type    = string
  default = "3306"
}

#### For 1 GigE, increase set to 2500
#### For 10 GigE, increase set to 30000

variable "netdev_max_backlog" {
  type    = string
  default = "30000"
}

variable "reboot" {
  type    = bool
  default = true
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "aws_zone" {
  type    = string
  default = "us-west-2c"
}

variable "aws_ami" {
  type    = string
  default = "ami-0e3654b38a33c9ca5" #Rocky 8 x86_64
  #default = "ami-02dcd060db36cb277" #Rocky 8 aarch64
}

variable "aws_mariadb_instance_size" {
  type    = string
  default = "c6in.16xlarge"
}
