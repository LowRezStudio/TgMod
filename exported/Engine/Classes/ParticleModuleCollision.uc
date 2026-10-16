class ParticleModuleCollision extends ParticleModuleCollisionBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ParticleAttractorActionType
{
    PAAT_None,                      // 0
    PAAT_Destroy,                   // 1
    PAAT_Freeze,                    // 2
    PAAT_Event,                     // 3
    PAAT_MAX                        // 4
};

struct native ParticleAttractorCollisionAction
{
    var() ParticleModuleCollision.ParticleAttractorActionType Type;
    var() string EventName;

    structdefaultproperties
    {
        Type=ParticleAttractorActionType.PAAT_None
        EventName=""
    }
};

var(Collision) RawDistributionVector DampingFactor;
var(Collision) RawDistributionVector DampingFactorRotation;
var(Collision) RawDistributionFloat MaxCollisions;
var(Collision) ParticleModuleCollisionBase.EParticleCollisionComplete CollisionCompletionOption;
var(Collision) bool bApplyPhysics;
var(Collision) bool bPawnsDoNotDecrementCount;
var(Collision) bool bOnlyVerticalNormalsDecrementCount;
var(Performance) bool bDropDetail;
var(Performance) bool bCollideOnlyIfVisible;
var(Attractors) bool bCollideWithWorld;
var(Attractors) bool bCollideWithWorldAttractors;
var(Collision) RawDistributionFloat ParticleMass;
var(Collision) float DirScalar;
var(Collision) float VerticalFudgeFactor;
var(Collision) RawDistributionFloat DelayAmount;
var(Performance) float MaxCollisionDistance;
var(Attractors) array<ParticleAttractorCollisionAction> ParticleAttractorCollisionActions;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleCollision.DistributionDampingFactor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDampingFactor'
    begin object name="DistributionDampingFactor" class=Engine.DistributionVectorUniform
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleCollision.DistributionDampingFactorRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDampingFactorRotation'
    begin object name="DistributionDampingFactorRotation" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleCollision.DistributionMaxCollisions'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionMaxCollisions'
    begin object name="DistributionMaxCollisions" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleCollision.DistributionParticleMass'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParticleMass'
    begin object name="DistributionParticleMass" class=Engine.DistributionFloatConstant
        Constant=0.1000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleCollision.DistributionDelayAmount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDelayAmount'
    begin object name="DistributionDelayAmount" class=Engine.DistributionFloatConstant
    end object
    DampingFactor=(Distribution=Distribution=DistributionDampingFactor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DampingFactorRotation=(Distribution=Distribution=DistributionDampingFactorRotation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MaxCollisions=(Distribution=Distribution=DistributionMaxCollisions,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bPawnsDoNotDecrementCount=true
    bDropDetail=true
    bCollideOnlyIfVisible=true
    bCollideWithWorld=true
    ParticleMass=(Distribution=Distribution=DistributionParticleMass,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.1000000,0.1000000,0.1000000,0.1000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DirScalar=3.5000000
    VerticalFudgeFactor=0.1000000
    DelayAmount=(Distribution=Distribution=DistributionDelayAmount,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MaxCollisionDistance=1000.0000000
    bSpawnModule=true
    bUpdateModule=true
    LODDuplicate=false
}