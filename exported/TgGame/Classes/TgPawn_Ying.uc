class TgPawn_Ying extends TgPawn_Character
    native(ChampYing)
    config(Game)
    hidecategories(Navigation);

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var TgPawn_Character m_TeleportTarget;
var bool m_bRetrievedIllusionListThisTick;
var bool m_bHasShatterableIllusionsThisTick;
var bool r_bHasCompensate;
var bool m_bPulledTargetFromList;
var array<TgInterface_YingIllusion> m_ActiveIllusions;
var() float m_fFrictionMultiplier;
var() float m_fGravityMultiplier;
var() float m_fMaxFallSpeed;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_InhandHitOffset, r_InhandTarget, 
        r_bHasCompensate;
}

// Export UTgPawn_Ying::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn_Ying::execPopulateActiveDecoyList(FFrame&, void* const)
native function bool PopulateActiveDecoyList(optional out byte bHasShatterableIllusions);

simulated event KillAllOwnedPets()
{
    super(TgPawn).KillAllOwnedPets();
    ClearDimensionalLink();
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    ClearDimensionalLink();
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

function ClearDimensionalLink()
{
    local int I;
    local TgDevice_DimensionalLink dimensionalLink;

    // End:0x94
    if(int(Role) == int(ROLE_Authority))
    {
        I = 1;
        J0x1F:

        // End:0x94 [Loop If]
        if(I < 33)
        {
            dimensionalLink = TgDevice_DimensionalLink(m_EquippedDevices[I]);
            // End:0x86
            if(dimensionalLink != none)
            {
                dimensionalLink.SetRequiresReset();
                // [Explicit Break]
                goto J0x94;
            }
            I++;
            // [Loop Continue]
            goto J0x1F;
        }
    }
    J0x94:

    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x42
        case 1:
            return "PC_Ying.Anims.AS_PC_Ying_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_fFrictionMultiplier=0.2500000
    m_fGravityMultiplier=0.5000000
    m_fMaxFallSpeed=600.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Ying.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Ying.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Ying"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Ying.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Ying.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Ying.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    Bob=0.0000000
    // Reference: AudioComponent'TgGame.Default__TgPawn_Ying.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Ying.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    AirControl=0.5000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Ying.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Ying.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}