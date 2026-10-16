class TgEffectForm_WithMeshes extends TgEffectForm
    native(Effects)
    config(Engine);

struct EffectMeshInfo {
    var export editinline MeshComponent Mesh;
    var int nMeshId;
    var name DisplayGroup;
    var bool AbsoluteTranslation;
    var bool AbsoluteRotation;
    var bool AbsoluteScale;
    var bool bWillSelfDestruct;
    var Vector vAdditiveTranslation;
    var Rotator rAdditiveRotation;
    var float fScaleMultipler;
    structdefaultproperties {}
};

var array<EffectMeshInfo> m_EffectMeshInfos;

native function RecalculateFx();  // Export UTgEffectForm_WithMeshes::execRecalculateFx(FFrame&, void* const)

native function ShowEffectForm(bool bLocal);  // Export UTgEffectForm_WithMeshes::execShowEffectForm(FFrame&, void* const)

native function HideEffectForm();  // Export UTgEffectForm_WithMeshes::execHideEffectForm(FFrame&, void* const)

native function Attach(Actor pOwner);  // Export UTgEffectForm_WithMeshes::execAttach(FFrame&, void* const)

native function Reattach();  // Export UTgEffectForm_WithMeshes::execReattach(FFrame&, void* const)

native function Detach();  // Export UTgEffectForm_WithMeshes::execDetach(FFrame&, void* const)

native function AdjustHidden();  // Export UTgEffectForm_WithMeshes::execAdjustHidden(FFrame&, void* const)

native function AttachMeshes(Actor pOwner);  // Export UTgEffectForm_WithMeshes::execAttachMeshes(FFrame&, void* const)

native function DetachMeshes();  // Export UTgEffectForm_WithMeshes::execDetachMeshes(FFrame&, void* const)
