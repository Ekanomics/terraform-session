#!/bin/bash
sudo dnf update -y
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<h1>Hello World from $(hostname -f)</h1>
EOF


# Updates OS, install Apache (httpd), start and enable Apache service and a simple HTML page 