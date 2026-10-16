class TgStaticMeshActor_PantheonMIC extends TgStaticMeshActor
    native(Pawns)
    hidecategories(Navigation)
    config(Engine);

var () MaterialInstanceConstant MICOverrides[GOD_PANTHEON];
var () int m_nGameTaskForce;
var () int m_nTeamIndex;

native function ChangePantheonMIC(int nTaskForce, int nTeamIndex);  // Export UTgStaticMeshActor_PantheonMIC::execChangePantheonMIC(FFrame&, void* const)

simulated event PreBeginPlay() { }

defaultproperties
{}
