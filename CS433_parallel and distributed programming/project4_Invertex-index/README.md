# How to run the code

1. Run command below to make sure you have start the service:

````shell
./bin/hdfs namenode -format
./sbin/start-all.sh
````

2. Extra the Project directory in the same folder with `hadoop-2.7.3`
3. Edit the file `test.sh` file to set the `UserName` you login in, `HADOOP_ROOT_PATH` and `HADOOP_LIB_PATH` If the version of `hadoop` you use is not `2.7.3`, please change the version number in the `test.sh` file to your version
4. Put the file you want to index in `hadoop-2.7.3/input`, if you don't have the directory, create it.
5. `cd`into the project file, and run `./test.sh`.
6. Check the result from the terminal or `${ProjectRoot}/master_output/`

