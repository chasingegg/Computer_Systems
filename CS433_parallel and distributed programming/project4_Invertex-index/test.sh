#!/bin/sh
USER_NAME=emile
HADOOP_ROOT_PATH=../hadoop-2.7.3
HADOOP_LIB_PATH=../hadoop-2.7.3/share/hadoop

#Compile and Package the Code
javac -classpath ${HADOOP_LIB_PATH}/common/hadoop-common-2.7.3.jar:\
${HADOOP_LIB_PATH}/mapreduce/hadoop-mapreduce-client-core-2.7.3.jar:${HADOOP_LIB_PATH}/common/lib/commons-cli-1.2.jar ./InvertedIndexer.java 
jar cvf ./InvertedIndexer.jar *.class

#Clean 
rm -rf ./master_output
${HADOOP_ROOT_PATH}/bin/hadoop fs -rm -r /user/${USER_NAME}/output
${HADOOP_ROOT_PATH}/bin/hadoop fs -rm -r /input

#Upload Data
${HADOOP_ROOT_PATH}/bin/hdfs dfs -mkdir /input
${HADOOP_ROOT_PATH}/bin/hdfs dfs -put ${HADOOP_ROOT_PATH}/input/* /input

#Run the Code 
${HADOOP_ROOT_PATH}/bin/hadoop jar ./InvertedIndexer.jar InvertedIndexer /input output

${HADOOP_ROOT_PATH}/bin/hdfs dfs -get output master_output
cat ./master_output/*
