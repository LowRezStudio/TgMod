class TgSurvivalFogVolumeDensityInfo extends FogVolumeSphericalDensityInfo
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo)
    config(Engine);

var bool m_bFogOn;
var float m_fTargetStartDistance;
var float m_fPreviousStartDistance;
var float m_fFogUpdateTimestamp;
var float m_fFogUpdateInterval;
var float m_fConvergenceRate;
var float m_fFadeInRate;
var float m_fFadeOutRate;
var export editinline FogVolumeSphericalDensityComponent SphericalDensityComponent;

event PostBeginPlay() { }

function ToggleFog(bool bOn) { }

function ConvergeFog(float fNewStartDistance, float interval, optional bool bForce) { }

simulated function Tick(float DeltaTime) { }

defaultproperties
{}
