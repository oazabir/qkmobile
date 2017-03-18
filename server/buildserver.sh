su qkapp -c "cd /opt/qkapp/qkmobile/ && git pull | grep 'Already up-to-date.'"
[[ $? = 0 ]] && [[ -z "$1" ]] && exit 0;

su qkapp -c "cp -R /opt/qkapp/qkmobile/quranerkotha.com/* /opt/qkapp/qkmobile/app/public"
su qkapp -c "cd /opt/qkapp/qkmobile/app && meteor build ../appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64 --server-only"
mv /opt/qkapp/qkmobile/appbuild/app.tar.gz /opt/qkapp
cd /opt/qkapp/
stop qkapp
rm bundle/ -rf
tar -zxf app.tar.gz
chown qkapp:qkapp /opt/qkapp/ -R
cd bundle/programs/server
meteor npm install
cd /opt/qkapp
start qkapp
