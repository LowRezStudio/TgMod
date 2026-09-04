class LandscapeProxy extends Info
    native(Terrain)
    notplaceable
    hidecategories(Navigation,Movement,Collision,Display,Attachment,Physics,Debug,Lighting,LOD);

struct native LandscapeWeightmapUsage
{
    var export editinline LandscapeComponent ChannelUsage[4];

    structdefaultproperties
    {
        ChannelUsage[0]=none
        ChannelUsage[1]=none
        ChannelUsage[2]=none
        ChannelUsage[3]=none
    }
};

struct native LandscapeLayerStruct
{
    var LandscapeLayerInfoObject LayerInfoObj;
    var editoronly transient bool bSelected;

    structdefaultproperties
    {
        LayerInfoObj=none
        bSelected=false
    }
};

var const Guid LandscapeGuid;
var(LOD) int MaxLODLevel;
var(Landscape) PhysicalMaterial DefaultPhysMaterial;
var(Landscape) const float StreamingDistanceMultiplier;
var(Landscape) MaterialInterface LandscapeMaterial;
var(LOD) float LODDistanceFactor;
var const export editinline array<export editinline LandscapeComponent> LandscapeComponents;
var const export editinline array<export editinline LandscapeHeightfieldCollisionComponent> CollisionComponents;
var native const map{VOID,VOID} MaterialInstanceConstantMap;
var native const map{VOID,VOID} WeightmapUsageMap;
var(Lighting) float StaticLightingResolution;
var() transient Landscape LandscapeActor;
var const bool bIsProxy;
var editoronly transient bool bIsSetup;
var editoronly transient bool bResetup;
var editoronly transient bool bIsMovingToLevel;
var(Lightmass) LightmassPrimitiveSettings LightmassSettings;
var(LOD) int CollisionMipLevel;
var(LOD) int MobileLODBias;
var array<LandscapeLayerStruct> LayerInfoObjs;
var const int ComponentSizeQuads;
var const int SubsectionSizeQuads;
var const int NumSubsections;

defaultproperties
{
    MaxLODLevel=-1
    StreamingDistanceMultiplier=1.0000000
    LODDistanceFactor=1.0000000
    StaticLightingResolution=1.0000000
    bIsProxy=true
    LightmassSettings=(bUseTwoSidedLighting=false,bShadowIndirectOnly=false,bUseEmissiveForStaticLighting=false,EmissiveLightFalloffExponent=2.0000000,EmissiveLightExplicitInfluenceRadius=0.0000000,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,FullyOccludedSamplesFraction=1.0000000)
    DrawScale3D=(X=128.0000000,Y=128.0000000,Z=256.0000000)
    bStatic=true
    bHidden=false
    bNoDelete=true
    bWorldGeometry=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    bEdShouldSnap=true
    bLockLocation=true
}