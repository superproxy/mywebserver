mkdir nginx_sn
cd nginx_sn


#wget
yum -y install wget
yum -y install git

#download
if [ ! -f "LuaJIT-2.0.4.tar.gz" ]; then 
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
fi
if [ ! -f "nginx-1.9.7.tar.gz" ]; then 
wget http://nginx.org/download/nginx-1.9.7.tar.gz
fi


# sysguard
git clone https://github.com/alibaba/nginx-http-sysguard.git
git clone https://github.com/cep21/healthcheck_nginx_upstreams.git

git clone https://github.com/alibaba/nginx-http-concat.git

git clone https://github.com/openresty/echo-nginx-module.git
echo  ndk
git clone https://github.com/simpl/ngx_devel_kit.git
git clone https://github.com/openresty/lua-nginx-module.git

git clone https://github.com/openresty/redis2-nginx-module.git


#pre
yum -y install gcc
# rewrite
yum -y install  pcre-devel 
yum -y install openssl
yum -y install openssl-devel

wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.3.0.tar.gz 
tar -xzvf libressl-2.3.0.tar.gz


#lua-git
tar -xzvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make && make install
cd ..


#install nginx
export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.0
cp /usr/local/lib/libluajit-5.1.so.2 /usr/lib64/

tar -xzvf nginx-1.9.7.tar.gz
cd nginx-1.9.7
echo `pwd`

#pach sysguard
cd nginx-1.9.7
patch -p1 < nginx-http-sysguard/nginx_sysguard_1.3.9.patch
# request add  sysguard_set:1
cd..



#./configure --prefix=/usr/local/nginx --with-openssl=../libressl-2.3.0 --with-http_ssl_module --with-http_v2_module  --add-module=../nginx-http-concat --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module
./configure  --with-http_stub_status_module  --with-http_ssl_module --with-http_v2_module --add-module=../echo-nginx-module --add-module=../nginx-http-concat --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module --add-module=../nginx-http-sysguard
make && make install

rm -f /usr/local/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/nginx
