pdsh -w ^aws 'curl -vjkL http://www.carfab.com/apachesoftware/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz > /opt/kafka_2.10-0.8.2.1.tgz'
pdsh -w ^aws 'cd /opt/ ; tar -zxvf kafka_2.10-0.8.2.1.tgz'
pdsh -w ^aws 'cd /opt/ ; mv kafka_2.10-0.8.2.1/ kafka/'

count=0
for i in $(<aws); do
pdsh -w $i "echo 'broker.id=${count}
host.name=${i}
advertised.host.name=${i}'> /opt/kafka/config/server.properties"
count=$((count+1))
done

pdsh -w ^aws 'mkdir /data/kafka-logs'

zks="$(sed 's-$-:2181-' zk | tr '\n' ',')"
zk_connect="${zks%?}"

pdsh -w ^aws "echo 'port=9092
log.dirs=/data/kafka-logs
zookeeper.connect=${zk_connect}
# Replication configurations
num.replica.fetchers=6
replica.fetch.max.bytes=1048576
replica.fetch.wait.max.ms=500
replica.high.watermark.checkpoint.interval.ms=5000
replica.socket.timeout.ms=30000
replica.socket.receive.buffer.bytes=65536
replica.lag.time.max.ms=10000
replica.lag.max.messages=4000
controller.socket.timeout.ms=30000
controller.message.queue.size=10
# Log configuration
num.partitions=32
message.max.bytes=1000000
auto.create.topics.enable=true
log.index.interval.bytes=4096
log.index.size.max.bytes=10485760
log.retention.hours=168
log.flush.interval.ms=10000
log.flush.interval.messages=20000
log.flush.scheduler.interval.ms=2000
log.roll.hours=16
log.retention.check.interval.ms=300000
log.segment.bytes=1073741824
# ZK configuration
zk.connection.timeout.ms=6000
zk.sync.time.ms=2000
# Socket server configuration
num.io.threads=8
num.network.threads=8
socket.request.max.bytes=104857600
socket.receive.buffer.bytes=1048576
socket.send.buffer.bytes=1048576
queued.max.requests=16
fetch.purgatory.purge.interval.requests=100
producer.purgatory.purge.interval.requests=100' >>/opt/kafka/config/server.properties"


