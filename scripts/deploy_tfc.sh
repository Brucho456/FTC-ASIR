#!/bin/bash
apt-get update -y
apt-get install -y docker.io nginx iptables-persistent

docker run -d --name app_web -p 8080:80 -v /home/bruno/FTC-ASIR/html:/usr/share/nginx/html nginx:alpine

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-tfc.key \
  -out /etc/ssl/certs/nginx-tfc.crt \
  -subj "/C=ES/ST=Galicia/L=A Coruna/O=Liceo La Paz/OU=ASIR - TFC Bruno Sande/CN=servidortfc.local"

cat << 'EOF' > /etc/nginx/sites-available/default
server {
    listen 80;
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl;
    ssl_certificate /etc/ssl/certs/nginx-tfc.crt;
    ssl_certificate_key /etc/ssl/private/nginx-tfc.key;
    location / { proxy_pass http://127.0.0.1:8080; }
}
EOF

systemctl restart nginx

iptables -F
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
netfilter-persistent save
