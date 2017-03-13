rm quranerkotha.com/ -rf
wget -E -U mozilla -r --convert-links --no-clobber -c --user-agent "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19" --domains=quranerkotha.com --exclude-directories=tag,category,amp,feed --reject-regex reply https://quranerkotha.com/index/

find quranerkotha.com/ -type d -name 'feed' -exec rm -rf {} \;
find quranerkotha.com/ -type d -name 'amp' -exec rm -rf {} \;

./fixqk.sh


cp ./themes ./quranerkotha.com/wp-content/ -R
