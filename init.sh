for h in $(<aws); do ssh-keyscan -H $h >> ~/.ssh/known_hosts ; done
for h in $(<aws); do ssh -tt centos@$h 'sudo cp /home/centos/.ssh/authorized_keys /root/.ssh/authorized_keys' ; done
pdsh -w ^aws 'echo "net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_max_syn_backlog = 3240000
net.core.somaxconn = 65535
net.ipv4.tcp_max_tw_buckets = 1440000
net.core.rmem_default = 8388608
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_rmem = 4096 87380 33554432
net.ipv4.tcp_wmem = 4096 87380 33554432
net.ipv4.tcp_congestion_control = cubic
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 409600
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_orphans = 262144
net.ipv4.tcp_mtu_probing=1
" > /etc/sysctl.d/99-sysctl.conf'
pdsh -w ^aws 'sysctl -p /etc/sysctl.d/99-sysctl.conf'
pdsh -w ^aws 'echo "* soft nofile 102400
* hard nofile 102400
* soft nproc 10240
* hard nproc 10240" > /etc/security/limits.conf'
pdsh -w ^aws 'rm -f /etc/security/limits.d/*'
pdsh -w ^aws 'yum clean all'
pdsh -w ^aws 'yum install vim wget curl epel-release bind-utils traceroute -y'
pdsh -w ^aws 'yum update -y'
pdsh -w ^aws 'reboot'
