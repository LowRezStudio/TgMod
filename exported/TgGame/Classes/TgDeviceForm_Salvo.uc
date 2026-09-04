class TgDeviceForm_Salvo extends TgDeviceForm
    native(ChampDrogoz);

var array<TgAnimNodeBlendList> m_SalvoBlendList1P;
var array<TgAnimNodeBlendList> m_SalvoBlendList3P;
var bool m_bSalvoLightShouldBlink;
var bool m_bSalvoLightIsOn;
var float m_fLastLightChangeTime;
var float m_fMinLightChangeTime;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendList AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_SalvoBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xCD
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendList', AnimNode)
    {
        // End:0xCC
        if(AnimNode.NodeName == 'SalvoNeedle')
        {
            m_SalvoBlendList3P.AddItem(AnimNode);
        }        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendList AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_SalvoBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xCD
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendList', AnimNode)
    {
        // End:0xCC
        if(AnimNode.NodeName == 'SalvoNeedle')
        {
            m_SalvoBlendList1P.AddItem(AnimNode);
        }        
    }    
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgDeviceForm inhandDeviceForm;
    local int I;

    // End:0x74
    if(PawnOwner != none)
    {
        inhandDeviceForm = PawnOwner.c_EquipForm[1];
        // End:0x74
        if(inhandDeviceForm != none)
        {
            inhandDeviceForm.SetAmmoBlendNodesAmount(nAmmoRemaining);
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    I = 0;
    J0xAD:

    // End:0x140 [Loop If]
    if(I < m_SalvoBlendList1P.Length)
    {
        // End:0x132
        if(m_SalvoBlendList1P[I] != none)
        {
            m_SalvoBlendList1P[I].SetActiveChild(1, m_SalvoBlendList1P[I].GetBlendTime(1));
        }
        I++;
        // [Loop Continue]
        goto J0xAD;
    }
    I = 0;
    J0x14B:

    // End:0x1DE [Loop If]
    if(I < m_SalvoBlendList3P.Length)
    {
        // End:0x1D0
        if(m_SalvoBlendList3P[I] != none)
        {
            m_SalvoBlendList3P[I].SetActiveChild(1, m_SalvoBlendList3P[I].GetBlendTime(1));
        }
        I++;
        // [Loop Continue]
        goto J0x14B;
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x2D5
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Drogoz_SalvoSteam', 0);
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Drogoz_SalvoBeep', 0);
        I = 0;
        J0x17A:

        // End:0x280 [Loop If]
        if(I < PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials.Length)
        {
            MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials[I]);
            // End:0x272
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Ultimate', 1.0000000);
            }
            I++;
            // [Loop Continue]
            goto J0x17A;
        }
        m_bSalvoLightShouldBlink = true;
        m_bSalvoLightIsOn = true;
        m_fLastLightChangeTime = PawnOwner.WorldInfo.TimeSeconds;
    }
    // End:0x39C
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('Drogoz_SalvoSteam', 0);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.StopFire(nFireModeNum);
    I = 0;
    J0x1E:

    // End:0xB1 [Loop If]
    if(I < m_SalvoBlendList1P.Length)
    {
        // End:0xA3
        if(m_SalvoBlendList1P[I] != none)
        {
            m_SalvoBlendList1P[I].SetActiveChild(0, m_SalvoBlendList1P[I].GetBlendTime(0));
        }
        I++;
        // [Loop Continue]
        goto J0x1E;
    }
    I = 0;
    J0xBC:

    // End:0x14F [Loop If]
    if(I < m_SalvoBlendList3P.Length)
    {
        // End:0x141
        if(m_SalvoBlendList3P[I] != none)
        {
            m_SalvoBlendList3P[I].SetActiveChild(0, m_SalvoBlendList3P[I].GetBlendTime(0));
        }
        I++;
        // [Loop Continue]
        goto J0xBC;
    }
    // End:0x37A
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Drogoz_SalvoSteam', 0);
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Drogoz_SalvoBeep', 0);
        I = 0;
        J0x274:

        // End:0x37A [Loop If]
        if(I < PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials.Length)
        {
            MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials[I]);
            // End:0x36C
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Ultimate', 0.0000000);
            }
            I++;
            // [Loop Continue]
            goto J0x274;
        }
    }
    // End:0x43F
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Drogoz_SalvoSteam', 0);
    }
    m_bSalvoLightShouldBlink = false;
    m_bSalvoLightIsOn = false;
    //return;    
}

defaultproperties
{
    m_fMinLightChangeTime=0.3000000
}