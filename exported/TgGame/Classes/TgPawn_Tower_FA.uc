class TgPawn_Tower_FA extends TgPawn_Tower
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

enum ETowerType
{
    TowerType_Default,              // 0
    TowerType_Inner,                // 1
    TowerType_Outer,                // 2
    TowerType_Upper,                // 3
    TowerType_MAX                   // 4
};

var TgPawn_Tower_FA.ETowerType m_TowerType;
var repnotify Rotator r_InitialOrientation;
var export editinline ParticleSystemComponent c_AimVisibilityMesh;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_InitialOrientation;
}

// Export UTgPawn_Tower_FA::execCanSeeActor(FFrame&, void* const)
native function bool CanSeeActor(Actor Other);

simulated function SetAimVisibilityMesh()
{
    local Vector translationOffset;
    local bool bIsFriendly;
    local ParticleChannelContainer PSysChannels;

    bIsFriendly = IsFriendlyWithLocalPawn();
    translationOffset = vect(0.0000000, 0.0000000, 0.0000000);
    translationOffset.Z -= (GetCollisionHeight());
    PSysChannels.Friendly = bIsFriendly;
    PSysChannels.Enemy = !PSysChannels.Friendly;
    // End:0x182
    if(c_AimVisibilityMesh != none)
    {
        c_AimVisibilityMesh.m_ParticleChannels = PSysChannels;
        c_AimVisibilityMesh.ActivateSystem();
        c_AimVisibilityMesh.SetAbsolute(false, true, false);
        c_AimVisibilityMesh.SetRotation(r_InitialOrientation);
        c_AimVisibilityMesh.SetTranslation(translationOffset);
    }
    //return;    
}

simulated function PlayDyingEffects()
{
    super(TgPawn).PlayDyingEffects();
    // End:0x35
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x63
    if(c_AimVisibilityMesh != none)
    {
        c_AimVisibilityMesh.DeactivateSystem();
    }
    //return;    
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    r_InitialOrientation = Rotation;
    // End:0x66
    if((int(Role) == int(ROLE_Authority)) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        SetAimVisibilityMesh();
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_InitialOrientation':
            SetAimVisibilityMesh();
            // End:0x2F
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event Vector GetWeaponStartTraceLocation(TgDevice Dev)
{
    local Vector StartLocation;

    // End:0x51
    if((Mesh != none) && Mesh.GetSocketWorldLocationAndRotation('WSO_Emit_01', StartLocation))
    {
        return StartLocation;
    }
    return super(TgPawn).GetWeaponStartTraceLocation(Dev);
    //return ReturnValue;    
}

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode)
{
    local GameSkelCtrl_Recoil FireRecoilNode;

    // End:0x7A
    if(Mesh != none)
    {
        FireRecoilNode = GameSkelCtrl_Recoil(Mesh.FindSkelControl('FireRecoil'));
        // End:0x7A
        if(FireRecoilNode != none)
        {
            FireRecoilNode.bPlayRecoil = true;
        }
    }
    super(TgPawn).OnDeviceFormFire(nEquipSlot, fRefireTime, nFireMode);
    //return;    
}

defaultproperties
{
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_Tower_FA.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    // Archetype: TgMarkComponent'TgGame.Default__TgPawn_Tower.TowerDamageScaler'
    begin object name="TowerDamageScaler"
    end object
    s_DamageScaler=TowerDamageScaler
    m_bIsInvisibleToAI=true
    c_bUpdateSkelMeshWhenNotRendered=true
    c_bUpdateSkelMeshWhenNotRenderedServer=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Tower_FA.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Tower.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Tower_FA.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Tower.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Tower_FA.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Tower.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Tower_FA.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Tower.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Tower_FA.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Tower.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=0.0000000
    EyeHeight=0.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Tower_FA.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Tower.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
        BlockNonZeroExtent=true
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Tower_FA.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Tower.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    CollisionComponent=CollisionCylinder
}