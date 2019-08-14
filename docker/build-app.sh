export APP_SERVER=https://app.quranerkotha.com
export KEYSTORE_ALIAS=quranerkotha
docker build -f Android.Dockerfile -t qkmobile-android . && \
docker run \
    -it \
    --rm \
    --name qkmobile-android \
    -e APP_SERVER="$APP_SERVER" \
    -e KEYSTORE_ALIAS="$KEYSTORE_ALIAS" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    qkmobile-android:latest bash build-android.sh