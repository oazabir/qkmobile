# Install meteor
(cd ~ && curl https://install.meteor.com | sh) || exit 1

# Setup /app/public link 
(
sudo umount /vagrant/app/public/;
rm -rf /vagrant/app/public; 
mkdir /vagrant/app/public && \
sudo mount --bind /vagrant/quranerkotha.com/ /vagrant/app/public/ && \
echo "sudo mount --bind /vagrant/quranerkotha.com/ /vagrant/app/public/" >> ~/.bashrc) || exit 1

# Create the metero app .meteor and node_modules folders outside the shared folder
(cd ~ && rm -rf app; \
mkdir app && meteor create app; \
sudo umount /vagrant/app/.meteor; \
rm -rf /vagrant/app/.meteor; \ 
mkdir /vagrant/app/.meteor && sudo mount --bind ~/app/.meteor/ /vagrant/app/.meteor/ && \
echo "sudo mount --bind ~/app/.meteor/ /vagrant/app/.meteor/" >> ~/.bashrc) || exit 1

(
sudo umount /vagrant/app/node_modules/; \
rm -rf /vagrant/app/node_modules; \
mkdir /vagrant/app/node_modules && \
sudo mount --bind ~/app/node_modules/ /vagrant/app/node_modules/ && \
echo "sudo mount --bind ~/app/node_modules/ /vagrant/app/node_modules/" >> ~/.bashrc) || exit 1

# Install all node modules
(cd /vagrant/app/ && meteor npm install) || exit 1


# Install Android SDK

cd ~

(wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
unzip sdk-tools-linux-3859397.zip && \
cd tools/bin && \
mkdir ~/.android/ && \
touch ~/.android/repositories.cfg && \
./sdkmanager --update) || exit 1

(cd ~/tools/bin && ./sdkmanager "platforms;android-26" && ./sdkmanager "platform-tools" && ./sdkmanager "build-tools;27.0.3" && ./sdkmanager "extras;android;m2repository" && ./sdkmanager "extras;google;m2repository") || exit 1

export ANDROID_HOME=/home/vagrant
export PATH=$PATH:ANDROID_HOME/tools
export PATH=$PATH:ANDROID_HOME/platform-tools

# Install meteor android

cd /vagrant/app/
meteor remove-platform android
meteor add-platform android || exit 1
meteor add cordova:onesignal-cordova-plugin@2.3.3 || exit 1

# Done
echo "All done. Now run: ./build.sh and see if it builds"

# Install NVM
#wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
#source ~/.bashrc
#nvm install --lts node
#cordova-check-plugins --update=auto