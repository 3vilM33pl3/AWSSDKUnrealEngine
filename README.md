# AWS SDK for Unreal Engine 5
This is the AWS C++ SDK statically linked with Unreal Engine 5. It is intended to be used as a plugin for Unreal Engine projects.
This project is source code and static libraries only, and is meant to help developers to integrate AWS into their Unreal Engine projects by taken away 
the need to compile the SDK themselves. 

## Supported platforms
This plugin supports the following platforms:
- MacOS
- Android (arm64-v8a) (Meta Quest)

More will follow.

## Compiled modules
The following AWS modules are compiled and included in this plugin:
`aws-sdk-s3`
`aws-cognito-identity;`
`aws-cognito-idp`

If you're looking for a specific module, contact me are create a pull reqyest.

## How to use
1. Clone this repository into your project's `Plugins` folder.
2. Add your code to use the SDK in your project. There is an example in `Plugins/AWSSDK/Source/AWSSDKBlueprints` 
that shows how to use list S3 buckets as a Blueprint function. 

## How to compile
The `Scripts` folder contains scripts to compile the SDK for the supported platforms. This is where you can add 
additional modules. Look for the line `-DBUILD_ONLY:STRING="s3;cognito-identity;cognito-idp"` in the scripts to add
the name of the AWS module you want to compile. [Here](https://github.com/aws/aws-sdk-cpp/tree/main/generated/src) is the 
list of the exact names of all the modules available in the AWS SDK for C++. Add the without the `aws-sdk-` prefix.





