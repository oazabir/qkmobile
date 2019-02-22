#!/bin/bash
# Increase the version number for the app
cp mobile-config.js mobile-config.js.bak
version=`egrep '[0-9]+\.[0-9]+\.[0-9]+' -m 1 -o mobile-config.js | tr -s " "`
newversion=`echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}'`

echo "Current version: $version, new version: $newversion"

sed -i  "s/$version/$newversion/" mobile-config.js 

#export ANDROID_HOME=~/Library/Android/sdk
meteor build ../appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64 && \
\
cp ../appbuild/android/project/build/outputs/apk/release/android-release-unsigned.apk ../appbuild/android/release-signed.apk && \
\
jarsigner -keystore .keystore -verbose -sigalg SHA1withRSA -digestalg SHA1 ../appbuild/android/release-signed.apk quranerkotha && \
\
$ANDROID_HOME/build-tools/*/zipalign 4 ../appbuild/android/release-signed.apk ../appbuild/quranerkotha.apk && \
\
mv ../appbuild/quranerkotha.apk ./ && \
\
[[ -f mobile-config.js.bak ]] && rm mobile-config.js.bak
