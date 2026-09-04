class TgDeploy_PoppyBomb extends TgDeployable
    native(ChampBombKing)
    notplaceable
    hidecategories(Navigation);

var bool r_bDetonated;
var TgPawn_Character m_CachedPlayer;
var repnotify Vector r_HitNormal;
var float m_fCachedCollisionRadius;
var float m_fCachedCollisionHeight;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_CartOffset, r_HitNormal, 
        r_StuckCart, r_StuckRotation, 
        r_bDetonated;
}

simulated event ReplicatedEvent(name VarName)
{
    local Vector X, Y, Z, newY, newZ;

    // End:0xE3
    if(VarName == 'r_HitNormal')
    {
        GetAxes(Rotation, X, Y, Z);
        newZ = r_HitNormal Cross (Z Cross r_HitNormal);
        newZ = Normal(newZ);
        newY = newZ Cross r_HitNormal;
        newY = Normal(newY);
        self.SetRotation(OrthoRotation(r_HitNormal, newY, newZ));
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local Vector vRotation;
    local TgSpecialFx VFX;
    local TgPlayerController TgPC;
    local TgPawn OwningPawn;
    local TgDevice PoppyBombDevice;

    super.DestroyIt(bSkipFx);
    // End:0x10D
    if(r_bDetonated)
    {
        // End:0x10A
        if(m_DestroyedMesh != none)
        {
            vRotation = Normal(Vector(Rotation));
            m_DestroyedMesh.FxActivateIndependant('BombKingStickyExplosion', 0, Location, vRotation);
            VFX = TgSpecialFx(m_DestroyedMesh.FxGet('BombKingStickyExplosion', 0));
            // End:0x10A
            if(VFX != none)
            {
                VFX.SpawnDecalAt(Location, -vRotation);
            }
        }        
    }
    else
    {
        // End:0x172
        if(m_DestroyedMesh != none)
        {
            vRotation = Normal(Vector(Rotation));
            m_DestroyedMesh.FxActivateIndependant('DeployableFizzle', 0, Location, vRotation);
        }
    }
    // End:0x1A1
    if(c_Mesh != none)
    {
        c_Mesh.SetHidden(true);
    }
    // End:0x2AB
    if((int(WorldInfo.NetMode) == int(NM_Standalone)) || int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        OwningPawn = TgPawn(Instigator);
        // End:0x2A8
        if(OwningPawn != none)
        {
            PoppyBombDevice = OwningPawn.GetDeviceByClass(Class'TgGame.TgDevice_PoppyBomb');
            // End:0x2A8
            if((PoppyBombDevice != none) && !PoppyBombDevice.IsDeviceCoolingDown())
            {
                PoppyBombDevice.StartCooldown();
            }
        }        
    }
    else
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x3B6
        if(TgPC != none)
        {
            // End:0x3B6
            if(TgPC.Pawn == Instigator)
            {
                OwningPawn = TgPawn(Instigator);
                // End:0x3B6
                if(OwningPawn != none)
                {
                    PoppyBombDevice = OwningPawn.GetDeviceByClass(Class'TgGame.TgDevice_PoppyBomb');
                    // End:0x3B6
                    if((PoppyBombDevice != none) && !PoppyBombDevice.IsDeviceCoolingDown())
                    {
                        PoppyBombDevice.StartCooldown();
                    }
                }
            }
        }
    }
    // End:0x3F2
    if((r_StuckCart != none) && int(Role) == int(ROLE_Authority))
    {
        r_StuckCart = none;
        bNetDirty = true;
    }
    //return;    
}

event Landed(Vector HitNormal, Actor FloorActor)
{
    local Vector X, Y, Z, newY, newZ;

    local editinline CylinderComponent collisionComp;

    super(Actor).Landed(HitNormal, FloorActor);
    GetAxes(Rotation, X, Y, Z);
    newZ = HitNormal Cross (Z Cross HitNormal);
    newZ = Normal(newZ);
    newY = newZ Cross HitNormal;
    newY = Normal(newY);
    SetRotation(OrthoRotation(HitNormal, newY, newZ));
    collisionComp = CylinderComponent(CollisionComponent);
    // End:0x170
    if((collisionComp != none) && self.c_Mesh != none)
    {
        c_Mesh.SetTranslation(vect(-1.0000000, 0.0000000, 0.0000000) * collisionComp.CollisionHeight);
    }
    r_HitNormal = HitNormal;
    bNetDirty = true;
    // End:0x1B6
    if(TgPawn_LanePusher(FloorActor) != none)
    {
        SetBase(FloorActor);
    }
    //return;    
}

event ExplodeOnShield()
{
    InstantFireDeployable();
    r_bDetonated = true;
    bNetDirty = true;
    DestroyIt();
    //return;    
}

defaultproperties
{
    m_bFireOnDeploy=false
    m_bAdjustMeshToGround=false
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_POPPY_BOMB
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_PoppyBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=1
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_PoppyBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[1]=CollisionCylinder
    bIgnoreBaseRotation=false
    bCollideActors=true
    bCollideWorld=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}