#! /bin/bash

ROOT=$(dirname "${BASH_SOURCE}")/..
MODULE=astream
LIB=lib$MODULE.a
TARGET=$SOURCE_ROOT/lib
TARGET_SDK=$SDKROOT

if test "${SDKROOT#*Simulator}" != "$SDKROOT"
then
TARGET_SDK=$(xcrun --show-sdk-path -sdk iphoneos)
fi

function fail_build_on_error
{
	if [ $? != 0 ]
	then
		echo "Failing build"
		popd > /dev/null
		rm -rf temp-build
		popd > /dev/null
		exit 1
	fi
}

pushd $ROOT > /dev/null
echo "Building ${LIB} from $(pwd)"
echo "Using SDK: ${TARGET_SDK}"
echo "Exporting artifacts to ${TARGET}"

mkdir temp-build
cp -r src temp-build

pushd temp-build/src > /dev/null

LIB_SOURCE=$(ls *.swift)

echo "Building object files from source..."
echo $LIB_SOURCE

xcrun swiftc -emit-library -emit-object $LIB_SOURCE -sdk $TARGET_SDK -module-name $MODULE
fail_build_on_error

echo "Archiving..."

ar rcs $LIB *.o
fail_build_on_error

echo "Emitting module.."

xcrun --toolchain swift swiftc -emit-module *.swift -sdk $TARGET_SDK -module-name $MODULE
fail_build_on_error

echo "Copying artifacts..."

mv $LIB $TARGET/$LIB
mv $MODULE.swiftdoc $TARGET/$MODULE.swiftdoc
mv $MODULE.swiftmodule $TARGET/$MODULE.swiftmodule

popd > /dev/null
rm -rf temp-build
popd > /dev/null

echo "Finished building ${LIB}"
