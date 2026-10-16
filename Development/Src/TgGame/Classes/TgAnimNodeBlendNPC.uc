class TgAnimNodeBlendNPC extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum NPCAnimationStates {
    NPCAS_NoCustomerPresent,  // 0
    NPCAS_CustomerPresent,  // 1
    NPCAS_Greeting,  // 2
    NPCAS_NoSale,  // 3
    NPCAS_CallOut,  // 4
    NPCAS_Sale,  // 5
    NPCAS_TransCustomerPresentToNotPresent,  // 6
    NPCAS_None,  // 7
};

var () float m_NoCustomerPresentBlendInTime;
var () float m_CustomerPresentBlendInTime;
var () float m_GreetingBlendInTime;
var () float m_NoSaleBlendInTime;
var () float m_CallOutBlendInTime;
var () float m_SaleBlendInTime;
var () float m_TransCustomerPresentToNotPresentBlendInTime;
var () array<name> m_UninterruptibleAnims;
var TgAnimNodeBlendNPC.NPCAnimationStates m_QueuedChild;
var float m_QueuedBlendTime;
var name m_CurrentAnimPlaying;

function bool IsAnUninterruptableAnim(name AnimName) { }

function QueueActiveChild(TgAnimNodeBlendNPC.NPCAnimationStates QueuedChild, float BlendTime) { }

function PlayNoCustomerPresentAnimation() { }

function PlayGreetingAnimation() { }

function PlayCustomerPresentAnimation() { }

function PlayCallOutAnimation() { }

function PlayNoSaleAnimation() { }

function PlaySaleAnimation() { }

simulated event OnChildAnimEnd(AnimationEndInformation Information) { }

defaultproperties
{
    m_NoCustomerPresentBlendInTime=0.4000000
    m_CustomerPresentBlendInTime=0.4000000
    m_GreetingBlendInTime=0.4000000
    m_NoSaleBlendInTime=0.4000000
    m_CallOutBlendInTime=0.4000000
    m_SaleBlendInTime=0.4000000
    m_TransCustomerPresentToNotPresentBlendInTime=0.4000000
    m_QueuedChild=NPCAS_None
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    NodeName="NPCBlend"
}
