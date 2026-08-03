class ParticleModuleCollisionActor extends ParticleModuleCollision
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(Actors) array<name> ActorsToCollideWith;
var(Actors) bool bCheckPawnCollisions;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleCollisionActor.DistributionDampingFactor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDampingFactor'
    // Archetype: DistributionVectorUniform'Engine.Default__ParticleModuleCollision.DistributionDampingFactor'
    begin object name="DistributionDampingFactor"
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleCollisionActor.DistributionDampingFactorRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDampingFactorRotation'
    // Archetype: DistributionVectorConstant'Engine.Default__ParticleModuleCollision.DistributionDampingFactorRotation'
    begin object name="DistributionDampingFactorRotation"
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleCollisionActor.DistributionMaxCollisions'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionMaxCollisions'
    // Archetype: DistributionFloatUniform'Engine.Default__ParticleModuleCollision.DistributionMaxCollisions'
    begin object name="DistributionMaxCollisions"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleCollisionActor.DistributionParticleMass'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionParticleMass'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleCollision.DistributionParticleMass'
    begin object name="DistributionParticleMass"
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleCollisionActor.DistributionDelayAmount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDelayAmount'
    // Archetype: DistributionFloatConstant'Engine.Default__ParticleModuleCollision.DistributionDelayAmount'
    begin object name="DistributionDelayAmount"
    end object
    DampingFactor=(Distribution=Distribution=DistributionDampingFactor)
    DampingFactorRotation=(Distribution=Distribution=DistributionDampingFactorRotation)
    MaxCollisions=(Distribution=Distribution=DistributionMaxCollisions)
    ParticleMass=(Distribution=Distribution=DistributionParticleMass)
    DelayAmount=(Distribution=Distribution=DistributionDelayAmount)
}