mkdir tengine_sn
cd tengine_sn




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


git clone https://github.com/alibaba/tengine.git
git clone https://github.com/openresty/echo-nginx-module.git
git clone https://github.com/simpl/ngx_devel_kit.git
git clone https://github.com/openresty/lua-nginx-module.git
git clone https://github.com/openresty/redis2-nginx-module.git
#pre
yum -y install gcc
# rewrite
yum -y install  pcre-devel 
yum -y install openssl
yum -y install openssl-devel

#lua-git
tar -xzvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make && make install
cd ..


export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.0
cp /usr/local/lib/libluajit-5.1.so.2 /usr/lib64/

cd tengine

./configure  --with-http_stub_status_module  --with-http_ssl_module --with-http_spdy_module  --with-http_upstream_check_module   --with-http_sysguard_module   --with-http_concat_module --add-module=../echo-nginx-module  --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module 
#./configure  --with-http_stub_status_module  --with-http_ssl_module --with-http_v2_module  --with-http_upstream_check_module   --with-http_sysguard_module  --add-module=../echo-nginx-module  --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module 
make && make install

