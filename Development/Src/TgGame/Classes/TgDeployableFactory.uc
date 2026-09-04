class TgDeployableFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display)
    config(Engine);

var int nCurrentCount;
var float s_fLastSpawnTime;
var () bool s_bSpawnOnce;
var () int s_nDeployableId;
var () float s_fDeployableLifeSpan;

native function SpawnObject();  // Export UTgDeployableFactory::execSpawnObject(FFrame&, void* const)

simulated function PostBeginPlay() { }

function DeployableDied() { }

simulated function OnToggle(SeqAct_Toggle Action) { }

function OnKillBots(TgSeqAct_KillBots inAction) { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

defaultproperties
{}
