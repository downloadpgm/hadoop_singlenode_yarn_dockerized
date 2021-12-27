# Single Hadoop HDFS Node in Docker

HDFS is a distributed file system that handles large data sets running on commodity hardware. 
It is used to scale a single Apache Hadoop cluster to hundreds (and even thousands) of nodes.

## Steps to Build Hadoop image
```shell
$ git clone https://github.com/mkenjis/apache_binaries
$ wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
$ docker image build -t mkenjis/ubhdp_img
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: mkenjis
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
$ docker image push mkenjis/ubhdp_img
```

## Shell Scripts Inside 

> run_hadoop.sh

Sets up the environment for the HDFS single node by executing the following steps :
- sets environment variables for HADOOP and YARN
- starts the SSH service and scans local IPs for passwordless SSH
- initializes the HDFS filesystem
- starts Hadoop Name node and Data nodes

> create_conf_files.sh

Creates the following Hadoop files $HADOOP/etc/hadoop directory :
- core-site.xml
- hdfs-site.xml
- hadoop-env.sh

## Validating HDFS and Loading Files Example

Start the Hadoop container from Docker image
```shell
$ docker container run -d --name hadoop mkenjis/ubhdp_img
Unable to find image 'mkenjis/ubhdp_img:latest' locally
latest: Pulling from mkenjis/ubhdp_img
7b1a6ab2e44d: Pull complete 
27f2d79f1b8f: Pull complete 
80321c48ace2: Pull complete 
2baf076bbe66: Pull complete 
2c2dbd2b3e13: Pull complete 
8d4d85d2eb30: Pull complete 
e28982977efb: Pull complete 
73f8ab362867: Pull complete 
04fce0ebbc88: Pull complete 
1a88a32438cf: Pull complete 
c4745550d4c9: Pull complete 
Digest: sha256:ebd7b67aa9532585525076d419be6ef777b5e778132cb2fe3b619860bb4b3b6b
Status: Downloaded newer image for mkenjis/ubhdp_img:latest
01f9173ab34aa991cbef81daade583600fbce9f5e2d46b7281a6242179720913
$ docker container ls
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS      NAMES
01f9173ab34a   mkenjis/ubhdp_img   "/usr/bin/supervisord"   32 seconds ago   Up 31 seconds   9000/tcp   hadoop
$ docker container exec -it <container ID> bash
```

Inside the Hadoop container, check your HDFS service
```shell
$ hdfs dfsadmin -report
Configured Capacity: 5000003584 (4.66 GB)
Present Capacity: 4124946432 (3.84 GB)
DFS Remaining: 4124942336 (3.84 GB)
DFS Used: 4096 (4 KB)
DFS Used%: 0.00%
Under replicated blocks: 0
Blocks with corrupt replicas: 0
Missing blocks: 0
Missing blocks (with replication factor 1): 0

-------------------------------------------------
Live datanodes (1):

Name: 172.17.0.2:50010 (01f9173ab34a)
Hostname: 01f9173ab34a
Decommission Status : Normal
Configured Capacity: 5000003584 (4.66 GB)
DFS Used: 4096 (4 KB)
Non DFS Used: 875057152 (834.52 MB)
DFS Remaining: 4124942336 (3.84 GB)
DFS Used%: 0.00%
DFS Remaining%: 82.50%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 1
Last contact: Tue Dec 07 14:10:03 CST 2021
```

Create a directory in HDFS filesystem and copy text files in this directory
```shell
$ hdfs dfs -ls /
$ hdfs dfs -mkdir /data
$ hdfs dfs -ls /
Found 1 items
drwxr-xr-x   - root supergroup          0 2021-12-06 17:49 /data
$ cd $HADOOP_HOME   # it changes to /usr/local/hadoop-2.7.3
$ ls -l
total 108
-rw-r--r-- 1 root root 84854 Aug 17  2016 LICENSE.txt
-rw-r--r-- 1 root root 14978 Aug 17  2016 NOTICE.txt
-rw-r--r-- 1 root root  1366 Aug 17  2016 README.txt
drwxr-xr-x 2 root root   194 Aug 17  2016 bin
drwxr-xr-x 1 root root    20 Aug 17  2016 etc
drwxr-xr-x 2 root root   106 Aug 17  2016 include
drwxr-xr-x 3 root root    20 Aug 17  2016 lib
drwxr-xr-x 2 root root   239 Aug 17  2016 libexec
drwxr-xr-x 2 root root   327 Dec  6 17:47 logs
drwxr-xr-x 2 root root  4096 Aug 17  2016 sbin
drwxr-xr-x 4 root root    31 Aug 17  2016 share
$ hdfs dfs -put *.txt /data
$ hdfs dfs -ls /data
Found 3 items
-rw-r--r--   2 root supergroup      84854 2021-12-06 17:50 /data/LICENSE.txt
-rw-r--r--   2 root supergroup      14978 2021-12-06 17:50 /data/NOTICE.txt
-rw-r--r--   2 root supergroup       1366 2021-12-06 17:50 /data/README.txt
```