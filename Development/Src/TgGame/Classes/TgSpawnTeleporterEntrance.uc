class TgSpawnTeleporterEntrance extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

const ENEMY_DISTANCE_RADIUS = 800.0f;

struct ExitInfo {
    var TgSpawnTeleporterExit Exit;
    var float Rating;
    var bool bEnemyHasLOS;
    var bool bIsOpenSpot;
    structdefaultproperties {}
};

var () bool bEnabled;

function int CompareExitInfo(ExitInfo EI1, ExitInfo EI2) { }

function bool CanTeleport(Actor Other) { }

function ExitInfo FindExit(TgPawn TgP, out array<TgSpawnTeleporterExit> Exits) { }

function TeleportToExit(TgPawn TgP, TgSpawnTeleporterEntrance From, ExitInfo To) { }

simulated function Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated function OnToggle(SeqAct_Toggle Action) { }

defaultproperties
{}
