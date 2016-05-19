ROOT=$(pwd)/..
MODULE=Module
LIB=lib$MODULE.a
TARGET=$ROOT/app/lib

pushd $ROOT
cp -r lib/src temp-build
pushd temp-build

xcrun swiftc -emit-library -emit-object *.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name $MODULE

ar rcs $LIB *.o

xcrun swiftc -emit-module *.swift -sdk $(xcrun --show-sdk-path --sdk macosx) -module-name $MODULE

mv $LIB $TARGET/$LIB
mv $MODULE.swiftdoc $TARGET/$MODULE.swiftdoc
mv $MODULE.swiftmodule $TARGET/$MODULE.swiftmodule

popd
rm -rf temp-build
popd
