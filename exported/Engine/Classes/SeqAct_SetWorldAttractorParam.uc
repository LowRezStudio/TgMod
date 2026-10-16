class SeqAct_SetWorldAttractorParam extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() array<WorldAttractor> Attractor;
var bool bEnabledField;
var bool bFalloffTypeField;
var bool bFalloffExponentField;
var bool bRangeField;
var bool bStrengthField;
var() bool bEnabled;
var() WorldAttractor.EWorldAttractorFalloffType FalloffType;
var() RawDistributionFloat FalloffExponent;
var() RawDistributionFloat Range;
var() RawDistributionFloat Strength;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__SeqAct_SetWorldAttractorParam.DistributionFalloffExponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionFalloffExponent'
    begin object name="DistributionFalloffExponent" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__SeqAct_SetWorldAttractorParam.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__SeqAct_SetWorldAttractorParam.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    bEnabled=true
    FalloffExponent=(Distribution=Distribution=DistributionFalloffExponent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    ObjName="Set World Attractor Param"
}