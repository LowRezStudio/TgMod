class TgPawn_Lazarus extends TgPawn_Character
    native(ChampLazarus)
    config(Game)
    hidecategories(Navigation);

var TgDevice_SelfResurrection m_SelfResurrectionDevice;
var TgDevice_AbsorptionField m_AbsorptionFieldDevice;
var TgDevice_ChargeBurst m_ChargeBurstDevice;
var Controller m_Killer;
var repnotify bool r_bShouldRez;
var bool m_bHasAppliedUltimate;
var repnotify float r_fEnergy;
var repnotify float r_fAccumulatedDamage;
var int m_nChargeNumber;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bShouldRez, r_fAccumulatedDamage, 
        r_fEnergy;
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_fAccumulatedDamage':
            UpdateChargeNumber();
            // End:0x42
            break;
        // End:0xFFFF
        default:
            super.ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

// Export UTgPawn_Lazarus::execPawnOnDamaged(FFrame&, void* const)
native function PawnOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_Lazarus::execHasCachedResurrectionDevice(FFrame&, void* const)
native function bool HasCachedResurrectionDevice();

// Export UTgPawn_Lazarus::execHasCachedAbsorptionDevice(FFrame&, void* const)
native function bool HasCachedAbsorptionDevice();

// Export UTgPawn_Lazarus::execHasCachedChargeBurstDevice(FFrame&, void* const)
native function bool HasCachedChargeBurstDevice();

// Export UTgPawn_Lazarus::execShouldBeFirstPersonThisTick(FFrame&, void* const)
native function bool ShouldBeFirstPersonThisTick();

// Export UTgPawn_Lazarus::execIncrementDamageCharge(FFrame&, void* const)
native function IncrementDamageCharge(float pDamageAmt);

// Export UTgPawn_Lazarus::execUpdateChargeNumber(FFrame&, void* const)
native function UpdateChargeNumber();

// Export UTgPawn_Lazarus::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

// Export UTgPawn_Lazarus::execOnDismount(FFrame&, void* const)
native function OnDismount();

event bool ShouldScoreKill()
{
    // End:0x45
    if(r_bShouldRez)
    {
        // End:0x45
        if(HasCachedResurrectionDevice())
        {
            // End:0x45
            if(int(m_SelfResurrectionDevice.r_mCurrentState) == int(1))
            {
                return false;
            }
        }
    }
    return true;
    //return ReturnValue;    
}

simulated event FakeDeath(Controller Killer)
{
    local TgPawn_Character TgPCharacter;

    PlayDyingEffects();
    // End:0x102
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xBC
        if(r_nPhysicalType == 10034)
        {
            // End:0xBB
            foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', TgPCharacter)
            {
                // End:0xBA
                if((TgPCharacter != none) && TgPCharacter.IsAliveAndWell())
                {
                    TgPCharacter.GlobalOnPlayerDied(self);
                }                
            }            
        }
        WorldInfo.Game.ScoreKill(Killer, Controller);
    }
    //return;    
}

defaultproperties
{
    m_nChargeNumber=1
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Lazarus.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Lazarus.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Lazarus.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Lazarus.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Lazarus.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Lazarus.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Lazarus.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Lazarus.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Lazarus.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}