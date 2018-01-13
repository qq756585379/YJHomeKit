DIR=$(dirname $0)
cd $DIR/Example
pod install
open $DIR/Example/Example.xcworkspace
exit
