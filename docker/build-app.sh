export SERVER_URL=https://app.quranerkotha.com
export SERVER=app.quranerkotha.com
export PORT=443
export KEYSTORE_ALIAS=quranerkotha

rm -rf ../appbuild/*

cp ../app/mobile-config.js ../app/mobile-config.js.bak
version=`egrep '[0-9]+\.[0-9]+\.[0-9]+' -m 1 -o ../app/mobile-config.js | tr -s " "`
newversion=`echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}'`

echo "Current version: $version, new version: $newversion"
sed -i.bak "s/$version/$newversion/" ../app/mobile-config.js 


docker build -f Android.Dockerfile -t qkmobile-android . && \
docker run \
    -it \
    --rm \
    --name qkmobile-android \
    -e SERVER_URL="$SERVER_URL" \
    -e KEYSTORE_ALIAS="$KEYSTORE_ALIAS" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    qkmobile-android:latest bash build-android.sh && \
cp ../appbuild/release-signed.apk ../app/quranerkotha.apk