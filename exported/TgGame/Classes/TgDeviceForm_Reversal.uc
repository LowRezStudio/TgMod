class TgDeviceForm_Reversal extends TgDeviceForm
    native(ChampAndroxus);

var float m_fAccumulatedDamage;
var float m_fMaxChargeDamage;
var TgEmitter_CameraEffect c_CameraEffect;
var array<TgAnimNodeBlendList> m_1pNodes;
var array<TgAnimNodeBlendList> m_3pNodes;
var bool m_bIsAbsorbingShots;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityReversal AnimNode;

    m_3pNodes.Length = 0;
    super.Cache3PAnimNodes(SkelComp);
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityReversal', AnimNode)
    {
        m_3pNodes.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityReversal AnimNode;

    m_1pNodes.Length = 0;
    super.Cache1PAnimNodes(SkelComp);
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityReversal', AnimNode)
    {
        m_1pNodes.AddItem(AnimNode);        
    }    
    //return;    
}

function SetActiveChildren(TgAnimNodeBlendByAbilityReversal.EBlendReversal ChildIndex)
{
    local int I;
    local float fBlendTime;

    I = 0;
    J0x0B:

    // End:0xC5 [Loop If]
    if(I < m_1pNodes.Length)
    {
        // End:0xB7
        if(m_1pNodes[I] != none)
        {
            fBlendTime = m_1pNodes[I].GetBlendTime(int(ChildIndex));
            m_1pNodes[I].SetActiveChild(int(ChildIndex), fBlendTime);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0xD0:

    // End:0x18A [Loop If]
    if(I < m_3pNodes.Length)
    {
        // End:0x17C
        if(m_3pNodes[I] != none)
        {
            fBlendTime = m_3pNodes[I].GetBlendTime(int(ChildIndex));
            m_3pNodes[I].SetActiveChild(int(ChildIndex), fBlendTime);
        }
        I++;
        // [Loop Continue]
        goto J0xD0;
    }
    //return;    
}

event UpdateAccumulatedDamage(float newDamage)
{
    local TgSpecialFx chargeFX;
    local editinline ParticleSystemComponent PSC;
    local int I;
    local float chargePercent;

    // End:0x24
    if(newDamage >= float(0))
    {
        m_fAccumulatedDamage = newDamage;
    }
    chargePercent = m_fAccumulatedDamage / m_fMaxChargeDamage;
    // End:0x212
    if(c_Mesh != none)
    {
        chargeFX = TgSpecialFx(c_Mesh.FxGet('Reversal_ChargeUp', 0));
        // End:0x212
        if(chargeFX != none)
        {
            I = 0;
            J0xAA:

            // End:0x16A [Loop If]
            if(I < chargeFX.c_PSCList.Length)
            {
                PSC = chargeFX.c_PSCList[I].c_PSC;
                // End:0x15C
                if(PSC != none)
                {
                    PSC.SetFloatParameter('Power', chargePercent);
                }
                I++;
                // [Loop Continue]
                goto J0xAA;
            }
            // End:0x1D0
            if(chargePercent > float(0))
            {
                // End:0x1CD
                if(!chargeFX.c_bActive)
                {
                    // End:0x1CD
                    if(m_bIsAbsorbingShots)
                    {
                        chargeFX.Activate();
                    }
                }                
            }
            else
            {
                // End:0x212
                if(chargeFX.c_bActive)
                {
                    chargeFX.Deactivate(true);
                }
            }
        }
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    m_bIsAbsorbingShots = true;
    UpdateAccumulatedDamage(0.0000000);
    SetActiveChildren(1);
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    m_bIsAbsorbingShots = false;
    // End:0x2E
    if(m_fAccumulatedDamage > 0.0000000)
    {
        SetActiveChildren(2);        
    }
    else
    {
        SetActiveChildren(3);
    }
    UpdateAccumulatedDamage(0.0000000);
    super.StopFire(nFireModeNum);
    //return;    
}

event DoInterrupt()
{
    m_bIsAbsorbingShots = false;
    UpdateAccumulatedDamage(0.0000000);
    super.DoInterrupt();
    //return;    
}

defaultproperties
{
    m_fMaxChargeDamage=800.0000000
}