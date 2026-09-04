class TgPawn_Fernando extends TgPawn_Character
    native(ChampFernando)
    config(Game)
    hidecategories(Navigation);

const ACTIVE_SHIELD_MASK = 1;
const TOWERING_BARRIER_MASK = 2;
const GENERAL_DEFENSIVE_MASK = 4;

var repnotify int r_ShieldDisplayType;
var bool c_bShowingShield;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_ShieldDisplayType;
}

// Export UTgPawn_Fernando::execSpecialAOEImmunity(FFrame&, void* const)
native function bool SpecialAOEImmunity(Vector AOECenter, TgDeviceFire instigatingFiremode);

event ShowShield()
{
    local TgDevice ShieldDevice;
    local TgDeploy_ShieldFernando ShieldDeployable;
    local bool bHasToweringBarrier, bHasDefensiveShieldCard;

    // End:0x147
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ShieldDevice = GetDeviceByClass(Class'TgGame.TgDevice_ShieldFernando');
        // End:0x144
        if(ShieldDevice != none)
        {
            ShieldDeployable = TgDeploy_ShieldFernando(ShieldDevice.r_Deployable);
            // End:0x144
            if(ShieldDeployable != none)
            {
                bHasToweringBarrier = ShieldDeployable.r_nToweringBarrierHealth > 0;
                bHasDefensiveShieldCard = ShieldDeployable.r_nAegisBonusHealth > 0;
                r_ShieldDisplayType = 0;
                // End:0x112
                if(bHasDefensiveShieldCard)
                {
                    r_ShieldDisplayType += 4;
                }
                // End:0x12C
                if(bHasToweringBarrier)
                {
                    r_ShieldDisplayType += 2;
                }
                r_ShieldDisplayType += 1;
                bNetDirty = true;
            }
        }        
    }
    else
    {
        // End:0x2A0
        if(int(Role) == int(ROLE_Authority))
        {
            ShieldDevice = GetDeviceByClass(Class'TgGame.TgDevice_ShieldFernando');
            // End:0x2A0
            if(ShieldDevice != none)
            {
                ShieldDeployable = TgDeploy_ShieldFernando(ShieldDevice.r_Deployable);
                // End:0x2A0
                if(ShieldDeployable != none)
                {
                    bHasToweringBarrier = ShieldDeployable.r_nToweringBarrierHealth > 0;
                    bHasDefensiveShieldCard = ShieldDeployable.r_nAegisBonusHealth > 0;
                    r_ShieldDisplayType = 0;
                    // End:0x244
                    if(bHasDefensiveShieldCard)
                    {
                        r_ShieldDisplayType += 4;
                    }
                    // End:0x25E
                    if(bHasToweringBarrier)
                    {
                        r_ShieldDisplayType += 2;
                    }
                    r_ShieldDisplayType += 1;
                    bNetDirty = true;
                    // End:0x296
                    if((r_ShieldDisplayType & 2) > 0)
                    {
                        PlayLargeShieldFX();                        
                    }
                    else
                    {
                        PlayShieldFX();
                    }
                }
            }
        }
    }
    //return;    
}

event HideShield()
{
    // End:0x43
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        r_ShieldDisplayType = 0;
        bNetDirty = true;        
    }
    else
    {
        // End:0x61
        if(int(Role) == int(ROLE_Authority))
        {
            StopShieldFX();
        }
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    super.ReplicatedEvent(VarName);
    switch(VarName)
    {
        // End:0x7E
        case 'r_ShieldDisplayType':
            // End:0x71
            if((r_ShieldDisplayType & 1) > 0)
            {
                // End:0x64
                if((r_ShieldDisplayType & 2) > 0)
                {
                    PlayLargeShieldFX();                    
                }
                else
                {
                    PlayShieldFX();
                }                
            }
            else
            {
                StopShieldFX();
            }
            // End:0x81
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function PlayShieldFX()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x42
    if(c_bShowingShield)
    {
        StopShieldFX();
    }
    // End:0xCC
    if(!c_bShowingShield)
    {
        FxDeactivateGroupSelf('Shield_Despawn', 0);
        FxActivateGroupSelf('Generic2', 0);
        // End:0xC0
        if((r_ShieldDisplayType & 4) > 0)
        {
            FxDeactivateGroupSelf('Generic2', 0);
            FxActivateGroupSelf('FernandoAegis', 0);
        }
        c_bShowingShield = true;
    }
    //return;    
}

simulated function PlayLargeShieldFX()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x42
    if(c_bShowingShield)
    {
        StopShieldFX();
    }
    // End:0xCC
    if(!c_bShowingShield)
    {
        FxDeactivateGroupSelf('Shield_Despawn', 0);
        FxActivateGroupSelf('Generic3', 0);
        // End:0xC0
        if((r_ShieldDisplayType & 4) > 0)
        {
            FxDeactivateGroupSelf('Generic3', 0);
            FxActivateGroupSelf('Generic4', 0);
        }
        c_bShowingShield = true;
    }
    //return;    
}

simulated function StopShieldFX()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0xB4
    if(c_bShowingShield)
    {
        FxActivateGroupSelf('Shield_Despawn', 0);
        FxDeactivateGroupSelf('Generic2', 0);
        FxDeactivateGroupSelf('Generic3', 0);
        FxDeactivateGroupSelf('Generic4', 0);
        FxDeactivateGroupSelf('FernandoAegis', 0);
        c_bShowingShield = false;
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x46
        case 1:
            return "PC_Knight.Anims.AS_PC_Knight_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Fernando.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Fernando.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Fernando"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Fernando.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.2500000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Fernando.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Fernando.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Fernando.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Fernando.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=60.0000000
    EyeHeight=60.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Fernando.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Fernando.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}