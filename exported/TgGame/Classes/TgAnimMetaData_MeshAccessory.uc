class TgAnimMetaData_MeshAccessory extends AnimMetaData
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

struct native MeshPlacement
{
    var() int nSkinId;
    var() int nMeshId;
    var() name SocketName;

    structdefaultproperties
    {
        nSkinId=0
        nMeshId=0
        SocketName="None"
    }
};

var() editinline array<editinline MeshPlacement> m_Meshes;
var() bool m_bSkinIndependent;
var() bool m_bSetKeysNoInterp;
var() bool m_bUseScaling;
var export editinline transient SkeletalMeshComponent m_MeshComp;
var transient int m_nMeshId;
var() editinline array<editinline TimeModifier> m_KeyFrames;
var() float m_fBecomeRelevantScale;
var() float m_fCeaseRelevantScale;

defaultproperties
{
    m_fBecomeRelevantScale=1.0000000
}