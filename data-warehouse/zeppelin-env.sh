    export SPARK_HOME=/opt/spark                             # (required) When it is defined, load it instead of Zeppelin embedded Spark libraries
    export SPARK_SUBMIT_OPTIONS="--conf \"hive.security.authorization.enabled=false\" --conf \"spark.driver.extraJavaOptions=-XX:+UseG1GC\" --conf \"spark.executor.extraJavaOptions=-XX:+UseG1GC\" "                   # (optional) extra options to pass to spark submit. eg) "--driver-memory 512M --executor-memory 1G".
    export SPARK_APP_NAME=Zeppelin                         # (optional) The name of spark application.
    export ZEPPELIN_INTP_CLASSPATH_OVERRIDES=/opt/db2jcc4.jar:/jars/additional/*:/jars/parquet/*
    echo "----Zeppelin env start----"
    env
    echo "----Zeppelin env stop-----"