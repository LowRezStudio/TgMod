class TgDeploy_Illusion extends TgDeployable
    native(ChampYing)
    notplaceable
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion)
    config(Engine);

var repnotify float r_fShatterDelay;
var const int m_nShatterDeviceID;
var TgDeviceFire_ShatterExplosion m_ShatterFiremode;
var int s_nNumBeamHits;
var Vector s_BeamAimDir;
var Actor s_BeamTargetActor;
var repnotify Vector r_BeamTargetPos;
var repnotify byte r_nPlayShatterFX;
var array< delegate<DestroyedEvent> > s_OnDestroyDelegates;

replication {
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_BeamTargetPos, r_fShatterDelay, r_nPlayShatterFX;
}

delegate DestroyedEvent(Actor destroyedActor);

function TryBeamFire() { }

native function bool AcquireTarget();  // Export UTgDeploy_Illusion::execAcquireTarget(FFrame&, void* const)

function StartBeamFire() { }

function BeamFireAtTarget() { }

function ClearBeamTarget() { }

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

function FireShatterDevice() { }

simulated function BeamUpdateFireFXTarget() { }

simulated function BeamUpdatePSC() { }

simulated event ReplicatedEvent(name VarName) { }

simulated event DestroyIt(optional bool bPlayShatter) { }

simulated function TriggerShatter(float fDelay) { }

simulated event Shatter() { }

simulated function PlayShatterFX() { }

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy) { }

native function Actor GetActorFromInterface();  // Export UTgDeploy_Illusion::execGetActorFromInterface(FFrame&, void* const)

native function bool IsNotDestroyed();  // Export UTgDeploy_Illusion::execIsNotDestroyed(FFrame&, void* const)

simulated function PlayDimensionalLinkFX() { }

function TgPawn_Ying GetOwningYing() { }

state Deploy {}

defaultproperties
{}
