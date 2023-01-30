![MariaDB](https://mariadb.com/wp-content/uploads/2019/11/mariadb-logo_blue-transparent.png)

# MariaDB Enterprise Server with ColumnStore Engine & MaxScale Proxy

## About:

MariaDB ColumnStore is a columnar storage engine that utilizes a massively parallel distributed data architecture. It's a columnar storage system built by porting InfiniDB 4.6.7 to MariaDB, and released under the GPL license.

It is designed for big data scaling to process petabytes of data, linear scalability and exceptional performance with real-time response to analytical queries. It leverages the I/O benefits of columnar storage, compression, just-in-time projection, and horizontal and vertical partitioning to deliver tremendous performance when analyzing large data sets.

This is a [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/) project to provision a single node [MariaDB ColumnStore](https://mariadb.com/docs/features/mariadb-enterprise-columnstore/#mariadb-enterprise-columnstore) deployment on [Amazon Web Services](https://aws.amazon.com/).

## Features:

This super charged deployment will create a MariaDB ColumnStore instance that supports both analytics and transcational operations. It is fronted by a MaxScale listener that will serve as the endpoint for your client connections. The addition of MaxScale allows for [query cacheing](https://mariadb.com/kb/en/mariadb-maxscale-2208-cache/#overview) and a myriad of other advanced [options](https://mariadb.com/kb/en/mariadb-maxscale-2208/).

## Prerequisites:

*   [Amazon Web Services (AWS) Account](https://aws.amazon.com/)
*   [Install Terraform](https://www.terraform.io) *<sup>†</sup>*
*   [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-with-pip) *<sup>‡</sup>*
*   [MariaDB Enterprise Token](https://customers.mariadb.com/downloads/token/)

*<sup>†</sup> Requires Terraform v0.14.4 or above.*  
*<sup>‡</sup> Requires Full Ansible 2.10.5 or above. (Not Ansible-Core)*

## Instructions:

Open a terminal window and clone the repository:

1.  `git clone https://github.com/mariadb-corporation/columnstore-ansible.git`
2.  `cd` into the newly cloned folder
3.  Edit [variables.tf](variables.tf) and supply your own variables.
4.  `terraform init`
5.  `terraform plan` (Optional)
6.  `terraform apply --auto-approve`
7.  `ansible-playbook provision.yml`

Further information can be found on our [official deployment guide](https://mariadb.com/docs/server/deploy/topologies/single-node/enterprise-columnstore-es10-6-local/).

## Current Approved AWS Image(s)

|AMI OS|AMI ID|Region|Architecture|
|---|---|---|---|
|Rocky8|ami-0e3654b38a33c9ca5|us-west-2|x86_64|
|Rocky8|ami-02dcd060db36cb277|us-west-2|aarch64|

## MCS Command-line Instructions

From your primary node:

##### Set API Code:

``` mcs cluster set api-key --key <api_key>```

###### Get Status:

```mcs cluster status```

###### Start Cluster:

```mcs cluster start```

###### Stop Cluster:

```mcs cluster stop```

###### Add Node:

```mcs cluster node add --node <node>```

###### Remove Node:

```mcs cluster node remove --node <node>```

###### Mode Set Read Only:

```mcs cluster set mode --mode readonly```

###### Mode Set Read/Write:

```mcs cluster set mode --mode readwrite```

## Other CLI Tools

*   `core`  Change directory to /var/log/mariadb/columnstore/corefiles
*   `dbrm` Change directory to /var/lib/columnstore/data1/systemFiles/dbrm
*   `extentSave` Backup extent map
*   `tcrit` Tail crit.log
*   `tdebug` Tail debug.log
*   `terror` Tail error.log
*   `tinfo` Tail info.log
*   `twarning` Tail warning.log


## REST-API Instructions

##### Format of url endpoints for REST API:

```perl
https://{server}:{port}/cmapi/{version}/{route}/{command}
```

##### Examples urls for available endpoints:

*   `https://127.0.0.1:8640/cmapi/0.4.0/cluster/status`
*   `https://127.0.0.1:8640/cmapi/0.4.0/cluster/start`
*   `https://127.0.0.1:8640/cmapi/0.4.0/cluster/shutdown`
*   `https://127.0.0.1:8640/cmapi/0.4.0/cluster/node`
*   `https://127.0.0.1:8640/cmapi/0.4.0/cluster/mode-set`

##### Request Headers Needed:

*   'x-api-key': 'somekey123'
*   'Content-Type': 'application/json'

<sub>**Note:** x-api-key can be set to any value of your choice during the first call to the server. Subsequent connections will require this same key</sub>

##### Examples using curl:

###### Get Status:
```
$ curl -s https://127.0.0.1:8640/cmapi/0.4.0/cluster/status --header 'Content-Type:application/json' --header 'x-api-key:somekey123' -k | jq .
```
###### Start Cluster:
```
$ curl -s -X PUT https://127.0.0.1:8640/cmapi/0.4.0/cluster/start --header 'Content-Type:application/json' --header 'x-api-key:somekey123' --data '{"timeout":20}' -k | jq .
```
###### Stop Cluster:
```
$ curl -s -X PUT https://127.0.0.1:8640/cmapi/0.4.0/cluster/shutdown --header 'Content-Type:application/json' --header 'x-api-key:somekey123' --data '{"timeout":20}' -k | jq .
```
###### Add Node:
```
$ curl -s -X PUT https://127.0.0.1:8640/cmapi/0.4.0/cluster/node --header 'Content-Type:application/json' --header 'x-api-key:somekey123' --data '{"timeout":20, "node": "<replace_with_desired_hostname>"}' -k | jq .
```
###### Remove Node:
```
$ curl -s -X DELETE https://127.0.0.1:8640/cmapi/0.4.0/cluster/node --header 'Content-Type:application/json' --header 'x-api-key:somekey123' --data '{"timeout":20, "node": "<replace_with_desired_hostname>"}' -k | jq .
```

###### Mode Set:
```
$ curl -s -X PUT https://127.0.0.1:8640/cmapi/0.4.0/cluster/mode-set --header 'Content-Type:application/json' --header 'x-api-key:somekey123' --data '{"timeout":20, "mode": "readwrite"}' -k | jq .
```