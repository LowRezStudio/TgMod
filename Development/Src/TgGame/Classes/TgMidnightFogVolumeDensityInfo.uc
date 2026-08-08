class TgMidnightFogVolumeDensityInfo extends FogVolumeSphericalDensityInfo
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo)
    config(Engine);

var bool m_bFogOn;
var bool m_bFogUpdateNeeded;
var bool m_bIsFadingOut;
var float m_fCurrentStartDistance;
var float m_fFadeOutDuration;
var float m_fFadeOutTimer;
var float m_fTargetMaxDensity;
var float m_fDestroyTimer;
var export editinline FogVolumeSphericalDensityComponent SphericalDensityComponent;

simulated event PostBeginPlay() { }

simulated function ToggleFog(bool bOn) { }

simulated function SetOrigin(Vector vOrigin) { }

simulated function SetStartDistance(float fNewStartDistance) { }

simulated function FadeOut(float fFadeTime) { }

simulated function Tick(float DeltaTime) { }

simulated function SetAlpha(float fNewAlpha) { }

defaultproperties
{}
