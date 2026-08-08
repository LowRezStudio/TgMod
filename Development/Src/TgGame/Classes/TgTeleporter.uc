class TgTeleporter extends Teleporter
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

var (Object) int m_nMapObjectId;
var (MapInstance) int m_nMapId;
var (MapInstance) bool m_nPreload;
var (Taskforce) bool m_bSetTaskForce;
var (Taskforce) bool m_bBalanceTaskForce;
var (Taskforce) bool m_bIgnoreNonMembers;
var (Taskforce) bool m_bUsePlayerStart;
var (Taskforce) bool m_bRequestMission;
var () byte m_nStartGroup;
var (Taskforce) byte m_nTaskForce;

native function bool HandlePostTouch(Actor Other);  // Export UTgTeleporter::execHandlePostTouch(FFrame&, void* const)

native function LoadObjectConfig();  // Export UTgTeleporter::execLoadObjectConfig(FFrame&, void* const)

simulated function PreBeginPlay() { }

function PostBeginPlay() { }

simulated function PostTouch(actor Other) { }

event bool UsePlayerStart(Actor Other) { }

defaultproperties
{}
