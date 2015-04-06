#bash init.sh
#bash raid10.sh
#bash java.sh
#bash kafka.sh #must run before zookeeper
#bash zookeeper.sh
#pdsh -w ^zk '/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties >/var/log/zk.std 2>&1 &'
#pdsh -w ^kafka '/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties >/var/log/kafka.std 2>&1 &'
