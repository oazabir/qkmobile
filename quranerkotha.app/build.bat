REM meteor npm install --production
REM rd /s/q ..\appbuild\android
REM del ..\appbuild\* /Q
meteor build ..\appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64
copy ..\appbuild\android\release-unsigned.apk ..\app\quranerkotha.apk
