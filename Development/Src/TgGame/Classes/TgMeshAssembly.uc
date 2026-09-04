class TgMeshAssembly extends Actor
    native
    placeable
    hidecategories(Navigation)
    config(Engine);

var () int m_nMeshAsmId;
var () int m_nTeam;
var export editinline transient MeshComponent m_Mesh;
var const editconst export editinline LightEnvironmentComponent m_LightEnvironment;

native function LoadMesh();  // Export UTgMeshAssembly::execLoadMesh(FFrame&, void* const)

native function RecalculateTeamColor();  // Export UTgMeshAssembly::execRecalculateTeamColor(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function NotifyLocalPlayerTeamReceived() { }

defaultproperties
{}
