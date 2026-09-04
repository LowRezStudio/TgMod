class ParticleModuleCameraOffset extends ParticleModuleCameraBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EParticleCameraOffsetUpdateMethod
{
    EPCOUM_DirectSet,               // 0
    EPCOUM_Additive,                // 1
    EPCOUM_Scalar,                  // 2
    EPCOUM_MAX                      // 3
};

var(Camera) RawDistributionFloat CameraOffset;
var(Camera) bool bSpawnTimeOnly;
var(Camera) ParticleModuleCameraOffset.EParticleCameraOffsetUpdateMethod UpdateMethod;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleCameraOffset.DistributionCameraOffset'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionCameraOffset'
    begin object name="DistributionCameraOffset" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    CameraOffset=(Distribution=Distribution=DistributionCameraOffset,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}