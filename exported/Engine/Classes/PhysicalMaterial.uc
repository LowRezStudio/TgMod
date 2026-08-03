class PhysicalMaterial extends Object
    native(Physics)
    collapsecategories
    hidecategories(Object);

enum EPhysEffectType
{
    EPMET_Impact,                   // 0
    EPMET_Slide,                    // 1
    EPMET_MAX                       // 2
};

var transient int MaterialIndex;
var() float Friction;
var() float Restitution;
var() bool bForceConeFriction;
var(Advanced) bool bEnableAnisotropicFriction;
var(Advanced) Vector AnisoFrictionDir;
var(Advanced) float FrictionV;
var() float Density;
var() float AngularDamping;
var() float LinearDamping;
var() float MagneticResponse;
var() float WindResponse;
var(Impact) float ImpactThreshold;
var(Impact) float ImpactReFireDelay;
var(Impact) ParticleSystem ImpactEffect;
var(Impact) SoundCue ImpactSound;
var(Impact) AkBaseSoundObject DeviceImpactSound;
var(Slide) float SlideThreshold;
var(Slide) float SlideReFireDelay;
var(Slide) ParticleSystem SlideEffect;
var(Slide) SoundCue SlideSound;
var(Fracture) SoundCue FractureSoundExplosion;
var(Fracture) SoundCue FractureSoundSingle;
var(Footstep) name MaterialTypeName;
var(Footstep) ParticleSystem FootstepParticleSystem;
var(Parent) PhysicalMaterial Parent;
var(PhysicalProperties) export editinline PhysicalMaterialPropertyBase PhysicalMaterialProperty;

// Export UPhysicalMaterial::execFindPhysEffectInfo(FFrame&, void* const)
native function PhysEffectInfo FindPhysEffectInfo(PhysicalMaterial.EPhysEffectType Type);

simulated function FindFractureSounds(out SoundCue OutSoundExplosion, out SoundCue OutSoundSingle)
{
    local PhysicalMaterial TestMat;

    OutSoundExplosion = none;
    OutSoundSingle = none;
    TestMat = self;
    J0x21:

    // End:0xEB [Loop If]
    if(((OutSoundExplosion == none) || OutSoundSingle == none) && TestMat != none)
    {
        // End:0x89
        if(OutSoundSingle == none)
        {
            OutSoundSingle = TestMat.FractureSoundSingle;
        }
        // End:0xC0
        if(OutSoundExplosion == none)
        {
            OutSoundExplosion = TestMat.FractureSoundExplosion;
        }
        TestMat = TestMat.Parent;
        // [Loop Continue]
        goto J0x21;
    }
    return;
    //return;    
}

simulated function PhysicalMaterialPropertyBase GetPhysicalMaterialProperty(Class<PhysicalMaterialPropertyBase> DesiredClass)
{
    // End:0x4B
    if((PhysicalMaterialProperty != none) && ClassIsChildOf(PhysicalMaterialProperty.Class, DesiredClass))
    {
        return PhysicalMaterialProperty;        
    }
    else
    {
        // End:0x86
        if(Parent != none)
        {
            return Parent.GetPhysicalMaterialProperty(DesiredClass);            
        }
        else
        {
            return none;
        }
    }
    //return ReturnValue;    
}

defaultproperties
{
    Friction=0.7000000
    Restitution=0.3000000
    Density=1.0000000
    LinearDamping=0.0100000
}