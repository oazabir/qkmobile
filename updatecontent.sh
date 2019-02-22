FOLDER=$1
# Drop existing folder
rm quranerkotha.com/$FOLDER -rf

# Reap latest content from website
wget -E -U mozilla --include-directories=$FOLDER,wp-content/uploads -l1 -r --convert-links --user-agent "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19" --domains=quranerkotha.com --exclude-directories=tag,category,amp,feed --reject-regex "reply|.pdf|feed|amp|fbicon.png|robots.txt" https://quranerkotha.com/$FOLDER/

# Delete all diff resolution files
rm quranerkotha.com/wp-content/uploads/*/*/*-*x*.png
rm quranerkotha.com/wp-content/uploads/*/*/*-*x*.jpg

# Delete useless folders
find quranerkotha.com/$FOLDER/ -type d -name 'feed' -exec rm -rf {} \;
find quranerkotha.com/$FOLDER/ -type d -name 'amp' -exec rm -rf {} \;

if [ "$(uname)" == "Darwin" ]; then
    sed -i '' 's/-150x150.png/.png/g' quranerkotha.com/index/index.html
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
   sed -i '' 's/-150x150.png/.png/g' quranerkotha.com/index/index.html
fi

./cleanupcontent.sh ./quranerkotha.com/$FOLDER/

