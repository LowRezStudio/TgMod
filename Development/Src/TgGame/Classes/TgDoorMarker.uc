class TgDoorMarker extends TgTeamBlocker
    native(Navigation)
    placeable
    hidecategories(Navigation)
    config(Engine);

enum DoorStatus {
    TGD_NONE,  // 0
    TGD_LOCKED,  // 1
    TGD_OPEN,  // 2
    TGD_CLOSE,  // 3
};

var repnotify TgDoorMarker.DoorStatus r_eStatus;
var () TgDoorMarker.DoorStatus m_eInitStatus;
var TgCollisionProxy s_CollisionProxy;
var () float m_fProximity;
var () int m_nTeamThatControlsDoor;
var () int m_nMeshAssemblyId;
var () export editinline SkeletalMeshComponent m_DoorSMC;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_eStatus;
}

native function LoadMesh();  // Export UTgDoorMarker::execLoadMesh(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function PostBeginPlay() { }

simulated function ClientOnStatusChange() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

function bool ShouldDoorBeOpened() { }

function bool ShouldDoorBeClosed() { }

function CalculateDoorStatus() { }

function SetDoorStatus(TgDoorMarker.DoorStatus eStatus) { }

defaultproperties
{}
