class TgDeviceForm_Spite extends TgDeviceForm
    native(ChampDarklord);

var array<TgAnimNodeChannelFire_Spite> m_SpiteNodes3p;
var array<TgAnimNodeChannelFire_Spite> m_SpiteNodes1p;
var array<TgAnimBlendByPaladinsCharacter_Darklord> m_DarklordNodes1p;
var bool bFOVZoomActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVModifier;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeChannelFire_Spite AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_SpiteNodes3p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire_Spite', AnimNode)
    {
        m_SpiteNodes3p.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeChannelFire_Spite AnimNode;
    local TgAnimBlendByPaladinsCharacter_Darklord animNode2;

    super.Cache1PAnimNodes(SkelComp);
    m_SpiteNodes1p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire_Spite', AnimNode)
    {
        m_SpiteNodes1p.AddItem(AnimNode);        
    }    
    // End:0xED
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPaladinsCharacter_Darklord', animNode2)
    {
        m_DarklordNodes1p.AddItem(animNode2);        
    }    
    //return;    
}

event Generic1(optional byte byExtraData)
{
    TriggerFOVZoom(true);
    super.Generic1(byExtraData);
    //return;    
}

event Generic2(optional byte byExtraData)
{
    TriggerFOVZoom(false);
    super.Generic2(byExtraData);
    //return;    
}

event Generic3(optional byte byExtraData)
{
    local int I;
    local TgDevice_Spite.SpiteAnimState animState;

    animState = byExtraData;
    I = 0;
    J0x1F:

    // End:0x90 [Loop If]
    if(I < m_SpiteNodes3p.Length)
    {
        // End:0x82
        if(m_SpiteNodes3p[I] != none)
        {
            m_SpiteNodes3p[I].SetAnimState(animState);
        }
        I++;
        // [Loop Continue]
        goto J0x1F;
    }
    I = 0;
    J0x9B:

    // End:0x10C [Loop If]
    if(I < m_SpiteNodes1p.Length)
    {
        // End:0xFE
        if(m_SpiteNodes1p[I] != none)
        {
            m_SpiteNodes1p[I].SetAnimState(animState);
        }
        I++;
        // [Loop Continue]
        goto J0x9B;
    }
    // End:0x146
    if(int(animState) == int(1))
    {
        DeactivateFxGroup('Darklord_UltHitStart');
        ActivateFxGroup('Darklord_UltHitStart');
    }
    //return;    
}

event Generic4(optional byte byExtraData)
{
    local int I;
    local bool bTargetDied;

    bTargetDied = int(byExtraData) == int(1);
    I = 0;
    J0x28:

    // End:0x9B [Loop If]
    if(I < m_DarklordNodes1p.Length)
    {
        // End:0x8D
        if(m_DarklordNodes1p[I] != none)
        {
            m_DarklordNodes1p[I].m_bTriggerUltKilledTargetRetrieve = bTargetDied;
        }
        I++;
        // [Loop Continue]
        goto J0x28;
    }
    //return;    
}

event Generic5(optional byte byExtraData)
{
    DeactivateFxGroup('Darklord_UltHitStart');
    //return;    
}

event StopFire(int nFireModeNum)
{
    TriggerFOVZoom(false);
    super.StopFire(nFireModeNum);
    //return;    
}

simulated function TriggerFOVZoom(bool bActive)
{
    local TgPawn_Character TgP;
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;

    // End:0x198
    if(bFOVZoomActive != bActive)
    {
        bFOVZoomActive = bActive;
        TgP = TgPawn_Character(PawnOwner);
        // End:0x198
        if(TgP != none)
        {
            TgPC = TgPlayerController(TgP.GetALocalPlayerController());
            // End:0x198
            if((TgPC != none) && TgPC.GetTgPawn() == TgP)
            {
                Cam = TgPlayerCamera(TgPC.PlayerCamera);
                // End:0x198
                if(Cam != none)
                {
                    // End:0x16B
                    if(bFOVZoomActive)
                    {
                        Cam.InterpolateFOV(Cam.GetFOVAngle() + m_fFOVModifier, m_fCameraFOVInterpolationTime);                        
                    }
                    else
                    {
                        Cam.InterpolateFOV(0.0000000, m_fCameraFOVInterpolationTime);
                    }
                }
            }
        }
    }
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    local int I;

    // End:0x117
    if((int(DesiredState) == int(0)) && FormState == 'DeviceFiring')
    {
        I = 0;
        J0x38:

        // End:0xA2 [Loop If]
        if(I < m_SpiteNodes3p.Length)
        {
            // End:0x94
            if(m_SpiteNodes3p[I] != none)
            {
                m_SpiteNodes3p[I].SetAnimState(4);
            }
            I++;
            // [Loop Continue]
            goto J0x38;
        }
        I = 0;
        J0xAD:

        // End:0x117 [Loop If]
        if(I < m_SpiteNodes1p.Length)
        {
            // End:0x109
            if(m_SpiteNodes1p[I] != none)
            {
                m_SpiteNodes1p[I].SetAnimState(4);
            }
            I++;
            // [Loop Continue]
            goto J0xAD;
        }
    }
    super.RecoverDeviceState(DesiredState);
    //return;    
}

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.1200000
    m_fFOVModifier=10.0000000
}