bin/kafka-topics.sh --zookeeper $zk --describe --topic test 2>/dev/null

[2015-02-21 08:17:58,704] WARN Connected to an old server; r-o mode will be unavailable (org.apache.zookeeper.ClientCnxnSocket)
Topic:test      PartitionCount:1        ReplicationFactor:3     Configs:
Topic: test     Partition: 0    Leader: 2       Replicas: 2,0,1 Isr: 2,0,1

export zk="ip-172-30-1-47.us-west-2.compute.internal:2181,ip-172-30-1-46.us-west-2.compute.internal:2181,ip-172-30-1-49.us-west-2.compute.internal:2181"
