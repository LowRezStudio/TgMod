class TgPawn_Gauntlet extends TgPawn_Character
    native(ChampGauntlet)
    config(Game)
    hidecategories(Navigation);

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var Vector c_InterpInhandHitOffset;
var float c_fInhandHitOffsetInterpSpeed;
var Actor r_RechargeTarget;
var Vector r_RechargeHitOffset;
var Vector c_InterpRechargeHitOffset;
var TgPawn_Character c_ProtectionTarget;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_InhandHitOffset, r_InhandTarget, 
        r_RechargeHitOffset, r_RechargeTarget;
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x57
        case 1:
            return "PC_Gauntlet_Skin00A.Anims.AS_PC_Gauntlet_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0xFA
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x77
        if((r_InhandTarget != none) && r_InhandTarget != r_TargetActor)
        {
            c_InterpInhandHitOffset = r_InhandHitOffset;
        }
        c_InterpInhandHitOffset = VInterpTo(c_InterpInhandHitOffset, r_InhandHitOffset, DeltaSeconds, c_fInhandHitOffsetInterpSpeed);
        c_InterpRechargeHitOffset = VInterpTo(c_InterpRechargeHitOffset, r_RechargeHitOffset, DeltaSeconds, c_fInhandHitOffsetInterpSpeed);
        r_TargetActor = r_InhandTarget;
    }
    //return;    
}

// Export UTgPawn_Gauntlet::execIs1PBodyOverlay(FFrame&, void* const)
native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);

defaultproperties
{
    c_fInhandHitOffsetInterpSpeed=10.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Gauntlet.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Gauntlet.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Torvald"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Gauntlet.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.4000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Gauntlet.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Gauntlet.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Gauntlet.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Gauntlet.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Gauntlet.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Gauntlet.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}