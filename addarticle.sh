./updatecontent.sh $ARTICLE
./updatecontent.sh index
git add $ARTICLE
git add /index/index.html
git commit -m "$ARTICLE added"
git status

