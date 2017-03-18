export ANDROID_HOME=~/Library/Android/sdk
meteor build ../appbuild --server=https://app.quranerkotha.com --architecture=os.linux.x86_64 && \
cp ../appbuild/android/release-unsigned.apk ../appbuild/android/release-signed.apk && \
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 ../appbuild/android/release-signed.apk quranerkotha && \
$ANDROID_HOME/build-tools/25.0.2/zipalign 4 ../appbuild/android/release-signed.apk ../appbuild/quranerkotha.apk && \
mv ../appbuild/quranerkotha.apk ./ 
