#!/bin/bash
# ============================================================
# DevOps Project 01 — Ubuntu Application Server Setup
# Author: Abdul Haseeb
# GitHub: https://github.com/haseebspaniard
# Medium: https://medium.com/@haseebabdul480
# Description: Installs Java + Apache Tomcat as a persistent
#              systemd service on Ubuntu
# ============================================================

set -e  # Exit immediately if any command fails

echo "=============================="
echo " STEP 1: Updating system..."
echo "=============================="
sudo apt update

echo "=============================="
echo " STEP 2: Installing Java 17..."
echo "=============================="
sudo apt install openjdk-17-jdk -y
java -version

echo "=============================="
echo " STEP 3: Creating tomcat user..."
echo "=============================="
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat

echo "=============================="
echo " STEP 4: Downloading Tomcat..."
echo "=============================="
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.55/bin/apache-tomcat-10.1.55.tar.gz
tar -xzf apache-tomcat-10.1.55.tar.gz
sudo mv apache-tomcat-10.1.55 /opt/tomcat/
sudo ln -s /opt/tomcat/apache-tomcat-10.1.55 /opt/tomcat/latest

echo "=============================="
echo " STEP 5: Configuring permissions..."
echo "=============================="
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

echo "=============================="
echo " STEP 6: Creating systemd service..."
echo "=============================="
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "=============================="
echo " STEP 7: Starting Tomcat..."
echo "=============================="
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat

echo "=============================="
echo " STEP 8: Configuring firewall..."
echo "=============================="
sudo ufw allow 8080/tcp
sudo ufw status

echo "=============================="
echo " ✅ DONE! Open: http://localhost:8080"
echo "=============================="
