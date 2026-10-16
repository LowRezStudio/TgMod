class ParticleModuleBeamModifier extends ParticleModuleBeamBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum BeamModifierType
{
    PEB2MT_Source,                  // 0
    PEB2MT_Target,                  // 1
    PEB2MT_MAX                      // 2
};

struct native BeamModifierOptions
{
    var() bool bModify;
    var() bool bScale;
    var() bool bLock;

    structdefaultproperties
    {
        bModify=false
        bScale=false
        bLock=false
    }
};

var(Modifier) ParticleModuleBeamModifier.BeamModifierType ModifierType;
var(Position) BeamModifierOptions PositionOptions;
var(Position) RawDistributionVector Position;
var(Tangent) BeamModifierOptions TangentOptions;
var(Tangent) RawDistributionVector Tangent;
var(Tangent) bool bAbsoluteTangent;
var(Strength) BeamModifierOptions StrengthOptions;
var(Strength) RawDistributionFloat Strength;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamModifier.DistributionPosition'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPosition'
    begin object name="DistributionPosition" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamModifier.DistributionTangent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTangent'
    begin object name="DistributionTangent" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleBeamModifier.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    Position=(Distribution=Distribution=DistributionPosition,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Tangent=(Distribution=Distribution=DistributionTangent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}