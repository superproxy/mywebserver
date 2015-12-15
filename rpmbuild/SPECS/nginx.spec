Name: nginx
Version: 1.9.7
Release: el5
Summary: High Performance Web Server
License: GPL
Group: Applications/Server
#Source: http://nginx.org/download/nginx-%{version}.tar.gz
Source: nginx-%{version}.tar.gz
BuildRequires: zlib-devel
BuildRequires: pcre-devel
BuildRequires: openssl-devel
URL: http://nginx.org/
Distribution: Linux
Packager: yxz<14120195@suning.com>
BuildRoot:  /root/rpmbuild/BUILDROOT

%description
nginx [engine x] is a HTTP and reverse proxy server, as well as a mail proxy server

%prep
%setup -q

%build
./configure --prefix=/usr/local/nginx
make -j8
%install
make DESTDIR=%{buildroot} install

#uninstall
%preun
if [ -z "`ps aux | grep nginx | grep -v grep`" ];then
 killall nginx >/dev/null
 exit 0
fi

%files
/usr/local/nginx
%define confdir /usr/local/nginx/conf

%config(noreplace) %{confdir}/nginx.conf
%config(noreplace) %{confdir}/mime.types
%config(noreplace) %{confdir}/uwsgi_params
%config(noreplace) %{confdir}/fastcgi_params
%config(noreplace) %{confdir}/fastcgi.conf
%config(noreplace) %{confdir}/koi-utf
%config(noreplace) %{confdir}/koi-win
%config(noreplace) %{confdir}/win-utf
