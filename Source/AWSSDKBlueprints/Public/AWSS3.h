#pragma once

#include "CoreMinimal.h"
#include "AWSCredentials.h"
#include "UObject/Object.h"
#include "AWSS3.generated.h"

UCLASS(Blueprintable, BlueprintType, Category = Aws)
class AWSSDKBLUEPRINTS_API UAWSS3 : public UObject
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category = Aws)
	static bool ListS3Buckets(const FCredentials Credentials, TArray<FString>& Buckets, FString& OutErrorMessage);
};
