#!/bin/bash
set -x
sudo apt-get install imagemagick imagemagick-doc
sudo npm i -g npm

git clone https://github.com/lpender/meteor-assets

cp resources/splash-android.png ./meteor-assets/resources/splash-android.png
cp resources/splash-ios.png ./meteor-assets/resources/splash-ios.png
cp resources/icon-android.png ./meteor-assets/resources/icon-android.png
cp resources/icon-ios.png ./meteor-assets/resources/icon-ios.png

cd meteor-assets
npm install
node meteor-assets
wait
cd ..


cp ./meteor-assets/resources/splashes/* ./app/resources/splashes/
cp ./meteor-assets/resources/icons/* ./app/resources/icons/


