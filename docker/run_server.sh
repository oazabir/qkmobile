export APP_SERVER=https://app.quranerkotha.com
docker build -f Server.Dockerfile -t qkmobile-server . && \
docker run \
    -it \
    --rm \
    --name qkmobile-server \
    -e APP_SERVER="$APP_SERVER" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    -p 3000:3000 \
    qkmobile-server:latest bash build-server.sh