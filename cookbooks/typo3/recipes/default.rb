execute "apt-get update"
execute "apt-get -y -q upgrade"

packages = ["php5", "php5-cli", "php-pear", "php5-mysql", "php5-gd", "graphicsmagick"]

packages.each do |p|
  package p
end

execute "pear upgrade-all"

directory "/var/www/html" do
	action :create
	owner "www-data"
	group "www-data"
end

directory "/var/www/typo3" do
	action :create
	owner "www-data"
	group "www-data"
end

# Execute a block
execute "wget get.typo3.org/current -O /var/www/typo3/latest.tgz" do
  not_if do
    File.exists?("/var/www/typo3/latest.tgz")
  end
end

execute "cd /var/www/typo3 && sudo tar xzf latest.tgz" do
  only_if do
    File.exists?("/var/www/typo3/latest.tgz")
  end
end
 
execute "wget http://prdownloads.sourceforge.net/typo3/introductionpackage-4.7.2.tar.gz -O /var/www/html/intro.tgz" do
  not_if do
    File.exists?("/var/www/html/intro.tgz")
  end
end

execute "cd /var/www/html && sudo tar xzf intro.tgz --strip-components=1" do
  only_if do
    File.exists?("/var/www/html/intro.tgz")
  end
end

directory "/var/www/html" do
  owner "www-data"
  group "www-data"
  mode "0777"
end

directories = ["uploads", "typo3conf", "typo3temp", "fileadmin"]

directories.each do |d| 
 execute "chmod -R 777 " + d
end

file "/var/www/typo3/latest.tgz" do
  action :delete
end

cookbook_file "/etc/apache2/sites-enabled/000-default" do
  source "000-default" # this is the value that would be inferred from the path parameter
  mode "0644"
end

#execute "mysql -uroot -ptypo3 -e 'CREATE DATABASE typo3_dev;'"

execute "a2enmod rewrite"

service "apache2" do
	action :restart
end
