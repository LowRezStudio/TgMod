class TgProj_BombKingStickyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation);

var bool m_bExplodedOnShield;
var bool m_bExplodedOnDeployGeomtry;
var bool c_bReadyToHide;
var Actor m_CachedHitTarget;
var Vector m_vCachedHitLocation;
var Vector m_vCachedHitNormal;

// Export UTgProj_BombKingStickyBomb::execSpawnDeployable(FFrame&, void* const)
native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo)
{
    return Target;
    //return ReturnValue;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TgPawn_Character ExplodedCharacter;
    local TgDeployable deployable;

    // End:0x1AD
    if(Target != none)
    {
        ExplodedCharacter = TgPawn_Character(Target);
        // End:0xDC
        if(ExplodedCharacter != none)
        {
            // End:0xD9
            if((((ExplodedCharacter.GetShieldHealth() > float(0)) || ExplodedCharacter.IsImmuneToDamage()) || ExplodedCharacter.IsCrowdControlImmune()) || ExplodedCharacter.IsSuperiorCrowdControlImmune())
            {
                m_bExplodedOnShield = true;
            }            
        }
        else
        {
            deployable = TgDeployable(Target);
            // End:0x154
            if((deployable != none) && int(deployable.m_CollisionSettings.mCollisionMode) == int(1))
            {
                m_bExplodedOnShield = true;                
            }
            else
            {
                // End:0x1AD
                if((deployable != none) && int(deployable.m_CollisionSettings.mCollisionMode) == int(2))
                {
                    m_bExplodedOnDeployGeomtry = true;
                }
            }
        }
    }
    m_CachedHitTarget = Target;
    m_vCachedHitLocation = HitLocation;
    m_vCachedHitNormal = HitNormal;
    super(TgProj_Simulated).ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated function AltFireDetonate()
{
    local array<ParticleSysParam> ExplosionParams;

    m_bFlashSpecialExplosion = true;
    m_bSuppressDeployableSpawn = true;
    c_bReadyToHide = true;
    Explode(Location, -Normal(Velocity));
    // End:0xE1
    if(c_Mesh != none)
    {
        GetExplosionFXParams(ExplosionParams);
        c_Mesh.FxActivateIndependant('Generic1', 0, Location, Normal(Velocity) * -1.0000000,,,, ExplosionParams);
        c_Mesh.FxDeactivateGroup('AlwaysOn', 0);
    }
    //return;    
}

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator)
{
    return true;
    //return ReturnValue;    
}

simulated function SpecialHideProjectile()
{
    c_bReadyToHide = true;
    HideProjectile();
    //return;    
}

simulated function HideProjectile()
{
    local Vector vTempLocation;
    local Rotator rTempRotation;
    local TgPawn PawnOwner;
    local TgDevice_BombKingInhand inhandDev;

    HideForNonOwnerClient();
    // End:0x16F
    if(((int(WorldInfo.NetMode) == int(NM_Client)) && c_Mesh != none) && !c_bReadyToHide)
    {
        // End:0xC8
        if(!PredictStickToPlayerSocket(vTempLocation, rTempRotation))
        {
            // End:0x91
            if(m_CachedHitTarget != none)
            {
                m_bDeployOnTarget = true;
            }
            GetDeployLocationAndRotation(vTempLocation, rTempRotation, m_vCachedHitLocation, m_CachedHitTarget, m_vCachedHitNormal);
        }
        SetLocation(vTempLocation);
        SetRotation(rTempRotation);
        PawnOwner = TgPawn(Instigator);
        // End:0x16D
        if(PawnOwner != none)
        {
            inhandDev = TgDevice_BombKingInhand(PawnOwner.GetDeviceByEqPoint(1));
            // End:0x16D
            if(inhandDev != none)
            {
                inhandDev.AddProjectileWaitingForDeployable(self);
            }
        }
        return;
    }
    super(TgProjectile).HideProjectile();
    //return;    
}

simulated function bool PredictStickToPlayerSocket(out Vector outSocketLocation, out Rotator outSocketRotation)
{
    local TgPawn_Character targetCharacter;
    local name SocketName, currentName;
    local Vector SocketLocation, CurrentLocation;
    local array<bool> socketUsed;
    local int I, J, oldestIndex;

    // End:0x11
    if(m_CachedHitTarget == none)
    {
        return false;
    }
    targetCharacter = TgPawn_Character(m_CachedHitTarget);
    // End:0x46F
    if(targetCharacter != none)
    {
        oldestIndex = -1;
        I = 0;
        J0x56:

        // End:0x149 [Loop If]
        if(I < 6)
        {
            // End:0x13B
            if(targetCharacter.r_StuckBombs[I] != none)
            {
                // End:0x13B
                if((oldestIndex == -1) || targetCharacter.r_StuckBombs[oldestIndex].m_TimeCreated > targetCharacter.r_StuckBombs[I].m_TimeCreated)
                {
                    oldestIndex = I;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x56;
        }
        // End:0x46F
        if(targetCharacter.Mesh != none)
        {
            I = 0;
            J0x178:

            // End:0x2DD [Loop If]
            if(I < 6)
            {
                socketUsed[I] = false;
                J = 0;
                J0x1A8:

                // End:0x2CF [Loop If]
                if(J < 6)
                {
                    // End:0x1D2
                    if(J == oldestIndex)
                    {                        
                    }
                    else
                    {
                        // End:0x2C1
                        if(((targetCharacter.r_StuckBombs[J] != none) && !targetCharacter.r_StuckBombs[J].m_bInDestroyedState) && targetCharacter.r_StuckBombs[J].m_StuckSocket == name("CSO_FX_Sticky_0" $ string(I + 1)))
                        {
                            socketUsed[I] = true;
                        }
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x1A8;
                }
                I++;
                // [Loop Continue]
                goto J0x178;
            }
            I = 0;
            J0x2E8:

            // End:0x406 [Loop If]
            if(I < 6)
            {
                currentName = name("CSO_FX_Sticky_0" $ string(I + 1));
                // End:0x3F8
                if(!socketUsed[I])
                {
                    // End:0x3F8
                    if(targetCharacter.Mesh.GetSocketWorldLocationAndRotation(currentName, CurrentLocation))
                    {
                        // End:0x3F8
                        if((SocketName == 'None') || VSizeSq(Location - CurrentLocation) < VSizeSq(Location - SocketLocation))
                        {
                            SocketName = currentName;
                            SocketLocation = CurrentLocation;
                        }
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x2E8;
            }
            // End:0x46F
            if(SocketName != 'None')
            {
                targetCharacter.Mesh.GetSocketWorldLocationAndRotation(currentName, outSocketLocation, outSocketRotation);
                return true;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TgPlayerController TgPC;
    local array<ParticleSysParam> ExplosionParams;

    // End:0x12C
    if((int(WorldInfo.NetMode) == int(NM_Client)) && !c_bReadyToHide)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x12C
        if(((TgPC != none) && TgPC.Pawn != none) && TgPC.Pawn != Instigator)
        {
            // End:0x12C
            if(c_Mesh != none)
            {
                GetExplosionFXParams(ExplosionParams);
                c_Mesh.FxActivateIndependant('Generic1', 0, Location, Normal(Velocity) * -1.0000000,,,, ExplosionParams);
            }
        }
    }
    HideForNonOwnerClient();
    //return;    
}

simulated function HideForNonOwnerClient()
{
    local TgPlayerController TgPC;

    // End:0x116
    if((int(WorldInfo.NetMode) == int(NM_Client)) && !c_bReadyToHide)
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x116
        if(((TgPC != none) && TgPC.Pawn != none) && TgPC.Pawn != Instigator)
        {
            m_bSuppressDeployableSpawn = true;
            c_bReadyToHide = true;
            // End:0x10C
            if(c_Mesh != none)
            {
                c_Mesh.FxDeactivateGroup('AlwaysOn', 0);
            }
            ShutDown();
        }
    }
    //return;    
}

simulated function Destroyed()
{
    // End:0x44
    if((int(WorldInfo.NetMode) == int(NM_Client)) && c_Mesh != none)
    {
        SpecialHideProjectile();
    }
    super.Destroyed();
    //return;    
}

simulated function ShutDown()
{
    local TgPawn PawnOwner;
    local TgDevice_BombKingInhand inhandDev;

    // End:0x0F
    if(m_bIsShutDown)
    {
        return;
    }
    super.ShutDown();
    PawnOwner = TgPawn(Instigator);
    // End:0xC7
    if(PawnOwner != none)
    {
        inhandDev = TgDevice_BombKingInhand(PawnOwner.GetDeviceByEqPoint(1));
        // End:0xC7
        if(inhandDev != none)
        {
            inhandDev.RemovePendingConversion(self, 0);
            inhandDev.UpdateActiveProjectiles();
        }
    }
    // End:0x10B
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && c_Mesh != none)
    {
        SpecialHideProjectile();
    }
    //return;    
}

defaultproperties
{
    m_bExplodeOnTouch=false
    m_bExplodeOnGeometry=true
    m_bUseGravityZOverride=true
    m_fGravityZOverride=-650.0000000
    m_nShadowFXID=7719
    m_fMaxDecalHeight=2000.0000000
    m_bStickToWalls=true
    m_bCanSpawnOnClientFirst=true
    m_DeployableSpawnOrientation=SpawnDeployableOrientation.SDO_FaceRotation
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_BombKingStickyBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_BombKingStickyBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}