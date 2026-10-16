class TgDeviceForm_LexInhand extends TgDeviceForm
    native(ChampLex);

var name c_nmSocketLeft;
var name c_nmSocketRight;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes1P;
var array<TgAnimBlendByPaladinsCharacter_Lex> m_LexCharacterNodes3P;
var array<TgAnimNodeStanceDualFire> m_DualFireStanceNodes1P;
var array<TgAnimNodeStanceDualFire> m_DualFireStanceNodes3P;
var TgPawn_Lex m_CachedLex;
var int m_nPursuitFireIndex;

// Export UTgDeviceForm_LexInhand::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nMode);

simulated function bool HasCachedLex()
{
    // End:0x2B
    if(m_CachedLex == none)
    {
        m_CachedLex = TgPawn_Lex(PawnOwner);
    }
    return m_CachedLex != none;
    //return ReturnValue;    
}

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPaladinsCharacter_Lex LexNode;
    local TgAnimNodeStanceDualFire DualFireStanceNode;

    super.Cache1PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LexCharacterNodes1P.Length = 0;
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPaladinsCharacter_Lex', LexNode)
    {
        m_LexCharacterNodes1P.AddItem(LexNode);        
    }    
    m_DualFireStanceNodes1P.Length = 0;
    // End:0xF9
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeStanceDualFire', DualFireStanceNode)
    {
        m_DualFireStanceNodes1P.AddItem(DualFireStanceNode);        
    }    
    //return;    
}

simulated event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPaladinsCharacter_Lex LexNode;
    local TgAnimNodeStanceDualFire DualFireStanceNode;

    super.Cache3PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LexCharacterNodes3P.Length = 0;
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPaladinsCharacter_Lex', LexNode)
    {
        m_LexCharacterNodes3P.AddItem(LexNode);        
    }    
    m_DualFireStanceNodes3P.Length = 0;
    // End:0xF9
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeStanceDualFire', DualFireStanceNode)
    {
        m_DualFireStanceNodes3P.AddItem(DualFireStanceNode);        
    }    
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    // End:0xF7
    if(HasCachedLex())
    {
        // End:0x8C
        if(nFireMode == 0)
        {
            m_CachedLex.m_bFireLeftWeapon = !m_CachedLex.m_bFireLeftWeapon;
            SetDualFireParity(m_CachedLex.m_bFireLeftWeapon);            
        }
        else
        {
            m_CachedLex.m_bFireLeftWeapon = !((m_nPursuitFireIndex == 0) || m_nPursuitFireIndex == 1) || m_nPursuitFireIndex == 3;
            m_nPursuitFireIndex = (m_nPursuitFireIndex + 1) % 5;
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

simulated function OnAmmoChange()
{
    local TgAnimBlendByPaladinsCharacter_Lex LexNode;

    // End:0x46
    foreach m_LexCharacterNodes1P(LexNode)
    {
        // End:0x45
        if(LexNode != none)
        {
            LexNode.UpdateSlideSkelControls();
        }        
    }    
    // End:0x8D
    foreach m_LexCharacterNodes3P(LexNode)
    {
        // End:0x8C
        if(LexNode != none)
        {
            LexNode.UpdateSlideSkelControls();
        }        
    }    
    //return;    
}

simulated function SetDualFireParity(bool bLeftFire)
{
    local TgAnimNodeStanceDualFire DualFireStanceNode;

    // End:0x59
    foreach m_DualFireStanceNodes1P(DualFireStanceNode)
    {
        // End:0x58
        if(DualFireStanceNode != none)
        {
            DualFireStanceNode.ChangeStance(((bLeftFire) ? 0 : 1), true, true);
        }        
    }    
    // End:0xB3
    foreach m_DualFireStanceNodes3P(DualFireStanceNode)
    {
        // End:0xB2
        if(DualFireStanceNode != none)
        {
            DualFireStanceNode.ChangeStance(((bLeftFire) ? 0 : 1), true, true);
        }        
    }    
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x62
    if(!HasCachedLex())
    {
        return;
    }
    // End:0x4C4
    if(m_CachedLex != none)
    {
        // End:0x2AE
        if(!m_CachedLex.m_bFireLeftWeapon)
        {
            // End:0x1A0
            if((m_CachedLex.m_WeaponMesh != none) && m_CachedLex.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_CachedLex.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlashLeft', 0);
                m_CachedLex.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('MuzzleFlashLeft', 0);
            }
            // End:0x2AB
            if((m_CachedLex.m_WeaponMesh != none) && m_CachedLex.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                m_CachedLex.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlashLeft', 0);
                m_CachedLex.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('MuzzleFlashLeft', 0);
            }            
        }
        else
        {
            // End:0x3B9
            if((m_CachedLex.m_WeaponMesh != none) && m_CachedLex.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_CachedLex.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlashRight', 0);
                m_CachedLex.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('MuzzleFlashRight', 0);
            }
            // End:0x4C4
            if((m_CachedLex.m_WeaponMesh != none) && m_CachedLex.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                m_CachedLex.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlashRight', 0);
                m_CachedLex.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('MuzzleFlashRight', 0);
            }
        }
    }
    //return;    
}

event Vector GetTracerSocketLocation()
{
    local bool bFireLeftWeapon;
    local Vector socketPos;
    local Rotator socketRot;

    // End:0x43
    if((PawnOwner == none) || PawnOwner.Mesh == none)
    {
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    bFireLeftWeapon = false;
    // End:0x86
    if(HasCachedLex())
    {
        bFireLeftWeapon = m_CachedLex.m_bFireLeftWeapon;
    }
    PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(((bFireLeftWeapon) ? c_nmSocketLeft : c_nmSocketRight), socketPos, socketRot);
    return socketPos;
    //return ReturnValue;    
}

defaultproperties
{
    c_nmSocketLeft="WSO_Emit_02"
    c_nmSocketRight="WSO_Emit_01"
}