class TgAnimNodeBlendNPC extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

enum NPCAnimationStates
{
    NPCAS_NoCustomerPresent,        // 0
    NPCAS_CustomerPresent,          // 1
    NPCAS_Greeting,                 // 2
    NPCAS_NoSale,                   // 3
    NPCAS_CallOut,                  // 4
    NPCAS_Sale,                     // 5
    NPCAS_TransCustomerPresentToNotPresent,// 6
    NPCAS_None,                     // 7
    NPCAS_MAX                       // 8
};

var() float m_NoCustomerPresentBlendInTime;
var() float m_CustomerPresentBlendInTime;
var() float m_GreetingBlendInTime;
var() float m_NoSaleBlendInTime;
var() float m_CallOutBlendInTime;
var() float m_SaleBlendInTime;
var() float m_TransCustomerPresentToNotPresentBlendInTime;
var() array<name> m_UninterruptibleAnims;
var TgAnimNodeBlendNPC.NPCAnimationStates m_QueuedChild;
var float m_QueuedBlendTime;
var name m_CurrentAnimPlaying;

function bool IsAnUninterruptableAnim(name AnimName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x54 [Loop If]
    if(I < m_UninterruptibleAnims.Length)
    {
        // End:0x46
        if(m_UninterruptibleAnims[I] == AnimName)
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

function QueueActiveChild(TgAnimNodeBlendNPC.NPCAnimationStates QueuedChild, float BlendTime)
{
    m_QueuedChild = QueuedChild;
    m_QueuedBlendTime = BlendTime;
    //return;    
}

function PlayNoCustomerPresentAnimation()
{
    // End:0x12
    if(ActiveChildIndex == 6)
    {
        return;
    }
    // End:0x39
    if(ActiveChildIndex == 1)
    {
        SetActiveChild(6, m_TransCustomerPresentToNotPresentBlendInTime);        
    }
    else
    {
        SetActiveChild(0, m_NoCustomerPresentBlendInTime);
    }
    //return;    
}

function PlayGreetingAnimation()
{
    // End:0x40
    if((ActiveChildIndex == 4) && IsAnUninterruptableAnim(m_CurrentAnimPlaying))
    {
        QueueActiveChild(2, m_GreetingBlendInTime);        
    }
    else
    {
        SetActiveChild(2, m_GreetingBlendInTime);
    }
    //return;    
}

function PlayCustomerPresentAnimation()
{
    SetActiveChild(1, m_CustomerPresentBlendInTime);
    //return;    
}

function PlayCallOutAnimation()
{
    SetActiveChild(4, m_CallOutBlendInTime);
    //return;    
}

function PlayNoSaleAnimation()
{
    SetActiveChild(3, m_NoSaleBlendInTime);
    //return;    
}

function PlaySaleAnimation()
{
    SetActiveChild(5, m_SaleBlendInTime);
    //return;    
}

simulated event OnChildAnimEnd(AnimationEndInformation Information)
{
    local AnimNodeSequence Child;

    Child = AnimNodeSequence(Information.TreeBranchToLeaf[Information.TreeBranchToLeaf.Length - 1]);
    // End:0x153
    if(Child.NodeTotalWeight > 0.0000000)
    {
        // End:0xE3
        if((int(m_QueuedChild) != int(7)) && IsAnUninterruptableAnim(Child.AnimSeqName))
        {
            SetActiveChild(int(m_QueuedChild), m_QueuedBlendTime);
            m_QueuedChild = 7;
        }
        // End:0x10A
        if(ActiveChildIndex == 6)
        {
            SetActiveChild(0, m_NoCustomerPresentBlendInTime);            
        }
        else
        {
            // End:0x127
            if(ActiveChildIndex == 4)
            {
                PlayNoCustomerPresentAnimation();                
            }
            else
            {
                // End:0x153
                if((ActiveChildIndex == 3) || ActiveChildIndex == 5)
                {
                    PlayCustomerPresentAnimation();
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_NoCustomerPresentBlendInTime=0.4000000
    m_CustomerPresentBlendInTime=0.4000000
    m_GreetingBlendInTime=0.4000000
    m_NoSaleBlendInTime=0.4000000
    m_CallOutBlendInTime=0.4000000
    m_SaleBlendInTime=0.4000000
    m_TransCustomerPresentToNotPresentBlendInTime=0.4000000
    m_QueuedChild=NPCAnimationStates.NPCAS_None
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    NodeName="NPCBlend"
}