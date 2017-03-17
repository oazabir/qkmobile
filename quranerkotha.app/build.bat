REM meteor npm install --production
REM rd /s/q ..\appbuild\android
REM del ..\appbuild\* /Q
cmd /c meteor build ..\appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64
copy ..\appbuild\android\release-unsigned.apk ..\appbuild\android\release-signed.apk
cmd /c jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 ..\appbuild\android\release-signed.apk quranerkotha
del ..\appbuild\quranerkotha.apk
cmd /c %ANDROID_HOME%\build-tools\25.0.2\zipalign 4 ..\appbuild\android\release-signed.apk ..\appbuild\quranerkotha.apk
copy ..\appbuild\quranerkotha.apk .\
copy ..\appbuild\quranerkotha.app.tar.gz

