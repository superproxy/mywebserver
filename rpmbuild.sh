 mkdir -pv ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} 
vi ~/.rpmmacros
  rpmbuild -bp nginx.spec 
   rpmbuild -bc nginx.spec 
  rpmbuild  -ba nginx.spec 
 mv nginx-1.9.7.tar.gz  rpmbuild/SOURCES/
 mv nginx.spec  ~/rpmbuild/SPECS/
rpm -ivh sws-1.9.7-centos.x86_64.rpm 
  rpm -e sws-1.9.7-centos.x86_64 