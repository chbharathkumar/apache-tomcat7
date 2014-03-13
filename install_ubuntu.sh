#/bin/bash
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi
clear

echo "========================================================================="
echo "HSP Viet Nam - Apache Tomcat7 For Ubuntu "
echo "========================================================================="
echo "Script Cai Dat Tomcat 7.0.52 "
echo "Dia Chi Lien He: HSP Viet Nam - Tang 7 toan nha HL - Ngo 82 Duy Tan - Cau Giay - Ha Noi"
echo ""
echo "========================================================================="
echo "=                                                                       ="
echo "=                          Dang Cai dat                                 ="
echo "=                                                                       ="
echo "========================================================================="
tm=`pwd`
apt-get -y install apache2
apt-get -y install openjdk-7-jdk
mkdir -p /var/lock/subsys
touch /var/lock/subsys/tomcat7
mv apache-tomcat-7 /var/www/tomcat7
mv tomcat7_ubuntu.sh /etc/init.d/tomcat7
useradd -d /var/www/tomcat7/ tomcat
chown -R tomcat. /var/www/tomcat7/
chmod -R 0755 /var/www/tomcat7/
chmod 755 /etc/init.d/tomcat7
service tomcat7 start
chkconfig --add tomcat7
chkconfig tomcat7 on
ufw enable
	iptables -P INPUT ACCEPT
	iptables -P FORWARD ACCEPT
	iptables -P OUTPUT ACCEPT
	 
	# Set the nat/mangle/raw tables' chains to ACCEPT
	iptables -t nat -P PREROUTING ACCEPT
	iptables -t nat -P OUTPUT ACCEPT
	iptables -t nat -P POSTROUTING ACCEPT
	 
	iptables -t mangle -P PREROUTING ACCEPT
	iptables -t mangle -P INPUT ACCEPT
	iptables -t mangle -P FORWARD ACCEPT
	iptables -t mangle -P OUTPUT ACCEPT
	iptables -t mangle -P POSTROUTING ACCEPT
	 
	# Cleanup.
	#------------------------------------------------------------------------------
	 
	# Delete all
	iptables -F
	iptables -t nat -F
	iptables -t mangle -F
	 
	# Delete all
	iptables -X
	iptables -t nat -X
	iptables -t mangle -X
	 
	# Zero all packets and counters.
	iptables -Z
	iptables -t nat -Z
	iptables -t mangle -Z
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080
iptables -t nat -A PREROUTING -p udp -m udp --dport 80 -j REDIRECT --to-ports 8080
iptables -A INPUT -p tcp -m tcp --dport 80 -j LOG 
iptables -A INPUT -p tcp -m tcp --dport 8080 -j LOG
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
iptables -A INPUT -p icmp -j ACCEPT 
iptables -A INPUT -i lo -j ACCEPT 
iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m state --state NEW -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited 
iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited 
echo "========================================================================="
echo "=                                                                       ="
echo "=         Chuong Trinh Da Duoc Cai Dat Thanh Cong                       ="
echo "=            De Chay Lai Chuong Trinh hay Go                            ="
echo "=             Apache Tomcat Version 7.0.52                              ="
echo "=       Thu Muc Apache Tomcat7: /var/www//tomcat7                   ="
echo "=            Default manager admin: admin/123456                        ="
echo "=              service tomcat7 restart                                  ="
echo "=                      HSP Viet Nam                                     ="
echo "=                                                                       ="
echo "=                                                                       ="
echo "========================================================================="