class TgAnimBlendByAmmo extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native AmmoBlendParams
{
    var() int MinAmmo;
    var() int MaxAmmo;
    var() int ChildNum;

    structdefaultproperties
    {
        MinAmmo=0
        MaxAmmo=0
        ChildNum=0
    }
};

var() int m_nDefaultChild;
var() TgObject.TG_EQUIP_POINT m_EquipPoint;
var() bool m_bDelayUpdateUntilReplay;
var() bool m_bCheckAmmoPerTick;
var() array<AmmoBlendParams> m_ChildAmmoParams;
var int m_nPendingChildIndex;
var int m_nAmmoUpdateTickTag;

// Export UTgAnimBlendByAmmo::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float Rate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimBlendByAmmo::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

simulated function SetAmmoAmt(int nAmmo)
{
    local int I, targetAmmoChild;

    targetAmmoChild = m_nDefaultChild;
    I = 0;
    J0x1E:

    // End:0xDE [Loop If]
    if(I < m_ChildAmmoParams.Length)
    {
        // End:0xD0
        if((nAmmo >= m_ChildAmmoParams[I].MinAmmo) && nAmmo <= m_ChildAmmoParams[I].MaxAmmo)
        {
            targetAmmoChild = m_ChildAmmoParams[I].ChildNum;
        }
        I++;
        // [Loop Continue]
        goto J0x1E;
    }
    SetAmmoChild(targetAmmoChild);
    //return;    
}

private final simulated function SetAmmoChild(int targetAmmoChild)
{
    // End:0xCC
    if((targetAmmoChild >= 0) && targetAmmoChild < Children.Length)
    {
        // End:0x61
        if(!m_bDelayUpdateUntilReplay)
        {
            SetActiveChild(targetAmmoChild, GetBlendTime(targetAmmoChild));            
        }
        else
        {
            m_nPendingChildIndex = targetAmmoChild;
            // End:0xCC
            if(ActiveChildIndex != m_nPendingChildIndex)
            {
                // End:0xCC
                if(bJustBecameRelevant || (m_nAmmoUpdateTickTag + 1) >= NodeTickTag)
                {
                    SetActiveChild(targetAmmoChild, 0.0000000);
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_EquipPoint=TG_EQUIP_POINT.EQP_AUTO
    m_bDelayUpdateUntilReplay=true
    m_ChildAmmoParams[0]=(MinAmmo=2,MaxAmmo=10000,ChildNum=0)
    m_ChildAmmoParams[1]=(MinAmmo=1,MaxAmmo=1,ChildNum=1)
    DefaultBlendTime=0.1000000
    Children=/* Array type was not detected. */
}