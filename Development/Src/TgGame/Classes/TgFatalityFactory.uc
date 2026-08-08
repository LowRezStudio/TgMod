class TgFatalityFactory extends Actor
    placeable
    hidecategories(Navigation)
    config(Engine);

var TgFatalityMeshActor m_FatalityMeshActor;
var () LightingChannelContainer m_LightingChannels;

simulated function PlayEpicFatality(int MeshAsmId) { }

defaultproperties
{
    m_LightingChannels=(bInitialized=false,BSP=false,Static=false,Dynamic=false,CompositeDynamic=false,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=true,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=false)
    Components[0]=none
    bStatic=true
    bNoDelete=true
}
