[[ -z $1 ]] && echo "Specify folder name" && exit 1
ARTICLE=$1
./updatecontent.sh $ARTICLE
./updatecontent.sh index
git add $ARTICLE
git add index/index.html
git commit -m "$ARTICLE added"
git status

