export APP_SERVER=https://app.quranerkotha.com
export PORT=3000
docker build -f Server.Dockerfile -t qkmobile-server . && \
docker run \
    -d \
    --rm \
    --name qkmobile-server \
    -e APP_SERVER="$APP_SERVER" \
    -e PORT="$PORT" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    --net=host  \
    qkmobile-server:latest bash build-server.sh
