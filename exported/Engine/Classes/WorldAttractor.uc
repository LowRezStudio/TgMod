class WorldAttractor extends Actor
    native(Physics)
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

enum EWorldAttractorFalloffType
{
    FOFF_Constant,                  // 0
    FOFF_Linear,                    // 1
    FOFF_Exponent,                  // 2
    FOFF_MAX                        // 3
};

struct native WorldAttractorData
{
    var bool bEnabled;
    var Vector Location;
    var WorldAttractor.EWorldAttractorFalloffType FalloffType;
    var float FalloffExponent;
    var float Range;
    var float Strength;

    structdefaultproperties
    {
        bEnabled=false
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        FalloffType=EWorldAttractorFalloffType.FOFF_Constant
        FalloffExponent=0.0000000
        Range=0.0000000
        Strength=0.0000000
    }
};

var() bool bEnabled;
var() float LoopDuration;
var float CurrentTime;
var() WorldAttractor.EWorldAttractorFalloffType FalloffType;
var() interp MatineeRawDistributionFloat FalloffExponent;
var() interp MatineeRawDistributionFloat Range;
var() interp MatineeRawDistributionFloat Strength;
var() interp float CollisionRadius;
var() interp MatineeRawDistributionFloat DragCoefficient;
var() interp MatineeRawDistributionFloat DragRadius;

function OnSetWorldAttractorParam(SeqAct_SetWorldAttractorParam Action)
{
    // End:0x4C
    if(Action.bEnabledField)
    {
        bEnabled = Action.bEnabled;
    }
    // End:0x96
    if(Action.bFalloffTypeField)
    {
        FalloffType = Action.FalloffType;
    }
    // End:0xE0
    if(Action.bRangeField)
    {
        Range = Action.Range;
    }
    // End:0x12A
    if(Action.bStrengthField)
    {
        Strength = Action.Strength;
    }
    //return;    
}

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__WorldAttractor.DistributionFalloffExponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionFalloffExponent'
    begin object name="DistributionFalloffExponent" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__WorldAttractor.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__WorldAttractor.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__WorldAttractor.DistributionDragCoefficient'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragCoefficient'
    begin object name="DistributionDragCoefficient" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__WorldAttractor.DistributionDragRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragRadius'
    begin object name="DistributionDragRadius" class=Engine.DistributionFloatConstant
    end object
    bEnabled=true
    FalloffExponent=(MatineeValue=0.0000000,bInMatinee=false,Distribution=Distribution=DistributionFalloffExponent,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Range=(MatineeValue=0.0000000,bInMatinee=false,Distribution=Distribution=DistributionRange,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(MatineeValue=0.0000000,bInMatinee=false,Distribution=Distribution=DistributionStrength,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragCoefficient=(MatineeValue=0.0000000,bInMatinee=false,Distribution=Distribution=DistributionDragCoefficient,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragRadius=(MatineeValue=0.0000000,bInMatinee=false,Distribution=Distribution=DistributionDragRadius,Type=0,Op=0,LookupTableNumElements=0,LookupTableChunkSize=0,LookupTable=none,LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Components[0]=none
}