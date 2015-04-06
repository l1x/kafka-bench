pdsh -w ec2-52-10-202-243.us-west-2.compute.amazonaws.com 'echo "broker.id=0
host.name=ip-172-30-1-47.us-west-2.compute.internal
advertised.host.name=ip-172-30-1-47.us-west-2.compute.internal"> /mnt/md0/kafka/config/server.properties'

pdsh -w ec2-52-10-202-203.us-west-2.compute.amazonaws.com 'echo "broker.id=1
host.name=ip-172-30-1-46.us-west-2.compute.internal
advertised.host.name=ip-172-30-1-46.us-west-2.compute.internal"> /mnt/md0/kafka/config/server.properties'

pdsh -w ec2-52-10-202-179.us-west-2.compute.amazonaws.com 'echo "broker.id=2
host.name=ip-172-30-1-49.us-west-2.compute.internal
advertised.host.name=ip-172-30-1-49.us-west-2.compute.internal"> /mnt/md0/kafka/config/server.properties'

pdsh -w ^zk 'echo "port=9092
log.dirs=/mnt/md0/kafka_data
zookeeper.connect=ip-172-30-1-47.us-west-2.compute.internal:2181,ip-172-30-1-46.us-west-2.compute.internal:2181,ip-172-30-1-49.us-west-2.compute.internal:2181
# Replication configurations
num.replica.fetchers=8
replica.fetch.max.bytes=1048576
replica.fetch.wait.max.ms=500
replica.high.watermark.checkpoint.interval.ms=5000
replica.socket.timeout.ms=30000
replica.socket.receive.buffer.bytes=65536
replica.lag.time.max.ms=10000
replica.lag.max.messages=4000
controller.socket.timeout.ms=30000
controller.message.queue.size=32
# Log configuration
num.partitions=8
message.max.bytes=1000000
auto.create.topics.enable=true
log.index.interval.bytes=4096
log.index.size.max.bytes=10485760
log.retention.hours=16
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
num.io.threads=16
num.network.threads=32
socket.request.max.bytes=104857600
socket.receive.buffer.bytes=1048576
socket.send.buffer.bytes=1048576
queued.max.requests=16
fetch.purgatory.purge.interval.requests=100
producer.purgatory.purge.interval.requests=100" >>/mnt/md0/kafka/config/server.properties'


