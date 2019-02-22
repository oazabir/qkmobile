#vagrant init ubuntu/xenial64
vagrant halt; vagrant destroy;
vagrant plugin install vagrant-vbguest && \
vagrant plugin install vagrant-disksize && \
vagrant validate && \
vagrant up  && \
vagrant vbguest && \
vagrant snapshot push && \
vagrant ssh -c "bash -x /vagrant/vagrant/install.sh"

