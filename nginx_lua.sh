mkdir nginx
cd nginx


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

git clone https://github.com/simpl/ngx_devel_kit.git
git clone https://github.com/openresty/lua-nginx-module.git

git clone https://github.com/openresty/redis2-nginx-module.git

#pre
yum -y install gcc
yum -y install  pcre-devel 
yum -y install openssl
yum -y install openssl-devel

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
./configure --with-http_stub_status_module --with-http_v2_module --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module 
make && make install

#ln /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
