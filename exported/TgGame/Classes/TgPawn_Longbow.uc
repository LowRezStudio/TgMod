class TgPawn_Longbow extends TgPawn_Character
    native(ChampLongbow)
    config(Game)
    hidecategories(Navigation);

var TgDevice_LongbowInhand m_CachedInhand;
var repnotify bool r_bImpalerArrowIsActive;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bImpalerArrowIsActive;
}

// Export UTgPawn_Longbow::execUpdateStealthScarfMaterial(FFrame&, void* const)
native function UpdateStealthScarfMaterial();

// Export UTgPawn_Longbow::execHasCachedInhandDevice(FFrame&, void* const)
native function bool HasCachedInhandDevice();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x5F
    if(VarName == 'r_bImpalerArrowIsActive')
    {
        // End:0x5C
        if(int(Role) != int(ROLE_AutonomousProxy))
        {
            // End:0x5C
            if(HasCachedInhandDevice())
            {
                m_CachedInhand.m_fImpalerReticleAnimationTimer = 1.0000000;
            }
        }        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function ToggleImpalerArrow(bool bEnabled)
{
    r_bImpalerArrowIsActive = bEnabled;
    bNetDirty = true;
    // End:0x52
    if(HasCachedInhandDevice())
    {
        m_CachedInhand.m_fImpalerReticleAnimationTimer = 1.0000000;
    }
    //return;    
}

simulated event ApplyStealthClient(optional bool bForce = false)
{
    // End:0x2A
    if(int(c_eIsStealthed) != int(r_eIsStealthed))
    {
        UpdateStealthScarfMaterial();
    }
    super(TgPawn).ApplyStealthClient(bForce);
    //return;    
}

simulated event KillAllOwnedPets()
{
    super(TgPawn).KillAllOwnedPets();
    ClearImpalerArrow();
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    ClearImpalerArrow();
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

simulated function ClearImpalerArrow()
{
    ToggleImpalerArrow(false);
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x55
        case 1:
            return "PC_LongBow_Skin00A.Anims.AS_PC_LongBow_Skin00A_Mount_Horse";
        // End:0x8E
        case 2:
            return "MT_Horse_Test.Anims.AS_PC_ShaLin_Test_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote)
{
    // End:0x16
    if(int(Emote) == int(14))
    {
        return false;
    }
    return super(TgPawn).RespectsEmoteGlobalCooldown(Emote);
    //return ReturnValue;    
}

simulated event float GetEmoteInternalCooldown(TgPawn.EEmote Emote)
{
    // End:0x1A
    if(int(Emote) == int(14))
    {
        return 1.0000000;
    }
    return super(TgPawn).GetEmoteInternalCooldown(Emote);
    //return ReturnValue;    
}

simulated event bool CanEmoteDuringTimelapse(TgPawn.EEmote Emote)
{
    // End:0x16
    if(int(Emote) == int(14))
    {
        return true;
    }
    return super(TgPawn).CanEmoteDuringTimelapse(Emote);
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Longbow.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Longbow.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="ShaLin"
    m_EmoteChancesAbility=(fAbility2=1.0000000)
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Longbow.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Longbow.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Longbow.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Longbow.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Longbow.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Longbow.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Longbow.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}