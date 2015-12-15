mkdir nginx_http2
cd nginx_http2


#wget
yum -y install wget
yum -y install git

#pre
yum -y install gcc
yum -y install  pcre-devel 
yum -y install openssl
yum -y install openssl-devel


wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.3.0.tar.gz 
tar -xzvf libressl-2.3.0.tar.gz

tar -xzvf nginx-1.9.7.tar.gz
cd nginx-1.9.7
echo `pwd`


./configure --with-openssl=../libressl-2.3.0 --with-http_v2_module --with-http_ssl_module
make && make install

#ln /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
rm -f /usr/local/bin/nginx
ln /usr/local/nginx/bin/nginx /usr/local/sbin/nginx
