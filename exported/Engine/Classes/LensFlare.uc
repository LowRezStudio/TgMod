class LensFlare extends Object
    native(LensFlare)
    hidecategories(Object);

struct native transient LensFlareElementCurvePair
{
    var init string CurveName;
    var init Object CurveObject;

    structdefaultproperties
    {
        CurveName=""
        CurveObject=none
    }
};

struct native LensFlareElement
{
    var() name ElementName;
    var() float RayDistance;
    var() bool bIsEnabled;
    var() bool bUseSourceDistance;
    var() bool bNormalizeRadialDistance;
    var() bool bModulateColorBySource;
    var() Vector Size;
    var(Material) array<MaterialInterface> LFMaterials;
    var(Material) RawDistributionFloat LFMaterialIndex;
    var(Scaling) RawDistributionFloat Scaling;
    var(Scaling) RawDistributionVector AxisScaling;
    var(Rotation) RawDistributionFloat Rotation;
    var(Rotation) bool bOrientTowardsSource;
    var(Color) RawDistributionVector Color;
    var(Color) RawDistributionFloat Alpha;
    var(Offset) RawDistributionVector Offset;
    var(Scaling) RawDistributionVector DistMap_Scale;
    var(Scaling) RawDistributionVector DistMap_Color;
    var(Scaling) RawDistributionFloat DistMap_Alpha;

    structdefaultproperties
    {
        ElementName="None"
        RayDistance=0.0000000
        bIsEnabled=false
        bUseSourceDistance=false
        bNormalizeRadialDistance=false
        bModulateColorBySource=false
        Size=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        LFMaterials=none
        LFMaterialIndex=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        Scaling=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        AxisScaling=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        Rotation=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        bOrientTowardsSource=false
        Color=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        Alpha=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        Offset=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        DistMap_Scale=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        DistMap_Color=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
        DistMap_Alpha=(Distribution=none,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    }
};

var export editinline LensFlareElement SourceElement;
var(Source) StaticMesh SourceMesh;
var const Scene.ESceneDepthPriorityGroup SourceDPG;
var(Reflections) const Scene.ESceneDepthPriorityGroup ReflectionsDPG;
var export editinline array<export editinline LensFlareElement> Reflections;
var(Visibility) float OuterCone;
var(Visibility) float InnerCone;
var(Visibility) float ConeFudgeFactor;
var(Visibility) float Radius;
var(Visibility) bool bUseTrueConeCalculation;
var(Bounds) bool bUseFixedRelativeBoundingBox;
var(Debug) bool bRenderDebugLines;
var bool ThumbnailImageOutOfDate;
var(Visibility) float MinStrength;
var(Occlusion) RawDistributionFloat ScreenPercentageMap;
var(Bounds) Box FixedRelativeBoundingBox;
var export InterpCurveEdSetup CurveEdSetup;
var transient int ReflectionCount;
var Rotator ThumbnailAngle;
var float ThumbnailDistance;
var Texture2D ThumbnailImage;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__LensFlare.DistributionLFMaterialIndex'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLFMaterialIndex'
    begin object name="DistributionLFMaterialIndex" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__LensFlare.DistributionScaling'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionScaling'
    begin object name="DistributionScaling" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__LensFlare.DistributionAxisScaling'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAxisScaling'
    begin object name="DistributionAxisScaling" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=0.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__LensFlare.DistributionRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRotation'
    begin object name="DistributionRotation" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__LensFlare.DistributionColor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColor'
    begin object name="DistributionColor" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__LensFlare.DistributionAlpha'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlpha'
    begin object name="DistributionAlpha" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__LensFlare.DistributionOffset'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionOffset'
    begin object name="DistributionOffset" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__LensFlare.DistributionDistMap_Scale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDistMap_Scale'
    begin object name="DistributionDistMap_Scale" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorConstant'Engine.Default__LensFlare.DistributionDistMap_Color'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDistMap_Color'
    begin object name="DistributionDistMap_Color" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__LensFlare.DistributionDistMap_Alpha'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDistMap_Alpha'
    begin object name="DistributionDistMap_Alpha" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstantCurve'Engine.Default__LensFlare.DistributionScreenPercentageMap'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionScreenPercentageMap'
    begin object name="DistributionScreenPercentageMap" class=Engine.DistributionFloatConstantCurve
        ConstantCurve=(Points=((InVal=0.0000000,OutVal=0.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=EInterpCurveMode.CIM_Linear),(InVal=1.0000000,OutVal=1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=EInterpCurveMode.CIM_Linear)))
    end object
    SourceElement=(ElementName="Source",RayDistance=0.0000000,bIsEnabled=true,bUseSourceDistance=false,bNormalizeRadialDistance=false,bModulateColorBySource=false,Size=(X=75.0000000,Y=75.0000000,Z=75.0000000),LFMaterials=none,LFMaterialIndex=(Distribution=Distribution=DistributionLFMaterialIndex,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),Scaling=(Distribution=Distribution=DistributionScaling,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),AxisScaling=(Distribution=Distribution=DistributionAxisScaling,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,1.0000000,1.0000000,1.0000000,0.0000000,1.0000000,1.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),Rotation=(Distribution=Distribution=DistributionRotation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),bOrientTowardsSource=false,Color=(Distribution=Distribution=DistributionColor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),Alpha=(Distribution=Distribution=DistributionAlpha,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),Offset=(Distribution=Distribution=DistributionOffset,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),DistMap_Scale=(Distribution=Distribution=DistributionDistMap_Scale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),DistMap_Color=(Distribution=Distribution=DistributionDistMap_Color,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000),DistMap_Alpha=(Distribution=Distribution=DistributionDistMap_Alpha,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000))
    SourceDPG=ESceneDepthPriorityGroup.SDPG_World
    ReflectionsDPG=ESceneDepthPriorityGroup.SDPG_Foreground
    ConeFudgeFactor=0.5000000
    ScreenPercentageMap=(Distribution=Distribution=DistributionScreenPercentageMap,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,1.0000000,0.0000000,1.0000000),LookupTableTimeScale=1.0000000,LookupTableStartTime=0.0000000)
}