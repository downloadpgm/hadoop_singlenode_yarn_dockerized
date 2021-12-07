# Single Hadoop HDFS Node in Docker

HDFS is a distributed file system that handles large data sets running on commodity hardware. 
It is used to scale a single Apache Hadoop cluster to hundreds (and even thousands) of nodes.

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