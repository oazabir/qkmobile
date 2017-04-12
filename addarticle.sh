[[ -z $1 ]] && echo "Specify folder name" && exit 1
ARTICLE=$1
./updatecontent.sh $ARTICLE
./updatecontent.sh index
git add quranerkotha.com/$ARTICLE
git add quranerkotha.com/index/index.html
git add quranerkotha.com/wp-content/uploads
git status
git commit -m "$ARTICLE added"

