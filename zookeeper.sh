OIFS="$IFS"; IFS=$'\n'; zk_nodes=($(<zk)); IFS="$OIFS"

echo $zk_nodes

pdsh -w ^zk "echo 'dataDir=/data/zk-data
maxClientCnxns=0
clientPort=2181
tickTime=2000
initLimit=5
syncLimit=2
server.0="${zk_nodes[0]}":2888:3888
server.1="${zk_nodes[1]}":2888:3888
server.2="${zk_nodes[2]}":2888:3888' > /opt/kafka/config/zookeeper.properties"

pdsh -w ^zk 'mkdir /data/zk-data'

count=0
for i in $(<zk); do
  pdsh -w $i "echo ${count} > /data/zk-data/myid"
  count=$((count+1))
done

