class TgDeviceForm_OracleInhand extends TgDeviceForm_Inhand
    native(ChampOracle);

var TgPawn_Oracle m_CachedOracle;
var float c_fLastReceivedTransitionInTime;

simulated function bool HasCachedOracle()
{
    // End:0x2B
    if(m_CachedOracle == none)
    {
        m_CachedOracle = TgPawn_Oracle(PawnOwner);
    }
    return m_CachedOracle != none;
    //return ReturnValue;    
}

simulated function TgAnimNodeSlot GetFullBodyAnimNode()
{
    // End:0xDD
    if(HasCachedOracle())
    {
        // End:0xDD
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            return TgAnimNodeSlot(m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.Animations.FindAnimNode('Fire'));
        }
    }
    return none;
    //return ReturnValue;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgAnimNodeSlot FireFullBodyAnimNode;

    super(TgDeviceForm).Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x2D2
    if(HasCachedOracle())
    {
        // End:0x169
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlash', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('MuzzleFlash', 0);
        }
        // End:0x274
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlash', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('MuzzleFlash', 0);
        }
        FireFullBodyAnimNode = GetFullBodyAnimNode();
        // End:0x2D2
        if(FireFullBodyAnimNode != none)
        {
            FireFullBodyAnimNode.PlayCustomAnim('ADD_Fire_Loop', 1.0000000, 0.0000000, 0.2000000, false, true);
        }
    }
    //return;    
}

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    super(TgDeviceForm).PlayToggleTransitionAnimations(transitionPercent, totalTransitionTime, transitionToActive);
    // End:0x46
    if(transitionToActive)
    {
        c_fLastReceivedTransitionInTime = totalTransitionTime;
    }
    // End:0x6C
    if((transitionPercent > 0.0000000) || !transitionToActive)
    {
        return;
    }
    // End:0x28F
    if(HasCachedOracle())
    {
        // End:0x184
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('TransitionInFull', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('TransitionInFull', 0);
        }
        // End:0x28F
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('TransitionInFull', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('TransitionInFull', 0);
        }
    }
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    super(TgDeviceForm).RecoverDeviceState(DesiredState);
    // End:0x40
    if(int(DesiredState) == int(1))
    {
        PlayToggleTransitionAnimations(0.0000000, c_fLastReceivedTransitionInTime, true);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    // End:0x232
    if(HasCachedOracle())
    {
        // End:0x129
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('TransitionInFull', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlash', 0);
        }
        // End:0x232
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('TransitionInFull', 0);
            m_CachedOracle.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlash', 0);
        }
    }
    //return;    
}

simulated function UpdateAmmoCountSingleFx(TgSpecialFx Fx, float fAmmoPerc)
{
    local int I;

    // End:0xF9
    if(Fx != none)
    {
        I = 0;
        J0x1A:

        // End:0xF9 [Loop If]
        if(I < Fx.c_PSCList.Length)
        {
            // End:0xEB
            if(Fx.c_PSCList[I].c_PSC != none)
            {
                Fx.c_PSCList[I].c_PSC.SetFloatParameter('AmmoCount', fAmmoPerc);
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc)
{
    local array<Object> FxList;
    local float fAmmoPerc;
    local int I;

    // End:0x173
    if(HasCachedOracle())
    {
        // End:0x41
        if(m_CachedOracle.r_bRestoreSoulActive)
        {
            fAmmoPerc = 0.0000000;            
        }
        else
        {
            fAmmoPerc = fCurrentPerc;
        }
        // End:0x173
        if((m_CachedOracle.m_WeaponMesh != none) && m_CachedOracle.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            FxList = PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGetAll('AlwaysOn', 0);
            I = 0;
            J0x11E:

            // End:0x173 [Loop If]
            if(I < FxList.Length)
            {
                UpdateAmmoCountSingleFx(TgSpecialFx(FxList[I]), fAmmoPerc);
                I++;
                // [Loop Continue]
                goto J0x11E;
            }
        }
    }
    //return;    
}

defaultproperties
{
    c_fLastReceivedTransitionInTime=0.2000000
}