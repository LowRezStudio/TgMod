class InstancedStaticMeshComponent extends StaticMeshComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

struct native atomicwhencooked immutablewhencooked InstancedStaticMeshInstanceData
{
    var Matrix Transform;
    var Vector2D LightmapUVBias;
    var Vector2D ShadowmapUVBias;

    structdefaultproperties
    {
        Transform=(XPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000),WPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        LightmapUVBias=(X=0.0000000,Y=0.0000000)
        ShadowmapUVBias=(X=0.0000000,Y=0.0000000)
    }
};

struct native InstancedStaticMeshMappingInfo
{
    var native Pointer Mapping;
    var native Pointer LightMap;
    var Texture2D LightmapTexture;
    var ShadowMap2D ShadowmapTexture;

    structdefaultproperties
    {
        LightmapTexture=none
        ShadowmapTexture=none
    }
};

var deprecated array<deprecated InstancedStaticMeshInstanceData> PerInstanceData;
var native array<InstancedStaticMeshInstanceData> PerInstanceSMData;
var transient int NumPendingLightmaps;
var int ComponentJoinKey;
var transient array<InstancedStaticMeshMappingInfo> CachedMappings;
var() int InstancingRandomSeed;
var(Culling) int InstanceStartCullDistance;
var(Culling) int InstanceEndCullDistance;
var bool bDontResolveInstancedLightmaps;

defaultproperties
{
    ReplacementPrimitive=none
    DetailMode=EDetailMode.DM_Medium
    bUseAsOccluder=false
    bSupportedOnMobile=false
}