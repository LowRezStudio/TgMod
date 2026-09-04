class TgDeviceForm_BarrageFire extends TgDeviceForm
    native(ChampViktor);

var Actor m_LastTargetedActor;
var TgPlayerController m_CachedActiveOverlayController;
var float m_fIncomingTime;
var int m_nActiveShotNum;
var float m_fIncomingTimeCurrentShot;
var float m_fRemainingDurationPct;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    m_nActiveShotNum = nAmmoRemaining - 1;
    m_fIncomingTimeCurrentShot = fRefireTime;
    m_fIncomingTime = fRefireTime;
    // End:0x164
    if((((PawnOwner != none) && PawnOwner.Mesh != none) && m_CachedActiveOverlayController != none) && m_CachedActiveOverlayController.GetTgPawn() == PawnOwner)
    {
        PawnOwner.Mesh.FxDeactivateGroup('ViktorBarrageConfirm', 0);
        PawnOwner.Mesh.FxActivateGroup('ViktorBarrageConfirm', 0);
    }
    //return;    
}

simulated event EnterTargetingMode()
{
    m_nActiveShotNum = 3;
    m_fIncomingTimeCurrentShot = 0.0000000;
    m_fRemainingDurationPct = 1.0000000;
    super.EnterTargetingMode();
    m_CachedActiveOverlayController = TgPlayerController(PawnOwner.GetALocalPlayerController());
    // End:0xAF
    if((m_CachedActiveOverlayController != none) && m_CachedActiveOverlayController.GetTgPawn() != PawnOwner)
    {
        m_CachedActiveOverlayController = none;
    }
    //return;    
}

simulated event ExitTargetingMode()
{
    m_fIncomingTimeCurrentShot = 1.0000000;
    super.ExitTargetingMode();
    //return;    
}

// Export UTgDeviceForm_BarrageFire::execUpdateBinocularSettings(FFrame&, void* const)
native function UpdateBinocularSettings();

// Export UTgDeviceForm_BarrageFire::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

defaultproperties
{
    m_fIncomingTime=1.0000000
}