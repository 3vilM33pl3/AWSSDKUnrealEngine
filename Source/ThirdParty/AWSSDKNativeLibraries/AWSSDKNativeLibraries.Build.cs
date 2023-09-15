using System;
using System.IO;
using System.Linq;
using UnrealBuildTool;

public class AWSSDKNativeLibraries : ModuleRules
{
    public AWSSDKNativeLibraries(ReadOnlyTargetRules Target) : base(Target)
    {
        Type = ModuleRules.ModuleType.External;
        PCHUsage = ModuleRules.PCHUsageMode.UseExplicitOrSharedPCHs;

        if (base.Target.Platform == UnrealTargetPlatform.Mac)
        {
            if (base.Target.Architecture == UnrealArch.Arm64 || base.Target.Architecture == UnrealArch.Arm64ec)
            {
                var path = Path.GetFullPath(Path.Combine(ModuleDirectory, "MacArm64"));
                PublicSystemIncludePaths.Add(Path.Combine(path, "include"));
                var libraries = Directory.GetFiles(Path.Combine(path, "lib"), "*.a").ToList();
                Console.WriteLine(string.Join("\nAdding static library: ", libraries));
                PublicAdditionalLibraries.AddRange(libraries);
                
                Console.WriteLine("Mac Arm64 libraries added successfully");
                
                AddEngineThirdPartyPrivateStaticDependencies(Target, new string[]
                {
                    "nghttp2",
                    "OpenSSL",
                    "zlib",
                    "libcurl"
                });
                
            } 
            else if (base.Target.Platform == UnrealTargetPlatform.Android)
            {
                var path = Path.GetFullPath(Path.Combine(ModuleDirectory, "Android"));
                PublicSystemIncludePaths.Add(Path.Combine(path, "include"));
                var libraries = Directory.GetFiles(Path.Combine(path, "lib"), "*.a").ToList();
                Console.WriteLine(string.Join("\nAdding static library: ", libraries));
                PublicAdditionalLibraries.AddRange(libraries);
                Console.WriteLine("Android libraries added successfully");
                AddEngineThirdPartyPrivateStaticDependencies(Target, "OpenSSL");
            }
            
        }

        PublicDependencyModuleNames.AddRange(
            new string[]
            {
                "Core",
            }
        );

        PrivateDependencyModuleNames.AddRange(
            new string[]
            {
                "CoreUObject",
                "Engine",
            }
        );
    }
}