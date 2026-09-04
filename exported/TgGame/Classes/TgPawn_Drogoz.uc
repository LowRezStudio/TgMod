class TgPawn_Drogoz extends TgPawn_Character
    native(ChampDrogoz)
    config(Game)
    hidecategories(Navigation);

var bool m_bIsInBooster;
var bool m_bThrusterIsBlocking;
var bool m_bDragonSlamIsBlocking;
var bool m_bDragonSlamHasHit;
var bool m_bUseDragonSlamRetrieve;
var bool m_bInBoosterLockout;
var bool r_bSalvoActiveFlag;
var bool r_bCombustibleActive;
var(DrogozBooster) bool m_bBoosterUseConstantSpeedReduction;
var float m_fBoosterEndTime;
var TgDevice m_CachedBoosterDevice;
var float m_fBoosterLockoutTime;
var float m_fBoosterKnockbackLockoutTime;
var float m_fBoosterKnockbackLockoutTimestamp;
var int r_nInhandAmmoRemaining;
var(DrogozBooster) float m_fBoosterSpeedReductionRate;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bCombustibleActive, r_bSalvoActiveFlag, 
        r_nInhandAmmoRemaining;
}

// Export UTgPawn_Drogoz::execDeviceOnStartBuildup(FFrame&, void* const)
native function DeviceOnStartBuildup(TgDevice Dev);

// Export UTgPawn_Drogoz::execShouldBeFirstPersonThisTick(FFrame&, void* const)
native function bool ShouldBeFirstPersonThisTick();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_bIsKnockedBack')
    {
        StartKnockbackLockout();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

event Knock(bool bKnocked, optional float fKnockbackFrictionOverride = -1.0000000, optional Vector vKnockbackVelocityOverride = vect(0.0000000, 0.0000000, 0.0000000))
{
    super(TgPawn).Knock(bKnocked, fKnockbackFrictionOverride, vKnockbackVelocityOverride);
    // End:0x57
    if(bKnocked)
    {
        StartKnockbackLockout();
    }
    //return;    
}

simulated function StartKnockbackLockout()
{
    m_fBoosterKnockbackLockoutTimestamp = WorldInfo.TimeSeconds + m_fBoosterKnockbackLockoutTime;
    //return;    
}

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote)
{
    switch(Emote)
    {
        // End:0x1D
        case 13:
            return false;
            // End:0x23
            break;
        // End:0xFFFF
        default:
            // End:0x23
            break;
            break;
    }
    return super(TgPawn).RespectsEmoteGlobalCooldown(Emote);
    //return ReturnValue;    
}

simulated event bool CanFlyWithoutHover()
{
    return m_bIsInBooster;
    //return ReturnValue;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x46
        case 1:
            return "PC_Drogoz.Anims.AS_PC_Drogoz_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function OnStartTimelapseNewDeviceState()
{
    local int I;

    super.OnStartTimelapseNewDeviceState();
    I = 1;
    J0x15:

    // End:0xD0 [Loop If]
    if(I < 33)
    {
        // End:0xC2
        if(c_EquipForm[I] != none)
        {
            // End:0xC2
            if(c_EquipForm[I].IsA('TgDeviceForm_DragonSlam'))
            {
                // End:0x98
                if(int(r_ReplicatedDeviceState[I]) == int(1))
                {
                    m_bUseDragonSlamRetrieve = true;                    
                }
                else
                {
                    // End:0xC2
                    if(int(r_ReplicatedDeviceState[I]) == int(0))
                    {
                        m_bUseDragonSlamRetrieve = false;
                    }
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    //return;    
}

defaultproperties
{
    m_fBoosterEndTime=0.5000000
    m_fBoosterLockoutTime=0.5000000
    m_fBoosterKnockbackLockoutTime=1.0000000
    m_fBoosterSpeedReductionRate=1.0000000
    m_fMountZoomOverride=1.1000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Drogoz.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Drogoz.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bEndChargeInFalling=true
    m_bAirAccuracyPenalty=false
    m_sGameplayPackage="Drogoz"
    m_EmoteChancesAbility=(fAbility1=1.0000000,fAbility2=-1.0000000)
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Drogoz.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Drogoz.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Drogoz.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Drogoz.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Drogoz.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fMountScaleOverride=0.9000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Drogoz.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Drogoz.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}