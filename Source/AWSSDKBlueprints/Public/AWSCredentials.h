#pragma once

#include "CoreMinimal.h"
#include "Modules/ModuleManager.h"
#include "AWSCredentials.generated.h"


USTRUCT(BlueprintType)
struct FCredentials
{
	GENERATED_BODY()
	
public:
	FString AccessKeyId;
	FString SecretKey;
	FString SessionToken;
	
};


UCLASS(Blueprintable, BlueprintType, Category = Aws)
class AWSSDKBLUEPRINTS_API UAwsCredentials : public UObject
{
	GENERATED_BODY()
public:
	UFUNCTION(BlueprintCallable, Category = Aws)
	void CreateCredentialsWithAccessKey(const FString AccessKeyId, const FString Secret, FCredentials& Credentials);
	
};
