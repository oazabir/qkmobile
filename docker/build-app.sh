export APP_SERVER=https://app.quranerkotha.com
export KEYSTORE_ALIAS=quranerkotha
docker build -t qkmobile-android . && \
docker run \
    -it \
    --rm \
    -d \
    --net=host \
    --name qkmobile-android \
    -e APP_SERVER="$APP_SERVER" \
    -e KEYSTORE_ALIAS="$KEYSTORE_ALIAS" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    qkmobile-android:latest bash