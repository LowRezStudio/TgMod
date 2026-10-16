class TgProj_GrumpyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation);

var export editinline TgSilhouetteComponent m_Silhouette;
var bool m_bSilhouetteInitialized;
var bool m_bSilhouetteAllowed;
var float m_fPostLandDurationAccelerant;

// Export UTgProj_GrumpyBomb::execInitializeSilhouetteComponent(FFrame&, void* const)
native function InitializeSilhouetteComponent();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_Owner')
    {
        CheckShowOutline();
    }
    super(TgProjectile).ReplicatedEvent(VarName);
    //return;    
}

simulated function CheckShowOutline()
{
    local TgPlayerController TgPC;

    // End:0xD7
    if((m_Silhouette != none) && r_Owner != none)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0xD7
        if(((TgPC != none) && TgPC.GetTgPawn() != none) && TgPC.GetTgPawn() == r_Owner.Owner)
        {
            m_Silhouette.SetEnabled(true);
        }
    }
    //return;    
}

// Export UTgProj_GrumpyBomb::execIsAccelerantEquipped(FFrame&, void* const)
native function bool IsAccelerantEquipped();

function float GetPostLandDuration()
{
    // End:0x1A
    if(IsAccelerantEquipped())
    {
        return m_fPostLandDurationAccelerant;        
    }
    else
    {
        return super.GetPostLandDuration();
    }
    //return ReturnValue;    
}

function StartLandExplodeTimer()
{
    super.StartLandExplodeTimer();
    // End:0x83
    if(c_Mesh != none)
    {
        // End:0x56
        if(IsAccelerantEquipped())
        {
            c_Mesh.FxActivateGroup('GrumpyBombLandAlt', 0);            
        }
        else
        {
            c_Mesh.FxActivateGroup('GrumpyBombLand', 0);
        }
    }
    //return;    
}

simulated event bool CheckTeamPassThrough(Actor Other)
{
    local TgDeployable deployTarget;

    deployTarget = TgDeployable(Other);
    // End:0x6B
    if((deployTarget != none) && int(deployTarget.m_CollisionSettings.mCollisionMode) == int(1))
    {
        return true;
    }
    return super(TgProjectile).CheckTeamPassThrough(Other);
    //return ReturnValue;    
}

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn pawnOther;
    local editinline MeshComponent ComponentIt;

    super(TgProjectile).ProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x11A
    if((((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !m_bHasExploded) && Other != none) && c_Mesh != none)
    {
        pawnOther = TgPawn(Other);
        // End:0x11A
        if((pawnOther != none) && pawnOther.IsLocallyControlled())
        {
            // End:0x119
            foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
            {
                ComponentIt.SetHidden(true);                
            }            
        }
    }
    //return;    
}

simulated event ProxyUnTouch(Actor Other)
{
    local TgPawn pawnOther;
    local editinline MeshComponent ComponentIt;

    super(TgProjectile).ProxyUnTouch(Other);
    // End:0xFF
    if((((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !m_bHasExploded) && Other != none) && c_Mesh != none)
    {
        pawnOther = TgPawn(Other);
        // End:0xFF
        if((pawnOther != none) && pawnOther.IsLocallyControlled())
        {
            // End:0xFE
            foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
            {
                ComponentIt.SetHidden(false);                
            }            
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgSilhouetteComponentPaladins'TgGame.Default__TgProj_GrumpyBomb.MySilhouette'
    begin object name="MySilhouette" class=TgGame.TgSilhouetteComponentPaladins
    end object
    m_Silhouette=MySilhouette
    m_fPostLandDurationAccelerant=1.5000000
    m_bExplodeOnTouch=false
    m_bUseGravityZOverride=true
    m_fSpeedToActivateBounceFX=100.0000000
    m_fGravityZOverride=-650.0000000
    m_bTrackProjectileForTimelapse=true
    m_nShadowFXID=7255
    m_fMaxDecalHeight=2000.0000000
    m_fTrackingUpdateRate=0.2000000
    m_fPostLandDuration=3.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_GrumpyBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_GrumpyBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Components[2]=MySilhouette
    CollisionComponent=CollisionCylinder
}