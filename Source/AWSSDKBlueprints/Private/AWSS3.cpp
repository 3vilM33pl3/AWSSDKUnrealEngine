// Fill out your copyright notice in the Description page of Project Settings.


#include "AWSS3.h"

#include "aws/core/Aws.h"
#include "aws/core/auth/AWSCredentials.h"
#include "aws/s3/S3Client.h"

bool UAWSS3::ListS3Buckets(const FCredentials Credentials, TArray<FString>& Buckets, UPARAM(DisplayName="Error Message") FString& OutErrorMessage)
{
	const Aws::SDKOptions Options;
	Aws::InitAPI(Options);

	const Aws::Auth::AWSCredentials AwsCredentials(TCHAR_TO_UTF8(*Credentials.AccessKeyId), TCHAR_TO_UTF8(*Credentials.SecretKey));
	Aws::S3::S3Client S3Client(AwsCredentials);

	if(Aws::S3::Model::ListBucketsOutcome Outcome = S3Client.ListBuckets(); !Outcome.IsSuccess())
	{
		UE_LOG(LogTemp, Error, TEXT("Failed to list S3 buckets: %s"), *FString(Outcome.GetError().GetMessage().c_str()));
		OutErrorMessage = *FString(Outcome.GetError().GetMessage().c_str());
		return false;
	}
	else
	{
		for(const auto& Bucket : Outcome.GetResult().GetBuckets())
		{
			Buckets.Add(Bucket.GetName().c_str());
		}
	}

	return true;
}
