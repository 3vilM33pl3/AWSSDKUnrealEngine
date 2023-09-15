#!/usr/bin/env bash

if command -v cmake &>/dev/null; then
    echo "cmake is installed"
else
    echo "cmake is not installed, terminating script"
    exit 1
fi

if command -v git &>/dev/null; then
    echo "git is installed"
else
    echo "git is not installed, terminating script"
    exit 1
fi

REPO_URL="https://github.com/aws/aws-sdk-cpp.git"
CLONE_DIR="aws-sdk-cpp"

if [ -d "$CLONE_DIR" ]; then
    echo "Repository exists. Updating..."
    cd "$CLONE_DIR" || exit
    git pull
    cd ..
else
    echo "Repository doesn't exist. Cloning..."
    git clone --depth 1 --recursive "$REPO_URL" "$CLONE_DIR" 
fi

mkdir -p cmake-build-macos-arm
cd cmake-build-macos-arm || exit

cmake -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DBUILD_SHARED_LIBS:BOOL=OFF \
      -DENABLE_TESTING:BOOL=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="../../Source/ThirdParty/AWSSDKNativeLibraries/MacArm64" \
      -DBUILD_ONLY:STRING="s3;cognito-identity;cognito-idp" \
      -G Ninja \
      -S ../aws-sdk-cpp \
      -B .
      

cmake --build . --config Release --target install
