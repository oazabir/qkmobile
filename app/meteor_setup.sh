rm -rf public
ln -s ../quranerkotha.com public

meteor create . || echo "Already created"
meteor add-platform android || echo "Already Android"

bash ../docker/meteor_setup.sh