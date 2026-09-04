class TgMeshAssembly extends Actor
    native
    placeable
    hidecategories(Navigation);

var() int m_nMeshAsmId;
var() int m_nTeam;
var export editinline transient MeshComponent m_Mesh;
var const editconst export editinline LightEnvironmentComponent m_LightEnvironment;

// Export UTgMeshAssembly::execLoadMesh(FFrame&, void* const)
native function LoadMesh();

// Export UTgMeshAssembly::execRecalculateTeamColor(FFrame&, void* const)
native function RecalculateTeamColor();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    LoadMesh();
    //return;    
}

simulated function NotifyLocalPlayerTeamReceived()
{
    RecalculateTeamColor();
    //return;    
}

defaultproperties
{
    m_nMeshAsmId=-1
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgMeshAssembly.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bDynamic=false
    end object
    m_LightEnvironment=MyLightEnvironment
    Components[0]=none
    Components[1]=MyLightEnvironment
    bNoDelete=true
}