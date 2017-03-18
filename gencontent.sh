# Drop existing folder
rm quranerkotha.com/ -rf

# Reap latest content from website
wget -E -U mozilla -r --convert-links -nc --user-agent "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19" --domains=quranerkotha.com --exclude-directories=tag,category,amp,feed --reject-regex "reply|feed/|amp/|robots.txt" https://quranerkotha.com/index/


# Delete useless folders
find quranerkotha.com/ -type d -name 'feed' -exec rm -rf {} \;
find quranerkotha.com/ -type d -name 'amp' -exec rm -rf {} \;

./cleanupcontent.sh


cp ./themes ./quranerkotha.com/wp-content/ -R
