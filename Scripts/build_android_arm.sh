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
NDK_DIR="$HOME"/Library/Android/sdk/ndk/25.1.8937393
UNREAL_ENGINE_DIR="/Users/Shared/Epic Games/UE_5.2"

#if [ -d "$CLONE_DIR" ]; then
#    echo "Repository exists. Updating..."
#    cd "$CLONE_DIR" || exit
#    git pull
#    cd ..
#else
#    echo "Repository doesn't exist. Cloning..."
#    git clone --depth 1 "$REPO_URL" "$CLONE_DIR" 
#fi

if [ -d "$NDK_DIR" ]; then
    echo "Android NDK directory exists"
else
    echo "Andoid NDK directory doesn't exist, terminating script"
    exit 1
fi

cd aws-sdk-cpp || exit
git apply ../fix_android_dir.patch
git submodule update --init --recursive
cd ..


mkdir -p cmake-build-android-arm
cd cmake-build-android-arm || exit

#cmake -DCMAKE_INSTALL_PREFIX="../../Source/ThirdParty/AWSSDKNativeLibraries/Android" \
#      -DBUILD_ONLY:STRING="s3;cognito-identity;cognito-idp" \
#      -DENABLE_TESTING:BOOL=OFF \
#      -DBUILD_SHARED_LIBS:BOOL=OFF \
#      -DCUSTOM_MEMORY_MANAGEMENT:BOOL=ON \
#      -DTARGET_ARCH=ANDROID \
#      -DANDROID_NATIVE_API_LEVEL=32 \
#      -DNDK_DIR="$NDK_DIR" \
#      -DCMAKE_TOOLCHAIN_FILE="$NDK_DIR"/android-ndk-r25b/build/cmake/android.toolchain.cmake \
#      -DANDROID_STL:STRING=c++_static \
#      -DANDROID_BUILD_ZLIB:BOOL=OFF \
#      -DANDROID_BUILD_OPENSSL:BOOL=OFF \
#      -DANDROID_BUILD_CURL:BOOL=OFF \
#      -DANDROID_ABI=arm64-v8a \
#      -DOPENSSL_LIBRARY_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/lib/Android/ARM64/libcrypto.a" \
#      -DOPENSSL_INCLUDE_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/include/Android/" \
#      -Dcrypto_LIBRARY="$UNREAL_ENGINE_DIR/Engine/Source/ThirdParty/OpenSSL/1.1.1n/lib/Android/ARM64/libcrypto.a" \
#      -Dcrypto_INCLUDE_DIR="$UNREAL_ENGINE_DIR/Engine/Source/ThirdParty/OpenSSL/1.1.1n/include/Android/" \
#      -DCURL_LIBRARY="$UNREAL_ENGINE_DIR/Engine/Source/ThirdParty/libcurl/7_75_0/lib/Android/ARM64/libcurl.a" \
#      -DCURL_INCLUDE_DIR="$UNREAL_ENGINE_DIR/Engine/Source/ThirdParty/libcurl/7_75_0/include/Android/" \
#      -G Ninja \
#      -S ../aws-sdk-cpp \
#      -B .     

cmake -DCMAKE_INSTALL_PREFIX="../../Source/ThirdParty/AWSSDKNativeLibraries/Android" \
      -DBUILD_ONLY:STRING="s3;cognito-identity;cognito-idp;ssm" \
      -DENABLE_TESTING:BOOL=OFF \
      -DBUILD_SHARED_LIBS:BOOL=OFF \
      -DCUSTOM_MEMORY_MANAGEMENT:BOOL=ON \
      -DTARGET_ARCH=ANDROID \
      -DANDROID_NATIVE_API_LEVEL=29 \
      -DNDK_DIR=/Users/olivier/Library/Android/sdk/ndk/25.1.8937393 \
      -DCMAKE_TOOLCHAIN_FILE=/Users/olivier/Library/Android/sdk/ndk/25.1.8937393/android-ndk-r25b/build/cmake/android.toolchain.cmake \
      -DANDROID_STL:STRING=c++_static \
      -DANDROID_BUILD_ZLIB:BOOL=OFF \
      -DANDROID_BUILD_OPENSSL:BOOL=OFF \
      -DANDROID_BUILD_CURL:BOOL=OFF \
      -DANDROID_ABI=arm64-v8a \
      -DUSE_OPENSSL:BOOL=ON \
      -DOPENSSL_LIBRARY_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/lib/Android/ARM64/libcrypto.a" \
      -DOPENSSL_INCLUDE_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/include/Android/" \
      -DOPENSSL_INCLUDE_PATH="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/include/Android/" \
      -Dcrypto_LIBRARY="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/lib/Android/ARM64/libcrypto.a" \
      -Dcrypto_INCLUDE_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/OpenSSL/1.1.1n/include/Android/" \
      -DCURL_LIBRARY="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/libcurl/7_75_0/lib/Android/ARM64/libcurl.a" \
      -DCURL_INCLUDE_DIR="/Users/Shared/Epic Games/UE_5.2/Engine/Source/ThirdParty/libcurl/7_75_0/include/Android/" \
      -G Ninja \
      -S ../aws-sdk-cpp \
      -B . 


cmake --build . --config Release --target install
