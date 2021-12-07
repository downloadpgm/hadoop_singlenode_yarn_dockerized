# core-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$HADOOP_HOME/etc/hadoop/core-site.xml
echo '  <property>' >>$HADOOP_HOME/etc/hadoop/core-site.xml
echo '    <name>fs.default.name</name>' >>$HADOOP_HOME/etc/hadoop/core-site.xml
echo '    <value>hdfs://'${HOSTNAME}':9000</value>' >>$HADOOP_HOME/etc/hadoop/core-site.xml
echo '  </property>' >>$HADOOP_HOME/etc/hadoop/core-site.xml
echo '</configuration>' >>$HADOOP_HOME/etc/hadoop/core-site.xml

# hdfs-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '  <property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <name>dfs.replication</name>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <value>1</value>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '  </property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '  <property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <name>dfs.name.dir</name>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <value>file:///data/hadoop/hdfs/namenode</value>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '  </property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '  <property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <name>dfs.data.dir</name>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '    <value>file:///data/hadoop/hdfs/datanode</value>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo '  </property>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '</configuration>' >>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

# hadoop-env.sh (HADOOP)
# =============
echo 'export JAVA_HOME=/usr/local/jre1.8.0_181' >$HADOOP_HOME/etc/hadoop/hadoop-env.sh
chmod +x $HADOOP_HOME/etc/hadoop/hadoop-env.sh