class TgPawn_TowerBase extends TgPawn_Structure
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

struct native NavMeshBorderEdges
{
    var Vector P1;
    var Vector P2;

    structdefaultproperties
    {
        P1=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        P2=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var init array<init NavMeshBorderEdges> BorderEdges;
var transient TgSpecialFx c_BeamFX;
var export editinline TgMarkComponent s_DamageScaler;
var int m_nNumGuardianLevels;
var bool r_bLocked;
var protected transient bool m_bShouldBeFaded;
var float m_fTransparentFadeSpeed;
var float m_fMaxFadeTransparency;
var float m_fFadeDistance2D;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bLocked;
}

// Export UTgPawn_TowerBase::execSetTargetActor(FFrame&, void* const)
native function SetTargetActor(Actor Target);

// Export UTgPawn_TowerBase::execSendTargetedAlert(FFrame&, void* const)
native function SendTargetedAlert(TgPawn Target);

// Export UTgPawn_TowerBase::execDeviceOnDamaged(FFrame&, void* const)
native function DeviceOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_TowerBase::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_TowerBase::execPawnOnDamageMitigation(FFrame&, void* const)
native function PawnOnDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

// Export UTgPawn_TowerBase::execCalcDistanceFadeValue(FFrame&, void* const)
native function CalcDistanceFadeValue(float fDeltaTime);

// Export UTgPawn_TowerBase::execSetTransparencyFaded(FFrame&, void* const)
native function SetTransparencyFaded(bool bShouldBeFaded);

// Export UTgPawn_TowerBase::execQueryBorderEdges(FFrame&, void* const)
native function QueryBorderEdges(Vector BoundsExtent, optional bool bUseObb = false);

// Export UTgPawn_TowerBase::execGetPositionOnBorderEdge(FFrame&, void* const)
native function Vector GetPositionOnBorderEdge(const Vector FromPosition);

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TaskForceInfo;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xDE
    if(GRI != none)
    {
        // End:0x83
        if(int(GetTaskForceNumber()) == int(2))
        {
            TaskForceInfo = GRI.GetTaskForce(1, false);            
        }
        else
        {
            TaskForceInfo = GRI.GetTaskForce(2, false);
        }
        // End:0xDE
        if(TaskForceInfo != none)
        {
            TaskForceInfo.m_nTowersKilled++;
        }
    }
    return super.Died(Killer, dmgType, HitLocation);
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_TowerBase.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    begin object name="TowerDamageScaler" class=TgGame.TgMarkComponent
        m_bStackEffects=true
        m_fMarkDuration=3.0000000
        m_nMaxMarks=99
    end object
    s_DamageScaler=TowerDamageScaler
    m_fTransparentFadeSpeed=10.0000000
    m_fMaxFadeTransparency=0.8000000
    m_fFadeDistance2D=700.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_TowerBase.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Structure.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_TowerBase.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Structure.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_TowerBase.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Structure.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_TowerBase.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Structure.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_TowerBase.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Structure.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_TowerBase.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Structure.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_TowerBase.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Structure.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    bUpdateHavokPos=false
    CollisionComponent=CollisionCylinder
}