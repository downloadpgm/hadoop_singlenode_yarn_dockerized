# Single Hadoop HDFS Node in Docker

HDFS is a distributed file system that handles large data sets running on commodity hardware. 
It is used to scale a single Apache Hadoop cluster to hundreds (and even thousands) of nodes.

## Build Hadoop image
```shell
$ git clone https://github.com/mkenjis/apache_binaries
$ wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
$ docker image build -t mkenjis/ubhdp_img .
$ docker login   # provide user and password
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

## Check HDFS and Load Files

1. start hadoop container from Docker image
```shell
$ docker container run -d --name hadoop mkenjis/ubhdp_img
$ docker container ls
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS      NAMES
01f9173ab34a   mkenjis/ubhdp_img   "/usr/bin/supervisord"   32 seconds ago   Up 31 seconds   9000/tcp   hadoop
$ docker container exec -it <hdp ID> bash
```

2. access hadoop container and check HDFS service
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

3. create HDFS directory and copy files in this directory
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