zk="ec2-54-68-208-77.us-west-2.compute.amazonaws.com:2181,ec2-54-68-237-193.us-west-2.compute.amazonaws.com:2181,ec2-54-68-181-243.us-west-2.compute.amazonaws.com:2181"

kafka="bootstrap.servers=ec2-54-68-208-77.us-west-2.compute.amazonaws.com:9092,ec2-54-68-237-193.us-west-2.compute.amazonaws.com:9092,ec2-54-68-181-243.us-west-2.compute.amazonaws.com:9092,ec2-54-69-44-82.us-west-2.compute.amazonaws.com:9092,ec2-54-69-78-228.us-west-2.compute.amazonaws.com:9092"

#bin/kafka-topics.sh --zookeeper $zk --create --topic test-0 --partitions 16 --replication-factor 3
#bin/kafka-topics.sh --zookeeper $zk --describe --topic test-0

tests=(
"2500000 128 64000 256"
"2500000 128 64000 512"
"2500000 128 64000 1024"
"2500000 128 640000 4096"
"2500000 128 1048576 8192"
"2500000 128 2097152 16384"
"800000 256 1048576 4096"
"800000 256 2097152 8192"
"800000 256 4194304 16384"
"800000 512 2097152 4096"
"800000 512 4194304 8192"
"800000 512 8388608 16384"
"800000 1024 4194304 4096"
"800000 1024 8388608 8192"
"800000 1024 16777216 16384"
)

for var in "${tests[@]}";do
  num_of_messages=$(echo $var | cut -f 1 -d ' ')
  message_size=$(echo $var | cut -f 2 -d ' ')
  buffer_size=$(echo $var | cut -f 3 -d ' ')
  batch_size=$(echo $var | cut -f 4 -d ' ')
echo  "bin/kafka-run-class.sh org.apache.kafka.clients.tools.ProducerPerformance test-0 $num_of_messages $message_size -1 acks=1 $kafka buffer.memory=$buffer_size batch.size=$batch_size"
bin/kafka-run-class.sh org.apache.kafka.clients.tools.ProducerPerformance test-0 $num_of_messages $message_size -1 acks=1 $kafka buffer.memory=$buffer_size batch.size=$batch_size
done
