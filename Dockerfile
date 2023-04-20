FROM mkenjis/ubjava_img

#ARG DEBIAN_FRONTEND=noninteractive
#ENV TZ=US/Central

WORKDIR /usr/local

# wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
ADD hadoop-2.7.3.tar.gz .

WORKDIR /root
RUN echo "" >>.bashrc \
 && echo 'export HADOOP_HOME=/usr/local/hadoop-2.7.3' >>.bashrc \
 && echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export YARN_HOME=$HADOOP_HOME' >>.bashrc \
 && echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' >>.bashrc \
 && echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >>.bashrc \
 && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >>.bashrc

# authorized_keys already set in ubjava_img to enable containers connect to each other via passwordless ssh

COPY create_conf_files.sh .
COPY run_hadoop.sh .
RUN chmod +x create_conf_files.sh run_hadoop.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9000

CMD ["/usr/bin/supervisord"]