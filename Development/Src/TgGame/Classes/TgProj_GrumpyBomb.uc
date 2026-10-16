class TgProj_GrumpyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine);

var export editinline TgSilhouetteComponent m_Silhouette;
var bool m_bSilhouetteInitialized;
var bool m_bSilhouetteAllowed;
var float m_fPostLandDurationAccelerant;

native function InitializeSilhouetteComponent();  // Export UTgProj_GrumpyBomb::execInitializeSilhouetteComponent(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function CheckShowOutline() { }

native function bool IsAccelerantEquipped();  // Export UTgProj_GrumpyBomb::execIsAccelerantEquipped(FFrame&, void* const)

function float GetPostLandDuration() { }

function StartLandExplodeTimer() { }

simulated event bool CheckTeamPassThrough(Actor Other) { }

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ProxyUnTouch(Actor Other) { }

defaultproperties
{}
