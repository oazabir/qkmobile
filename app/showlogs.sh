#set -x
#sudo /home/vagrant/platform-tools/adb start-server
#sleep 5
adb logcat | egrep -i 'Chrome|chromium|Cordova|Meteor'
