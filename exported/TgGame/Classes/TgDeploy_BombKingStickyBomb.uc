class TgDeploy_BombKingStickyBomb extends TgDeployable
    native(ChampBombKing)
    notplaceable
    hidecategories(Navigation);

var bool r_bDetonated;
var bool c_bSuppressExplosion;
var repnotify bool r_bShouldDetach;
var repnotify TgPawn_Character r_StuckPlayer;
var name m_StuckSocket;
var TgPawn_Character m_CachedPlayer;
var repnotify Vector r_HitNormal;
var float m_fCachedCollisionRadius;
var float m_fCachedCollisionHeight;
var TgSpecialFx m_GetStuckFx;
var TgSpecialFx m_StickOtherFx;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;
var TgDeployable r_StuckGeometry;
var repnotify int r_nOriginalProjectileID;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_CartOffset, r_HitNormal, 
        r_StuckCart, r_StuckGeometry, 
        r_StuckPlayer, r_StuckRotation, 
        r_bDetonated, r_bShouldDetach;

    // Pos:0x020
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_nOriginalProjectileID;
}

simulated event ReplicatedEvent(name VarName)
{
    local Vector X, Y, Z, newY, newZ;

    local editinline CylinderComponent Col, otherCol;

    // End:0x31
    if(VarName == 'r_bShouldDetach')
    {
        // End:0x2E
        if(r_bShouldDetach)
        {
            DetachFromPlayer();
        }        
    }
    else
    {
        // End:0x10A
        if(VarName == 'r_HitNormal')
        {
            GetAxes(Rotation, X, Y, Z);
            newZ = r_HitNormal Cross (Z Cross r_HitNormal);
            newZ = Normal(newZ);
            newY = newZ Cross r_HitNormal;
            newY = Normal(newY);
            SetRotation(OrthoRotation(r_HitNormal, newY, newZ));            
        }
        else
        {
            // End:0x29A
            if(VarName == 'r_StuckPlayer')
            {
                Check1PHide();
                // End:0x297
                if(r_StuckPlayer != none)
                {
                    // End:0x283
                    if(CollisionComponent != none)
                    {
                        Col = CylinderComponent(CollisionComponent);
                        otherCol = CylinderComponent(r_StuckPlayer.CollisionComponent);
                        // End:0x261
                        if((Col != none) && otherCol != none)
                        {
                            m_fCachedCollisionRadius = Col.CollisionRadius;
                            m_fCachedCollisionHeight = Col.CollisionHeight;
                            Col.SetCylinderSize(otherCol.CollisionRadius, otherCol.CollisionHeight);
                        }
                        CollisionComponent.SetAbsolute(true, true, true);
                    }
                    StickToPlayerSocket();
                    CheckHideHUDOverlay();
                }                
            }
            else
            {
                // End:0x2C8
                if(VarName == 'r_DRI')
                {
                    CheckHideHUDOverlay();
                    HideSpawningProjectile();                    
                }
                else
                {
                    // End:0x2E9
                    if(VarName == 'r_nOriginalProjectileID')
                    {
                        HideSpawningProjectile();
                    }
                }
            }
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event HideSpawningProjectile()
{
    local TgPawn_BombKing bombKingOwner;

    // End:0x11
    if(r_nOriginalProjectileID <= 0)
    {
        return;
    }
    // End:0x23
    if((GetDeployableUniqueId()) <= 0)
    {
        return;
    }
    bombKingOwner = TgPawn_BombKing(Instigator);
    // End:0x80
    if(bombKingOwner != none)
    {
        bombKingOwner.SpecialHideStickyBomb(r_nOriginalProjectileID, GetDeployableUniqueId());
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local bool allBombsRemoved;
    local Vector vRotation;
    local TgSpecialFx VFX;
    local int I;

    super.DestroyIt(bSkipFx);
    // End:0x181
    if(!c_bSuppressExplosion)
    {
        // End:0x11C
        if(r_bDetonated)
        {
            // End:0x119
            if(m_DestroyedMesh != none)
            {
                vRotation = Normal(Vector(Rotation));
                m_DestroyedMesh.FxActivateIndependant('BombKingStickyExplosion', 0, Location, vRotation);
                VFX = TgSpecialFx(m_DestroyedMesh.FxGet('BombKingStickyExplosion', 0));
                // End:0x119
                if(VFX != none)
                {
                    VFX.SpawnDecalAt(Location, -vRotation);
                }
            }            
        }
        else
        {
            // End:0x181
            if(m_DestroyedMesh != none)
            {
                vRotation = Normal(Vector(Rotation));
                m_DestroyedMesh.FxActivateIndependant('DeployableFizzle', 0, Location, vRotation);
            }
        }
    }
    // End:0x1B0
    if(c_Mesh != none)
    {
        c_Mesh.SetHidden(true);
    }
    // End:0x3CA
    if(r_StuckPlayer != none)
    {
        I = 0;
        J0x1CA:

        // End:0x264 [Loop If]
        if(I < 6)
        {
            // End:0x256
            if(r_StuckPlayer.r_StuckBombs[I] == self)
            {
                r_StuckPlayer.r_StuckBombs[I] = none;
                r_StuckPlayer.bNetDirty = true;
                // [Explicit Break]
                goto J0x264;
            }
            I++;
            // [Loop Continue]
            goto J0x1CA;
        }
        J0x264:

        allBombsRemoved = true;
        I = 0;
        J0x27B:

        // End:0x31B [Loop If]
        if(I < 6)
        {
            // End:0x30D
            if((r_StuckPlayer.r_StuckBombs[I] != none) && !r_StuckPlayer.r_StuckBombs[I].m_bInDestroyedState)
            {
                allBombsRemoved = false;
                // [Explicit Break]
                goto J0x31B;
            }
            I++;
            // [Loop Continue]
            goto J0x27B;
        }
        J0x31B:

        // End:0x39F
        if(allBombsRemoved)
        {
            // End:0x39F
            if((r_Owner != none) && r_Owner.GetCurrentFire() != none)
            {
                r_Owner.GetCurrentFire().RemoveHitSpecial(r_StuckPlayer, true);
            }
        }
        // End:0x3CA
        if(int(Role) == int(ROLE_Authority))
        {
            r_StuckPlayer = none;
            bNetDirty = true;
        }
    }
    // End:0x406
    if((r_StuckCart != none) && int(Role) == int(ROLE_Authority))
    {
        r_StuckCart = none;
        bNetDirty = true;
    }
    // End:0x442
    if((r_StuckGeometry != none) && int(Role) == int(ROLE_Authority))
    {
        r_StuckGeometry = none;
        bNetDirty = true;
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    // End:0x1B
    if(r_StuckPlayer == DamageCauser)
    {
        return;
    }
    // End:0x37
    if(r_StuckPlayer != none)
    {
        DetachFromPlayer();        
    }
    else
    {
        super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    }
    //return;    
}

function DetachTimer()
{
    // End:0x19
    if(r_StuckPlayer != none)
    {
        DetachFromPlayer();
    }
    //return;    
}

simulated event DetachFromPlayer()
{
    local editinline CylinderComponent Col;
    local int I;
    local bool allBombsRemoved;

    // End:0x208
    if(r_StuckPlayer != none)
    {
        I = 0;
        J0x1A:

        // End:0x93 [Loop If]
        if(I < 6)
        {
            // End:0x85
            if(r_StuckPlayer.r_StuckBombs[I] == self)
            {
                r_StuckPlayer.r_StuckBombs[I] = none;
                // [Explicit Break]
                goto J0x93;
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
        J0x93:

        allBombsRemoved = true;
        I = 0;
        J0xAA:

        // End:0x14A [Loop If]
        if(I < 6)
        {
            // End:0x13C
            if((r_StuckPlayer.r_StuckBombs[I] != none) && !r_StuckPlayer.r_StuckBombs[I].m_bInDestroyedState)
            {
                allBombsRemoved = false;
                // [Explicit Break]
                goto J0x14A;
            }
            I++;
            // [Loop Continue]
            goto J0xAA;
        }
        J0x14A:

        // End:0x1CE
        if(allBombsRemoved)
        {
            // End:0x1CE
            if((r_Owner != none) && r_Owner.GetCurrentFire() != none)
            {
                r_Owner.GetCurrentFire().RemoveHitSpecial(r_StuckPlayer, true);
            }
        }
        // End:0x205
        if(int(Role) == int(ROLE_Authority))
        {
            r_StuckPlayer = none;
            r_bShouldDetach = true;
            bNetDirty = true;
        }        
    }
    else
    {
        // End:0x24E
        if(r_StuckGeometry != none)
        {
            // End:0x24E
            if(int(Role) == int(ROLE_Authority))
            {
                r_StuckGeometry = none;
                r_bShouldDetach = true;
                bNetDirty = true;
            }
        }
    }
    SetPhysics(2);
    SetBase(none);
    // End:0x313
    if(CollisionComponent != none)
    {
        Col = CylinderComponent(CollisionComponent);
        // End:0x2C5
        if(Col != none)
        {
            Col.SetCylinderSize(m_fCachedCollisionRadius, m_fCachedCollisionHeight);
        }
        CollisionComponent.SetAbsolute(false, false, false);
        CollisionComponent.SetTranslation(vect(0.0000000, 0.0000000, 0.0000000));
    }
    //return;    
}

simulated event Check1PHide()
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x1A9
    if(r_StuckPlayer != none)
    {
        // End:0x10B
        if(((TgPC != none) && TgPC.GetTgPawn() != none) && TgPC.GetTgPawn() == r_StuckPlayer)
        {
            SetHidden(true);
            // End:0x108
            if(m_GetStuckFx != none)
            {
                m_GetStuckFx.c_Owner = TgPC.GetTgPawn();
                m_GetStuckFx.PlaySound();
            }            
        }
        else
        {
            // End:0x1A6
            if((m_StickOtherFx != none) && Instigator == TgPC.GetTgPawn())
            {
                m_StickOtherFx.c_Owner = TgPC.GetTgPawn();
                m_StickOtherFx.PlaySound();
            }
        }        
    }
    else
    {
        // End:0x219
        if(((TgPC != none) && TgPC.GetTgPawn() != none) && TgPC.GetTgPawn() == m_CachedPlayer)
        {
            SetHidden(false);
        }
    }
    m_CachedPlayer = r_StuckPlayer;
    //return;    
}

simulated event StickToPlayerSocket()
{
    local name SocketName, currentName;
    local Vector SocketLocation, CurrentLocation;
    local array<bool> socketUsed;
    local int I, J, oldestIndex, numBombs;

    // End:0x4DF
    if(r_StuckPlayer != none)
    {
        oldestIndex = -1;
        numBombs = 0;
        I = 0;
        J0x34:

        // End:0x132 [Loop If]
        if(I < 6)
        {
            // End:0x124
            if(r_StuckPlayer.r_StuckBombs[I] != none)
            {
                numBombs++;
                // End:0x124
                if((oldestIndex == -1) || r_StuckPlayer.r_StuckBombs[oldestIndex].m_TimeCreated > r_StuckPlayer.r_StuckBombs[I].m_TimeCreated)
                {
                    oldestIndex = I;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x34;
        }
        // End:0x16C
        if(numBombs == 6)
        {
            r_StuckPlayer.r_StuckBombs[oldestIndex] = none;
        }
        // End:0x4CD
        if(r_StuckPlayer.Mesh != none)
        {
            I = 0;
            J0x19B:

            // End:0x2E6 [Loop If]
            if(I < 6)
            {
                socketUsed[I] = false;
                J = 0;
                J0x1CB:

                // End:0x2D8 [Loop If]
                if(J < 6)
                {
                    // End:0x2CA
                    if(((r_StuckPlayer.r_StuckBombs[J] != none) && !r_StuckPlayer.r_StuckBombs[J].m_bInDestroyedState) && r_StuckPlayer.r_StuckBombs[J].m_StuckSocket == name("CSO_FX_Sticky_0" $ string(I + 1)))
                    {
                        socketUsed[I] = true;
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x1CB;
                }
                I++;
                // [Loop Continue]
                goto J0x19B;
            }
            I = 0;
            J0x2F1:

            // End:0x44E [Loop If]
            if(I < 6)
            {
                currentName = name("CSO_FX_Sticky_0" $ string(I + 1));
                // End:0x440
                if(!socketUsed[I])
                {
                    // End:0x404
                    if(r_StuckPlayer.Mesh.GetSocketWorldLocationAndRotation(currentName, CurrentLocation))
                    {
                        // End:0x401
                        if((SocketName == 'None') || VSizeSq(Location - CurrentLocation) < VSizeSq(Location - SocketLocation))
                        {
                            SocketName = currentName;
                            SocketLocation = CurrentLocation;
                        }                        
                    }
                    else
                    {
                        // End:0x440
                        if(r_StuckPlayer.Mesh.SkeletalMesh != none)
                        {                            
                        }
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x2F1;
            }
            // End:0x4BB
            if(SocketName != 'None')
            {
                SetBase(r_StuckPlayer, vect(0.0000000, 0.0000000, 1.0000000), r_StuckPlayer.Mesh, SocketName);
                m_StuckSocket = SocketName;                
            }
            else
            {
                SetBase(r_StuckPlayer);
            }            
        }
        else
        {
            SetBase(r_StuckPlayer);
        }        
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0x6E
    if(r_StuckPlayer != none)
    {
        // End:0x6E
        if(CollisionComponent != none)
        {
            CollisionComponent.SetTranslation(r_StuckPlayer.Location);
        }
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
    // End:0x163
    if((collisionComp != none) && c_Mesh != none)
    {
        c_Mesh.SetTranslation(vect(-1.0000000, 0.0000000, 0.0000000) * collisionComp.CollisionHeight);
    }
    r_HitNormal = HitNormal;
    r_bShouldDetach = false;
    bNetDirty = true;
    // End:0x1B5
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

function InstantFireDeployable()
{
    // End:0x30
    if(r_StuckPlayer != none)
    {
        SetLocation(r_StuckPlayer.Location);
    }
    super.InstantFireDeployable();
    //return;    
}

simulated function CheckHideHUDOverlay()
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x8D
    if(((TgPC != none) && TgPC.GetTgPawn() != none) && TgPC.GetTgPawn() == r_StuckPlayer)
    {
        SetHUDOverlayDisplayMask(0);
    }
    //return;    
}

defaultproperties
{
    m_bFireOnDeploy=false
    m_bAdjustMeshToGround=false
    m_bDeviceUsedIsHandDevice=true
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_STICKY_BOMB
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_BombKingStickyBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=4
    m_InitHUDOverlayEnemyViewDist=800.0000000
    m_GameplayCurves=TgGameplayCurves'GP_BombKing.DeviceStickyBomb'
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_BombKingStickyBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[1]=CollisionCylinder
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgDeploy_BombKingStickyBomb.PositionHistoryComponent'
    begin object name="PositionHistoryComponent" class=PlatformCommon.PComPositionHistoryComponent
    end object
    Components[2]=PositionHistoryComponent
    bHardAttach=true
    bIgnoreBaseRotation=false
    bCollideActors=true
    bCollideWorld=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}