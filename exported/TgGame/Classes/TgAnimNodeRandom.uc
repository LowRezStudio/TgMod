class TgAnimNodeRandom extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native TgRandomAnimInfo
{
    var() float Chance;
    var() byte LoopCountMin;
    var() byte LoopCountMax;
    var() float BlendInTime;
    var() bool bCanRepeat;
    var byte LoopCount;
    var() bool bCallOnAnimEndOnParent;
    var() bool m_bChooseNewNodeOnAnimEnd;
    var() Vector2D m_ChildActiveTime;

    structdefaultproperties
    {
        Chance=1.0000000
        LoopCountMin=0
        LoopCountMax=1
        BlendInTime=0.1000000
        bCanRepeat=false
        LoopCount=0
        bCallOnAnimEndOnParent=true
        m_bChooseNewNodeOnAnimEnd=true
        m_ChildActiveTime=(X=2.0000000,Y=5.0000000)
    }
};

var() int m_iDefaultChildIndex;
var() bool m_bConsiderRelevancy;
var(Master) bool m_bMasterOtherNodes;
var transient bool m_bIsASlave;
var(Time) bool m_bEnableTimer;
var(Time) bool m_TimeAllChildren;
var(Master) array<name> m_SlaveNames;
var transient array<TgAnimNodeRandom> m_Slaves;
var(Time) int m_nPrimaryChild;
var(Time) Vector2D m_TimeRange;
var float m_fRemainingTime;
var() editfixedsize editinline array<editinline TgRandomAnimInfo> RandomInfo;

defaultproperties
{
    m_iDefaultChildIndex=-1
    m_bConsiderRelevancy=true
    m_TimeRange=(X=5.0000000,Y=10.0000000)
    ActiveChildIndex=-1
    bPlayActiveChild=true
}