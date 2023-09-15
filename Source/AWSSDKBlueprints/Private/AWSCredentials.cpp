#include "AWSCredentials.h"

#include <aws/core/auth/AWSCredentialsProvider.h>

void UAwsCredentials::CreateCredentialsWithAccessKey(const FString AccessKeyId, const FString Secret, FCredentials& Credentials)
{
	Aws::Auth::AWSCredentials(TCHAR_TO_UTF8(*AccessKeyId), TCHAR_TO_UTF8(*Secret));	
}
