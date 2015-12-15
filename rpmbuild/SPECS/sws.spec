%define confdir /usr/local/sws/conf
%define basedir /usr/local/sws
%define builddir /root/rpmbuild/BUILDROOT
%define n  sws
Name: sws
Version: 1.9.7
Release: centos
Summary: High Performance Web Server
License: GPL
Group: Applications/Server
Source: sws-%{version}.tar.gz
BuildRequires: openssl
BuildRequires: openssl-devel
BuildRequires: pcre-devel
BuildRequires: zlib-devel
BuildRequires: luajit-devel
URL: http://www.suning.com/
Distribution: Linux
Packager: yxz<14120195@suning.com>
BuildRoot: %{builddir} 

%description
web server 

%prep
%setup -q

%build
cd tengine
#export LUAJIT_LIB=/usr/local/lib
#export LUAJIT_INC=/usr/local/include/luajit-2.0
./configure --prefix=%{basedir} --sbin-path=%{basedir}/sbin/sws --conf-path=%{confdir}/sws.conf  --with-http_stub_status_module --with-http_realip_module  --with-http_ssl_module --with-http_spdy_module  --with-http_upstream_check_module   --with-http_sysguard_module   --with-http_concat_module --add-module=../echo-nginx-module \
--add-module=../ngx_devel_kit \
--add-module=../redis2-nginx-module \
--add-module=../lua-nginx-module

make -j2
%install
cd tengine
make DESTDIR=%{buildroot} install

#uninstall
%preun
if [ -z "`ps aux | grep sws | grep -v grep`" ];then
 kill all sws >/dev/null
 exit 0
fi

%files
%{basedir}

%config(noreplace) %{confdir}/sws.conf
%config(noreplace) %{confdir}/mime.types
%config(noreplace) %{confdir}/uwsgi_params
%config(noreplace) %{confdir}/fastcgi_params
%config(noreplace) %{confdir}/fastcgi.conf
%config(noreplace) %{confdir}/koi-utf
%config(noreplace) %{confdir}/koi-win
%config(noreplace) %{confdir}/win-utf
