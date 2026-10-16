class TgPawn_Juggernaut extends TgPawn_LanePusher
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var bool m_bNextLaserLeft;
var bool m_bInGenericFirePosture;

// Export UTgPawn_Juggernaut::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_Juggernaut::execIsDebuffImmune(FFrame&, void* const)
native function bool IsDebuffImmune();

// Export UTgPawn_Juggernaut::execPawnOnPreDamageMitigation(FFrame&, void* const)
native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

simulated event bool PostPawnSetup()
{
    // End:0x19
    if(super(TgPawn).PostPawnSetup())
    {
        ChangeFirePosture();
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event ChangeFirePosture()
{
    // End:0x77
    if(Mesh != none)
    {
        // End:0x4C
        if(m_bInGenericFirePosture)
        {
            Mesh.FxActivateGroup('Generic1', 1);            
        }
        else
        {
            Mesh.FxDeactivateGroup('Generic1', 0);
        }
    }
    //return;    
}

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining)
{
    // End:0x24
    if(m_bInGenericFirePosture)
    {
        m_bInGenericFirePosture = false;
        ChangeFirePosture();
    }
    super.OnDeviceFormStartFire(nEquipSlot, FireDuration, nFireMode, nAmmoRemaining);
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local bool bDied;
    local TgPawn KillerPawn;

    bDied = super.Died(Killer, dmgType, HitLocation);
    // End:0xA1
    if(Killer != none)
    {
        KillerPawn = TgPawn(Killer.Pawn);
        // End:0xA1
        if(KillerPawn != none)
        {
            KillerPawn.PlayEmoteAtWorldLocation(21);
        }
    }
    return bDied;
    //return ReturnValue;    
}

defaultproperties
{
    m_bInGenericFirePosture=true
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_Juggernaut.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    // Archetype: StaticMeshComponent'TgGame.Default__TgPawn_LanePusher.CollisionBox'
    begin object name="CollisionBox"
        ReplacementPrimitive=none
    end object
    m_CollisionBox=CollisionBox
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Juggernaut.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusher.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Juggernaut.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusher.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Juggernaut.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_LanePusher.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Juggernaut.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusher.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Juggernaut.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_LanePusher.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Juggernaut.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_LanePusher.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Juggernaut.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusher.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    bAlwaysRelevant=true
    CollisionComponent=CollisionBox
}