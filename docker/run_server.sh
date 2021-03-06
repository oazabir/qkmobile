export APP_SERVER=app.quranerkotha.com
export ROOT_URL=https://app.quranerkotha.com
export PORT=3000
export APP_ID=com.quranerkotha.app

docker build -f Server.Dockerfile -t qkmobile-server . && \
docker rm -f qkmobile-server

docker run \
    -d \
    --restart=always \
    --name qkmobile-server \
    -e APP_SERVER="$APP_SERVER" \
    -e PORT="$PORT" \
    -e ROOT_URL="$ROOT_URL" \
    -e APP_ID="$APP_ID" \
    -v "$PWD/../app":/app \
    -v "$PWD/../appbuild":/build \
    -v "$PWD/../quranerkotha.com":/app/public \
    --net=host  \
    qkmobile-server:latest bash build-server.sh

if [[ $- == *i* ]]
then
    docker logs -f qkmobile-server
else
    (docker logs -f qkmobile-server) & pid=$!
    (sleep 30 && kill $pid) &
fi

