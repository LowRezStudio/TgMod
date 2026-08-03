class TgPawn_VoodooTotem extends TgPawn_Pet
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const MAX_VOODOO_LINKS = 5;

var TgPawn r_linkedEnemies[5];
var int nBreakDist;
var int m_nBeamFXID;
var TgSpecialFx m_BeamFXs[5];
var float fDamageAmount;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_linkedEnemies;
}

// Export UTgPawn_VoodooTotem::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_VoodooTotem::execUpdateLinkedEnemies(FFrame&, void* const)
native function UpdateLinkedEnemies();

// Export UTgPawn_VoodooTotem::execUpdateAllBeams(FFrame&, void* const)
native function UpdateAllBeams();

// Export UTgPawn_VoodooTotem::execPawnOnDamaged(FFrame&, void* const)
native function PawnOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_VoodooTotem::execShouldShowHudOverlay(FFrame&, void* const)
native function bool ShouldShowHudOverlay(TgPawn PlayerPawn);

simulated function ForwardEffects(ImpactInfo Impact, TgEffectGroup EffectGroup, TgDevice SourceDevice, optional bool bRemove, optional int StackCount = 1)
{
    local TgPawn Enemy;
    local int I;
    local TgEffectManager effectManager;
    local Actor EffectInstigator;

    I = 0;
    J0x11:

    // End:0x92 [Loop If]
    if(I < EffectGroup.m_Effects.Length)
    {
        // End:0x84
        if(EffectGroup.m_Effects[I].m_nPropertyId == 51)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x11;
    }
    I = 0;
    J0x9D:

    // End:0x251 [Loop If]
    if(I < 5)
    {
        Enemy = r_linkedEnemies[I];
        Impact.DeviceModeReference = GetDeviceByEqPoint(1).GetCurrentFire();
        // End:0x157
        if(SourceDevice.Instigator != none)
        {
            EffectInstigator = SourceDevice.Instigator;            
        }
        else
        {
            EffectInstigator = SourceDevice;
        }
        effectManager = Enemy.r_EffectManager;
        // End:0x243
        if(effectManager != none)
        {
            // End:0x200
            if(bRemove)
            {
                effectManager.RemoveEffectGroupById(EffectGroup.m_nEffectGroupId, StackCount, EffectInstigator);                
            }
            else
            {
                effectManager.ProcessEffect(EffectGroup, EffectInstigator, StackCount, Impact);
            }
        }
        I++;
        // [Loop Continue]
        goto J0x9D;
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local int I;

    I = 0;
    J0x0C:

    // End:0x9B [Loop If]
    if(I < 5)
    {
        // End:0x4A
        if(r_linkedEnemies[I] != none)
        {
            r_linkedEnemies[I] = none;
        }
        // End:0x8D
        if(m_BeamFXs[I] != none)
        {
            m_BeamFXs[I].Deactivate(true);
        }
        ++I;
        // [Loop Continue]
        goto J0x0C;
    }
    bNetDirty = true;
    //return;    
}

function SetMovementPhysics()
{
    return;
    //return;    
}

event bool CanBePulled()
{
    return false;
    //return ReturnValue;    
}

event bool CanBeGrabbed()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldNudgePlayer(TgPawn PlayerPawn)
{
    return int(GetTaskForceNumber()) != int(PlayerPawn.GetTaskForceNumber());
    //return ReturnValue;    
}

defaultproperties
{
    m_nBeamFXID=7218
    m_bIgnoreEnemyBlocking=true
    m_bPushblockAffectsFriendlies=false
    m_bPushblockAffectsEnemies=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_VoodooTotem.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Pet.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=1024
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_VoodooTotem.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Pet.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_VoodooTotem.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Pet.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_VoodooTotem.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Pet.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_VoodooTotem.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Pet.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_VoodooTotem.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Pet.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_VoodooTotem.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Pet.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    CollisionComponent=CollisionCylinder
}