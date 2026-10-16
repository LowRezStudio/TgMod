class TgCollisionProxy extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var array<TgPawn> m_NearByPlayers;
var bool m_bIgnoreStealthPlayers;
var bool m_bIgnoreNonPlayers;
var bool m_bIgnoreInvulnerablePlayers;
var bool m_bForwardOwnerOnly;

delegate ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);

delegate ProxyUnTouch(Actor Other);

native function ForwardTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);  // Export UTgCollisionProxy::execForwardTouch(FFrame&, void* const)

native function ForwardUnTouch(Actor Other);  // Export UTgCollisionProxy::execForwardUnTouch(FFrame&, void* const)

native function DelegatesUpdated();  // Export UTgCollisionProxy::execDelegatesUpdated(FFrame&, void* const)

native function TouchOther(Actor Other, PrimitiveComponent OtherComp);  // Export UTgCollisionProxy::execTouchOther(FFrame&, void* const)

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

simulated event bool ShouldIgnoreActor(TgPawn aPawn) { }

simulated event ForceClearNearByPlayersList() { }

simulated function Destroyed() { }

simulated function CheckNearByPlayers(TgPawn aPawn, bool bAdd) { }

simulated function OnPlayerAdded(TgPawn aPawn) { }

simulated function OnPlayerRemoved(TgPawn aPawn) { }

simulated function int GetNearByPlayers(optional bool bOnlyValid=true) { }

simulated function GetNearByPlayersTaskforce(out array<int> NearByPlayerTaskforces, optional bool bEndWhenMultipleFound) { }

simulated function ForceProximityScan(optional float Radius) { }

native function SetAux(name AuxBusName, float Level);  // Export UTgCollisionProxy::execSetAux(FFrame&, void* const)

defaultproperties
{}
