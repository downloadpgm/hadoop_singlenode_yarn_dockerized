export JAVA_HOME=/usr/local/jre1.8.0_181
export CLASSPATH=$JAVA_HOME/lib
export PATH=$PATH:.:$JAVA_HOME/bin

export HADOOP_HOME=/usr/local/hadoop-2.7.3
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

service ssh start

echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
ssh-keyscan ${HOSTNAME} >~/.ssh/known_hosts

# create the hadoop conf files
create_conf_files.sh

# if a new hadoop cluster, build a HDFS
# if restarted from previous hadoop cluster run, preserve HDFS
if [ ! -f /hadoop/hdfs/namenode/current/VERSION ]; then
 $HADOOP_HOME/bin/hdfs namenode -format
fi

$HADOOP_HOME/sbin/start-dfs.sh 