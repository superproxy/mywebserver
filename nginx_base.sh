mkdir nginx_base
cd nginx_base


#wget
#yum -y install wget
#yum -y install git

#download
if [ ! -f "LuaJIT-2.0.4.tar.gz" ]; then 
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
fi
if [ ! -f "nginx-1.8.0.tar.gz" ]; then 
wget http://nginx.org/download/nginx-1.8.0.tar.gz
fi

#pre
yum -y install gcc
yum -y install  pcre-devel 
yum -y install openssl
yum -y install openssl-devel

git clone https://github.com/openresty/echo-nginx-module.git

tar -xzvf nginx-1.8.0.tar.gz
cd nginx-1.8.0
echo `pwd`

./configure --with-http_stub_status_module  --add-module=../echo-nginx-module
make && make install

#ln /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
