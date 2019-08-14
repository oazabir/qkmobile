export APP_SERVER=https://app.quranerkotha.com
export KEYSTORE_ALIAS=quranerkotha
docker build -t qkmobile-android . && \
docker run \
    -it \
    --rm \
    --name qkmobile-server \
    -e APP_SERVER="$APP_SERVER" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    -p 3000:3000 \
    qkmobile-android:latest bash build-server.sh