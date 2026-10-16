class TgEffectForm_WithMeshes extends TgEffectForm
    native(Effects);

struct native EffectMeshInfo
{
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

    structdefaultproperties
    {
        Mesh=none
        nMeshId=0
        DisplayGroup="None"
        AbsoluteTranslation=false
        AbsoluteRotation=false
        AbsoluteScale=false
        bWillSelfDestruct=false
        vAdditiveTranslation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        rAdditiveRotation=(Pitch=0,Yaw=0,Roll=0)
        fScaleMultipler=0.0000000
    }
};

var array<EffectMeshInfo> m_EffectMeshInfos;

// Export UTgEffectForm_WithMeshes::execRecalculateFx(FFrame&, void* const)
native function RecalculateFx();

// Export UTgEffectForm_WithMeshes::execShowEffectForm(FFrame&, void* const)
native function ShowEffectForm(bool bLocal);

// Export UTgEffectForm_WithMeshes::execHideEffectForm(FFrame&, void* const)
native function HideEffectForm();

// Export UTgEffectForm_WithMeshes::execAttach(FFrame&, void* const)
native function Attach(Actor pOwner);

// Export UTgEffectForm_WithMeshes::execReattach(FFrame&, void* const)
native function Reattach();

// Export UTgEffectForm_WithMeshes::execDetach(FFrame&, void* const)
native function Detach();

// Export UTgEffectForm_WithMeshes::execAdjustHidden(FFrame&, void* const)
native function AdjustHidden();

// Export UTgEffectForm_WithMeshes::execAttachMeshes(FFrame&, void* const)
native function AttachMeshes(Actor pOwner);

// Export UTgEffectForm_WithMeshes::execDetachMeshes(FFrame&, void* const)
native function DetachMeshes();
