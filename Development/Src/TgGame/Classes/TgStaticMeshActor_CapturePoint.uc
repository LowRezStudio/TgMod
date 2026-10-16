class TgStaticMeshActor_CapturePoint extends StaticMeshActor
    native(Pawns)
    hidecategories(Navigation)
    config(Engine);

var (capturePoint) const LinearColor UncontestedCaptureColor;
var (capturePoint) const LinearColor FriendlyCaptureColor;
var (capturePoint) const LinearColor EnemyCaptureColor;
var (capturePoint) const name EmissiveColorParameterName;
var (capturePoint) const name CapturePercentParameterName;
var transient array<MaterialInterface> InitialMaterialList;
var const bool bInstancedAllMaterials;
var int CurrentCaptureStatus;
var float CurrentCapturePercent;

native function SetEmissiveColor(LinearColor NewColor, float fPercent, optional float fRampTime=1.0000000);  // Export UTgStaticMeshActor_CapturePoint::execSetEmissiveColor(FFrame&, void* const)

native function SetCapturePercent(float fNewPercent, optional float bRampTime=1.0000000);  // Export UTgStaticMeshActor_CapturePoint::execSetCapturePercent(FFrame&, void* const)

simulated event SetCaptureStatus(int nCaptureStatus, float fPercent) { }

defaultproperties
{}
