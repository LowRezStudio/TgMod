class InstancedFoliageSettings extends Object
    native(Foliage)
    editinlinenew
    hidecategories(Object);

enum FoliageCullOption
{
    FOLIAGECULL_Cull,               // 0
    FOLIAGECULL_ScaleZ,             // 1
    FOLIAGECULL_ScaleXYZ,           // 2
    FOLIAGECULL_TranslateZ,         // 3
    FOLIAGECULL_MAX                 // 4
};

var(Painting) float Density;
var(Painting) float Radius;
var(Painting) float ScaleMinX;
var(Painting) float ScaleMinY;
var(Painting) float ScaleMinZ;
var(Painting) float ScaleMaxX;
var(Painting) float ScaleMaxY;
var(Painting) float ScaleMaxZ;
var(Painting) bool LockScaleX;
var(Painting) bool LockScaleY;
var(Painting) bool LockScaleZ;
var(Painting) bool AlignToNormal;
var(Painting) bool RandomYaw;
var(Painting) bool UniformScale;
var bool ReapplyDensity;
var bool ReapplyRadius;
var bool ReapplyAlignToNormal;
var bool ReapplyRandomYaw;
var bool ReapplyScaleX;
var bool ReapplyScaleY;
var bool ReapplyScaleZ;
var bool ReapplyRandomPitchAngle;
var bool ReapplyGroundSlope;
var bool ReapplyHeight;
var bool ReapplyLandscapeLayer;
var bool ReapplyZOffset;
var(Lighting) bool CastShadow;
var(Lighting) bool bCastDynamicShadow;
var(Lighting) bool bCastStaticShadow;
var(Lighting) bool bSelfShadowOnly;
var(Lighting) bool bNoModSelfShadow;
var(Lighting) bool bAcceptsDynamicDominantLightShadows;
var(Lighting) bool bCastHiddenShadow;
var(Lighting) bool bCastShadowAsTwoSided;
var(Lighting) const bool bAcceptsLights;
var(Lighting) const bool bAcceptsDynamicLights;
var(Lighting) const bool bUseOnePassLightingOnTranslucency;
var(Lighting) const bool bUsePrecomputedShadows;
var(Collision) bool bCollideActors;
var(Collision) bool bBlockActors;
var(Collision) bool bBlockNonZeroExtent;
var(Collision) bool bBlockZeroExtent;
var bool IsSelected;
var bool ShowNothing;
var bool ShowPaintSettings;
var bool ShowInstanceSettings;
var(Painting) float AlignMaxAngle;
var(Painting) float RandomPitchAngle;
var(Painting) float GroundSlope;
var(Painting) float HeightMin;
var(Painting) float HeightMax;
var(Painting) name LandscapeLayer;
var(Painting) float ZOffsetMin;
var(Painting) float ZOffsetMax;
var(Clustering) int MaxInstancesPerCluster;
var(Clustering) float MaxClusterRadius;
var float ReapplyDensityAmount;
var(Culling) int StartCullDistance;
var(Culling) int EndCullDistance;
var(Culling) InstancedFoliageSettings.FoliageCullOption CullOption;
var(Culling) Scene.EDetailMode DetailMode;
var(Lighting) const int TranslucencySortPriority;
var int DisplayOrder;

defaultproperties
{
    Density=100.0000000
    ScaleMinX=1.0000000
    ScaleMinY=1.0000000
    ScaleMinZ=1.0000000
    ScaleMaxX=1.0000000
    ScaleMaxY=1.0000000
    ScaleMaxZ=1.0000000
    AlignToNormal=true
    RandomYaw=true
    UniformScale=true
    CastShadow=true
    bCastDynamicShadow=true
    bCastStaticShadow=true
    bAcceptsDynamicDominantLightShadows=true
    bAcceptsLights=true
    bAcceptsDynamicLights=true
    bUsePrecomputedShadows=true
    ShowPaintSettings=true
    GroundSlope=45.0000000
    HeightMin=-262144.0000000
    HeightMax=262144.0000000
    MaxInstancesPerCluster=100
    MaxClusterRadius=10000.0000000
    ReapplyDensityAmount=1.0000000
    DetailMode=EDetailMode.DM_Medium
}