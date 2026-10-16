class TgDeviceForm_Telepunch extends TgDeviceForm
    native(ChampDemon);

var bool m_bFOVZoomActive;
var bool m_bUltFxActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVMultiplier;

event Generic1(optional byte byExtraData)
{
    TriggerFOVZoom(((int(byExtraData) == int(1)) ? true : false));
    super.Generic1(byExtraData);
    //return;    
}

event Generic2(optional byte byExtraData)
{
    EnableUltFx(((int(byExtraData) == int(1)) ? true : false));
    Generic1(byExtraData);
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    SetEnemyUIOverrides(true);
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    TriggerFOVZoom(false);
    SetEnemyUIOverrides(false);
    EnableUltFx(false);
    super.StopFire(nFireModeNum);
    //return;    
}

event DoInterrupt()
{
    TriggerFOVZoom(false);
    SetEnemyUIOverrides(false);
    EnableUltFx(false);
    super.DoInterrupt();
    //return;    
}

simulated function TriggerFOVZoom(bool bActive)
{
    local TgPawn_Character TgP;
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;

    // End:0x198
    if(m_bFOVZoomActive != bActive)
    {
        m_bFOVZoomActive = bActive;
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
                    if(m_bFOVZoomActive)
                    {
                        Cam.InterpolateFOV(Cam.GetFOVAngle() * m_fFOVMultiplier, m_fCameraFOVInterpolationTime);                        
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

simulated function EnableUltFx(bool bActive)
{
    local TgPawn_Character TgP;
    local TgPlayerController TgPC;

    // End:0x2D0
    if(m_bUltFxActive != bActive)
    {
        m_bUltFxActive = bActive;
        TgP = TgPawn_Character(PawnOwner);
        // End:0x2D0
        if(TgP != none)
        {
            TgPC = TgPlayerController(TgP.GetALocalPlayerController());
            // End:0x2D0
            if((TgPC != none) && TgPC.GetTgPawn() == TgP)
            {
                // End:0x2D0
                if((TgP.m_WeaponMesh != none) && TgP.m_WeaponMesh.m_WeaponMesh1P != none)
                {
                    // End:0x19F
                    if(m_bUltFxActive)
                    {
                        TgP.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic1', c_nFireMode,, c_nEquipSlot);                        
                    }
                    else
                    {
                        TgP.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic1', c_nFireMode,, c_nEquipSlot);
                        TgP.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic2', c_nFireMode,, c_nEquipSlot);
                        TgP.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic2', c_nFireMode,, c_nEquipSlot);
                    }
                }
            }
        }
    }
    //return;    
}

simulated function SetEnemyUIOverrides(bool bActive)
{
    local TgPawn_Character TgP;
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce EnemyTaskforce;
    local array<TgRepInfo_Player> Players;
    local TgRepInfo_Player EnemyPRI;

    TgP = TgPawn_Character(PawnOwner);
    // End:0x294
    if(TgP != none)
    {
        TgPC = TgPlayerController(TgP.GetALocalPlayerController());
        // End:0x294
        if((TgPC != none) && TgPC.GetTgPawn() == TgP)
        {
            GRI = TgRepInfo_Game(PawnOwner.WorldInfo.GRI);
            // End:0x294
            if(GRI != none)
            {
                EnemyTaskforce = GRI.GetTaskForce(((int(TgP.GetTaskForceNumber()) == int(1)) ? 2 : 1));
                // End:0x294
                if(EnemyTaskforce != none)
                {
                    EnemyTaskforce.GetPlayers(Players);
                    // End:0x293
                    foreach Players(EnemyPRI)
                    {
                        // End:0x22D
                        if(bActive)
                        {
                            EnemyPRI.c_nDeployableOverlayDisplayMaskOverride = ((((4 | 32) | 256) | 16384) | 32768) | 65536;
                            EnemyPRI.c_eDeployableOverlayStateOverride = 1;
                            EnemyPRI.c_fDeployableOverlayEnemyViewDistOverride = 5000.0000000;                            
                        }
                        else
                        {
                            EnemyPRI.c_nDeployableOverlayDisplayMaskOverride = 0;
                            EnemyPRI.c_eDeployableOverlayStateOverride = 0;
                            EnemyPRI.c_fDeployableOverlayEnemyViewDistOverride = 0.0000000;
                        }                        
                    }                    
                }
            }
        }
    }
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    // End:0x1F
    if(int(DesiredState) == int(1))
    {
        SetEnemyUIOverrides(true);
    }
    super.RecoverDeviceState(DesiredState);
    //return;    
}

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.3300000
    m_fFOVMultiplier=0.5000000
}