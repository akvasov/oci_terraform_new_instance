
#!/bin/bash

apt-get update
apt-get -y upgrade
apt-get -y install nginx

systemctl enable nginx
systemctl start nginx

hostname=$(hostname)

cat <<EOF > /var/www/html/index.nginx-debian.html 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working!</p>
</body>
</html>
EOF

# Disable firewall 
/usr/sbin/netfilter-persistent stop
/usr/sbin/netfilter-persistent flush

systemctl stop netfilter-persistent.service
systemctl disable netfilter-persistent.service

