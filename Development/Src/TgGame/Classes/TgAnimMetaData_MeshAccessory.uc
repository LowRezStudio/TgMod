class TgAnimMetaData_MeshAccessory extends AnimMetaData
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct MeshPlacement {
    var () int nSkinId;
    var () int nMeshId;
    var () name SocketName;
    structdefaultproperties {}
};

var () editinline array<MeshPlacement> m_Meshes;
var () bool m_bSkinIndependent;
var () bool m_bSetKeysNoInterp;
var () bool m_bUseScaling;
var export editinline transient SkeletalMeshComponent m_MeshComp;
var transient int m_nMeshId;
var () editinline array<TimeModifier> m_KeyFrames;
var () float m_fBecomeRelevantScale;
var () float m_fCeaseRelevantScale;

defaultproperties
{
    m_fBecomeRelevantScale=1.0000000
}
