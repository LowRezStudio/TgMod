class TgSkeletalMeshActor_FlagStand extends TgSkeletalMeshActor_Loader
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader)
    config(Engine);

var string m_FlagContentDataClassName;
var transient TgFlagContentData m_FlagContentData;
var () int m_nGameTaskForce;
var () int m_nTeamIndex;

native function ChangeTaskForceFlag(int nTaskForce, int nTeamIndex);  // Export UTgSkeletalMeshActor_FlagStand::execChangeTaskForceFlag(FFrame&, void* const)

simulated event PreBeginPlay() { }

simulated function PostBeginPlay() { }

defaultproperties
{}
