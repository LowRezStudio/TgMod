class TgStaticMeshActor_TeamColor extends StaticMeshActor
    native(Pawns)
    hidecategories(Navigation)
    config(Engine);

var (TeamColoring) const int nTaskForce;
var (TeamColoring) const name TeamColoringParameterName;
var (TeamColoring) const bool bInvertColoringParameter;
var const bool bInstancedAllMaterials;
var byte bFriendlyWithLocalPlayer;
var transient array<MaterialInterface> InitialMaterialList;

native function ForceRecalculateMaterial();  // Export UTgStaticMeshActor_TeamColor::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgStaticMeshActor_TeamColor::execRecalculateMaterial(FFrame&, void* const)

native function UpdateFriendlyFlag();  // Export UTgStaticMeshActor_TeamColor::execUpdateFriendlyFlag(FFrame&, void* const)

simulated function NotifyLocalPlayerTeamReceived() { }

defaultproperties
{}
