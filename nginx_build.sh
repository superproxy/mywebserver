
cd nginx_sn

#install nginx
export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.0
cp /usr/local/lib/libluajit-5.1.so.2 /usr/lib64/

cd nginx-1.9.7
#pach sysguard
#patch -p1 < nginx-http-sysguard/nginx_sysguard_1.3.9.patch
# request add  sysguard_set:1
#cd..


#./configure --prefix=/usr/local/nginx --with-openssl=../libressl-2.3.0 --with-http_ssl_module --with-http_v2_module  --add-module=../nginx-http-concat --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module
./configure  --with-http_stub_status_module  --with-http_ssl_module --with-http_v2_module --add-module=../echo-nginx-module --add-module=../nginx-http-concat --add-module=../ngx_devel_kit --add-module=../lua-nginx-module --add-module=../redis2-nginx-module --add-module=../nginx-http-sysguard
make && make install

rm -f /usr/local/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/nginx
