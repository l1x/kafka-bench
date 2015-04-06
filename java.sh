pdsh -w ^aws 'curl -vjkL -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm > jdk-8u31-linux-x64.rpm'
pdsh -w ^aws 'rpm -i jdk-8u31-linux-x64.rpm'
pdsh -w ^aws 'java -version'
