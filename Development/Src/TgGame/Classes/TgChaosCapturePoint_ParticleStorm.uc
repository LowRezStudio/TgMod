class TgChaosCapturePoint_ParticleStorm extends TgChaosCapturePoint
    native(Game)
    placeable
    hidecategories(Navigation)
    config(Engine);

var (ParticleStorm) Emitter m_FrontEffect;
var (ParticleStorm) Emitter m_SwirlEffect;
var (Survival) float m_fFogStartDistance;
var (Survival) float m_fFogConvergeSpeed;
var (Survival) float m_fSecondsBeforeFogConverge;
var (Survival) float m_fFogMapDistance;
var (Survival) float m_fFogRadiusRatio;
var (Survival) float m_fFogAlphaRatio;
var (SurvivalAudio) AkAmbientSound m_2DSoundActor;
var (SurvivalAudio) int m_nNumMobileSoundActors;
var array<TgMobileAmbientSound> m_MobileSoundActors;
var (SurvivalAudio) AkEvent m_MobileSoundActorAkEvent;
var (SurvivalAudio) AkEvent m_MobileSoundActorAkEvent_Alt;
var array<Vector> m_vPerimeterAnchors;
var float m_fTargetStartDistance;
var float m_fPreviousStartDistance;
var float m_fFogUpdateTimestamp;
var float m_fSoundActorConvergeLimit;

simulated event SetInitialState() { }

simulated event Tick(float DeltaTime) { }

function ResetFog() { }

defaultproperties
{}
