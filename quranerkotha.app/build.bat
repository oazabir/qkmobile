REM meteor npm install --production
rd /s/q ..\appbuild\android
del ..\appbuild\* /Q
meteor build ..\appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64
