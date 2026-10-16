class TgDeviceForm_LongbowInhand extends TgDeviceForm
    native(ChampLongbow);

var bool m_bImpalerArrowFXIsActive;
var bool m_bBowDrawing;
var float m_fBowDrawPercentage;
var float m_fBowDrawStartPercentage;
var float m_fBowDrawTime;
var float m_fBowDrawTotalDuration;
var TgPawn_Longbow m_LongbowOwner;
var array<TgAnimBlendByPercent> m_BlendByPct1P;
var array<TgAnimBlendByPercent> m_BlendByPct3P;
var TgSkelControlSingleBone m_ArrowSkelControl1P;
var TgSkelControlSingleBone m_ImpalerSkelControl1P;

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPercent bbpctAnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_BlendByPct1P.Length = 0;
    m_ArrowSkelControl1P = none;
    m_ImpalerSkelControl1P = none;
    // End:0x6C
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xB7
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPercent', bbpctAnimNode)
    {
        m_BlendByPct1P.AddItem(bbpctAnimNode);        
    }    
    m_ArrowSkelControl1P = TgSkelControlSingleBone(SkelComp.FindSkelControl('Arrow'));
    m_ImpalerSkelControl1P = TgSkelControlSingleBone(SkelComp.FindSkelControl('ImpalerArrow'));
    //return;    
}

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPercent bbpctAnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_BlendByPct3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPercent', bbpctAnimNode)
    {
        m_BlendByPct3P.AddItem(bbpctAnimNode);        
    }    
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgAnimBlendByPercent bbpctAnimNode;

    // End:0x50
    foreach m_BlendByPct1P(bbpctAnimNode)
    {
        bbpctAnimNode.UpdatePercent(m_fBowDrawPercentage);        
    }    
    // End:0x91
    foreach m_BlendByPct3P(bbpctAnimNode)
    {
        bbpctAnimNode.UpdatePercent(m_fBowDrawPercentage);        
    }    
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}

event Generic1(optional byte byExtraData)
{
    SetToggleState(false);
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    SetToggleState(false);
    //return;    
}

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    super.PlayToggleTransitionAnimations(transitionPercent, totalTransitionTime, transitionToActive);
    // End:0x16D
    if((((m_bBowDrawing != transitionToActive) && PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        // End:0x118
        if(transitionToActive)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic3', 0);            
        }
        else
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic3', 0);
        }
    }
    m_bBowDrawing = transitionToActive;
    // End:0x21E
    if(m_bBowDrawing)
    {
        PawnOwner.m_WeaponMesh.BlockFlourish(true);
        m_fBowDrawPercentage = transitionPercent;
        m_fBowDrawStartPercentage = m_fBowDrawPercentage;
        m_fBowDrawTime = 0.0000000;
        m_fBowDrawTotalDuration = (1.0000000 - transitionPercent) * totalTransitionTime;
    }
    //return;    
}

simulated event SetToggleState(bool IsActive)
{
    super.SetToggleState(IsActive);
    // End:0x2E5
    if(((m_bBowDrawing != IsActive) && PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        // End:0x194
        if(IsActive)
        {
            // End:0x101
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic3', 0);
            }
            // End:0x191
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('Generic3', 0);
            }            
        }
        else
        {
            // End:0x222
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic3', 0);
            }
            // End:0x2B0
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Generic3', 0);
            }
            PawnOwner.m_WeaponMesh.BlockFlourish(false);
        }
    }
    m_bBowDrawing = IsActive;
    // End:0x329
    if(m_bBowDrawing)
    {
        m_fBowDrawPercentage = 1.0000000;
        m_fBowDrawTime = m_fBowDrawTotalDuration;
    }
    //return;    
}
