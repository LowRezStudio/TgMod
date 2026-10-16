class TgVisibilityVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var (PlayerCameraEffects) ParticleSystem m_PlayerCameraParticleSystem;
var (PlayerCameraEffects) ParticleSystem m_PlayerCameraInvisibleParticleSystem;

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

defaultproperties
{}
