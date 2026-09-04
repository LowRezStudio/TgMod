class TgBeamHelper extends TgObject
    native(BeamHelper)
    config(Engine);

var int m_nSpecialFxId;
var TgSpecialFx m_pSpecialFx;
var export editinline array<export editinline ParticleSystemComponent> m_pPSCList;
var bool m_bVisibilityEnabled;
var bool m_bCurrentlyVisible;
var bool m_bRequiresTarget;
var bool m_bTangentsEnabled;
var Vector m_vInitialTangent;
var Actor m_pOwner;
var Actor m_pTarget;
var export editinline MeshComponent m_pAttachMesh;
var name m_nmAttachMeshSocket;

native function TgBeamHelper Create(int nSpecialFxId);  // Export UTgBeamHelper::execCreate(FFrame&, void* const)

native function TgBeamHelper CreateFromFx(TgSpecialFx pSpecialFx);  // Export UTgBeamHelper::execCreateFromFx(FFrame&, void* const)

native function Initialize(int nSpecialFxId);  // Export UTgBeamHelper::execInitialize(FFrame&, void* const)

native function InitializeFromFx(TgSpecialFx pSpecialFx);  // Export UTgBeamHelper::execInitializeFromFx(FFrame&, void* const)

native function SetEndPoint(Vector vEndPoint);  // Export UTgBeamHelper::execSetEndPoint(FFrame&, void* const)

native function SetTangents(Vector vSourceTangent, Vector vTargetTangent);  // Export UTgBeamHelper::execSetTangents(FFrame&, void* const)

native function SetTangentsMulti(array<Vector> vSourceTangents, array<Vector> vTargetTangents);  // Export UTgBeamHelper::execSetTangentsMulti(FFrame&, void* const)

native function Tick(float fDeltaSeconds);  // Export UTgBeamHelper::execTick(FFrame&, void* const)

native function AttachToOwner(Actor pOwner);  // Export UTgBeamHelper::execAttachToOwner(FFrame&, void* const)

native function AttachToMesh(MeshComponent pMesh, name nmSocket);  // Export UTgBeamHelper::execAttachToMesh(FFrame&, void* const)

native function AttachToTarget(Actor pTarget);  // Export UTgBeamHelper::execAttachToTarget(FFrame&, void* const)

native function Activate();  // Export UTgBeamHelper::execActivate(FFrame&, void* const)

native function Deactivate(bool bForceDeactivate);  // Export UTgBeamHelper::execDeactivate(FFrame&, void* const)

native function SetVisible(bool bVisible);  // Export UTgBeamHelper::execSetVisible(FFrame&, void* const)

native function EnableTangents();  // Export UTgBeamHelper::execEnableTangents(FFrame&, void* const)

defaultproperties
{
    m_bCurrentlyVisible=true
    m_vInitialTangent=(X=30.0000000,Y=0.0000000,Z=0.0000000)
}
