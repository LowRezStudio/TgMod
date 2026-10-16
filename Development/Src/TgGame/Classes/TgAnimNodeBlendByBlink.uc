class TgAnimNodeBlendByBlink extends AnimNodeBlendPerBone
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var transient TgPawn m_TgPawn;
var export editinline transient SkeletalMeshComponent m_SkelMesh;
var () float m_fBlinkAnimRate;
var () Vector2D m_vTimeBetweenBlinks;
var float m_fTimeTillNextBlink;
var () array<name> m_DisableBlinkingAnimNodeNameList;
var transient array<AnimNode> m_CachedNodeList;
var transient bool m_bInitializedCachedNodeList;

defaultproperties
{
    m_fBlinkAnimRate=1.0000000
    m_vTimeBetweenBlinks=(X=2.0000000,Y=6.0000000)
    bForceLocalSpaceBlend=true
    BranchStartBoneName=/* Array type was not detected. */
}
