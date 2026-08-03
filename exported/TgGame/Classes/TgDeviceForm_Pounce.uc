class TgDeviceForm_Pounce extends TgDeviceForm
    native(ChampBlades);

var array<TgAnimNodeChannelFire_Pounce> m_PounceNodes3p;
var array<TgAnimNodeChannelFire_Pounce> m_PounceNodes1p;
var bool bFOVZoomActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVModifier;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeChannelFire_Pounce AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_PounceNodes3p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire_Pounce', AnimNode)
    {
        m_PounceNodes3p.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeChannelFire_Pounce AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_PounceNodes1p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire_Pounce', AnimNode)
    {
        m_PounceNodes1p.AddItem(AnimNode);        
    }    
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    SetPounceNodeHitSuccessful(bSuccessfulHit);
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    SetPounceNodeHitSuccessful(true);
    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    //return;    
}

event SetPounceNodeHitSuccessful(bool bSuccessfulHit)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7E [Loop If]
    if(I < m_PounceNodes3p.Length)
    {
        // End:0x70
        if(m_PounceNodes3p[I] != none)
        {
            m_PounceNodes3p[I].m_bPounceHitSuccessful = bSuccessfulHit;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x89:

    // End:0xFC [Loop If]
    if(I < m_PounceNodes1p.Length)
    {
        // End:0xEE
        if(m_PounceNodes1p[I] != none)
        {
            m_PounceNodes1p[I].m_bPounceHitSuccessful = bSuccessfulHit;
        }
        I++;
        // [Loop Continue]
        goto J0x89;
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

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.1200000
    m_fFOVModifier=10.0000000
}