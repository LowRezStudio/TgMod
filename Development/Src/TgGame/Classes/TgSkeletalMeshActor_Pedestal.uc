class TgSkeletalMeshActor_Pedestal extends TgSkeletalMeshActor_Lobby
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader,TgSkeletalMeshActor_Lobby)
    config(Engine)
    dependson(TgObject, TgSkeletalMeshActor_Loader);

var native transient Pointer m_DefaultBot;
var (Pedestal) array<Actor> m_DefaultPedestalActors;
var transient bool m_bUsingDefaultPedestal;
var () TgObject.EPedestalType m_PedestalType;

native function SwitchToDefaultPedestal(optional TgSkeletalMeshActor_Loader.LobbyAnimPose animPose=0);  // Export UTgSkeletalMeshActor_Pedestal::execSwitchToDefaultPedestal(FFrame&, void* const)

simulated event EndTransition() { }

defaultproperties
{}
