class TgDeploy_OppressorMine extends TgDeployable
    native(ChampKinessa)
    notplaceable
    hidecategories(Navigation);

const MAX_OPPRESSOR_MINE_TARGETS = 5;

var TgPawn m_CachedPawnOwner;
var TgRepInfo_TaskForce m_CachedEnemyTaskForce;
var repnotify Actor r_CurrentTargets[5];
var int m_nBeamFXID;
var TgSpecialFx m_BeamFXs[5];
var bool m_bNeedsNetDirtyUpdate;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;
var float m_fAmplitudeRadiusScale;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_CartOffset, r_CurrentTargets, 
        r_StuckCart, r_StuckRotation;
}

// Export UTgDeploy_OppressorMine::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor Target);

// Export UTgDeploy_OppressorMine::execFilterCurrentTargets(FFrame&, void* const)
native function int FilterCurrentTargets(int maxTargets);

// Export UTgDeploy_OppressorMine::execFilterNewTargets(FFrame&, void* const)
native function FilterNewTargets(out array<TgPawn> newTargets);

// Export UTgDeploy_OppressorMine::execApplyEffects(FFrame&, void* const)
native function ApplyEffects(Actor Target);

// Export UTgDeploy_OppressorMine::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

// Export UTgDeploy_OppressorMine::execUpdateAllBeams(FFrame&, void* const)
native function UpdateAllBeams();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_CurrentTargets')
    {
        UpdateAllBeams();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local int I;

    I = 0;
    J0x0C:

    // End:0x75 [Loop If]
    if(I < 5)
    {
        // End:0x67
        if(r_CurrentTargets[I] != none)
        {
            RemoveEffects(r_CurrentTargets[I]);
            r_CurrentTargets[I] = none;
        }
        ++I;
        // [Loop Continue]
        goto J0x0C;
    }
    bNetDirty = true;
    super.DestroyIt(bSkipFx);
    // End:0xC4
    if(c_Mesh != none)
    {
        c_Mesh.SetHidden(true);
    }
    // End:0x100
    if((r_StuckCart != none) && int(Role) == int(ROLE_Authority))
    {
        r_StuckCart = none;
        bNetDirty = true;
    }
    //return;    
}

simulated event bool DamageShouldEnterCombat()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_nBeamFXID=6743
    m_bFireOnDeploy=false
    m_bAdjustMeshToGround=false
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_OPPRESSOR_MINE
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_OppressorMine.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=1
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_OppressorMine.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[1]=CollisionCylinder
    bCollideActors=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}