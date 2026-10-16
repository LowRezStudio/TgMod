class TgProj_DarklordBase extends TgProj_SpeedOverRange
    native(ChampDarklord)
    hidecategories(Navigation);

struct native TrackedCollision
{
    var bool IsColliding;
    var Actor Target;
    var export editinline PrimitiveComponent TargetComp;
    var int NumTouches;

    structdefaultproperties
    {
        IsColliding=false
        Target=none
        TargetComp=none
        NumTouches=0
    }
};

var TgCollisionProxy_Cylinder m_SecondaryCollisionProxies[2];
var export editinline ParticleSystemComponent m_SecondaryDebugProximityDistancePSC[2];
var array<TrackedCollision> m_TrackedCollisions;

// Export UTgProj_DarklordBase::execCompleteInitialization(FFrame&, void* const)
native function CompleteInitialization();

simulated function OnSecondaryProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    HandleSecondaryProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event OnSecondaryProxyUnTouch(Actor Other)
{
    HandleSecondaryProxyUntouch(Other);
    //return;    
}

simulated event ForwardProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    ProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event ForwardProxyUntouch(Actor Other)
{
    ProxyUnTouch(Other);
    //return;    
}

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    HandleSecondaryProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event ProxyUnTouch(Actor Other)
{
    HandleSecondaryProxyUntouch(Other);
    //return;    
}

// Export UTgProj_DarklordBase::execHandleSecondaryProxyTouch(FFrame&, void* const)
native simulated function HandleSecondaryProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);

// Export UTgProj_DarklordBase::execHandleSecondaryProxyUntouch(FFrame&, void* const)
native simulated function HandleSecondaryProxyUntouch(Actor Other);

simulated function Vector GetCollisionOffsetDir()
{
    return MatrixGetAxis(MakeRotationMatrix(Rotation), 2);
    //return ReturnValue;    
}

simulated event SpawnSecondaryCollisionProxies()
{
    local int I;

    // End:0x42F
    if((m_OwnerFireMode != none) && m_OwnerFireMode.GetCustomValue1() > 0.0000000)
    {
        I = 0;
        J0x45:

        // End:0x42F [Loop If]
        if(I < 2)
        {
            // End:0xA5
            if(m_SecondaryCollisionProxies[I] != none)
            {
                m_SecondaryCollisionProxies[I].Destroy();
                m_SecondaryCollisionProxies[I] = none;
            }
            m_SecondaryCollisionProxies[I] = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
            // End:0x421
            if(m_SecondaryCollisionProxies[I] != none)
            {
                m_SecondaryCollisionProxies[I].SetBase(self);
                m_SecondaryCollisionProxies[I].__ProxyTouch__Delegate = OnSecondaryProxyTouch;
                m_SecondaryCollisionProxies[I].__ProxyUnTouch__Delegate = OnSecondaryProxyUnTouch;
                m_SecondaryCollisionProxies[I].DelegatesUpdated();
                m_SecondaryCollisionProxies[I].m_CollisionCylinder.SetCylinderSize(m_fProximityDistance, m_fProximityDistance);
                m_SecondaryCollisionProxies[I].ForceProximityScan();
                // End:0x2AB
                if(I == 0)
                {
                    m_SecondaryCollisionProxies[I].SetRelativeLocation((-m_OwnerFireMode.GetCustomValue1() * float(16)) * (GetCollisionOffsetDir()));                    
                }
                else
                {
                    m_SecondaryCollisionProxies[I].SetRelativeLocation((m_OwnerFireMode.GetCustomValue1() * float(16)) * (GetCollisionOffsetDir()));
                }
                // End:0x421
                if(((m_fProximityDistance > float(0)) && TgRepInfo_Game(WorldInfo.GRI).r_bShowProjectileProximityDistance) && (int(r_eEquippedAt) == int(1)) || int(r_eEquippedAt) == int(5))
                {
                    // End:0x3BB
                    if(m_SecondaryDebugProximityDistancePSC[I] == none)
                    {
                        m_SecondaryDebugProximityDistancePSC[I] = SpawnDebugProximityDistancePSC();
                    }
                    m_SecondaryCollisionProxies[I].AttachComponent(m_SecondaryDebugProximityDistancePSC[I]);
                    m_SecondaryDebugProximityDistancePSC[I].ActivateSystem();
                }
            }
            I++;
            // [Loop Continue]
            goto J0x45;
        }
    }
    //return;    
}

simulated function HideProjectile()
{
    local int I;

    super(TgProjectile).HideProjectile();
    I = 0;
    J0x15:

    // End:0x75 [Loop If]
    if(I < 2)
    {
        // End:0x67
        if(m_SecondaryDebugProximityDistancePSC[I] != none)
        {
            m_SecondaryDebugProximityDistancePSC[I].DeactivateSystem();
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    //return;    
}

simulated function float GetDecalRotationOffset()
{
    return float(Rand(10)) - 5.0000000;
    //return ReturnValue;    
}

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded)
{
    local Vector vImpactLocation;
    local float fImpactDistance;

    // End:0x3A
    if(Target != none)
    {
        vImpactLocation = Target.Location;        
    }
    else
    {
        vImpactLocation = HitLocation;
    }
    fImpactDistance = VSize(r_vSpawnLocation - vImpactLocation);
    SetRTPCValue('ImpactDistance', fImpactDistance);
    super(TgProjectile).PlayHitTargetFX(Target, HitLocation, HitNormal, bExploded);
    //return;    
}

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation)
{
    local TgSpecialFx DecalFx;
    local float DecalRotation, fImpactDistance;

    fImpactDistance = VSize(r_vSpawnLocation - HitLocation);
    SetRTPCValue('ImpactDistance', fImpactDistance);
    super(TgProjectile).PlayHitWallExplosionFX(HitNormal, HitLocation);
    // End:0x148
    if(c_Mesh != none)
    {
        DecalFx = TgSpecialFx(c_Mesh.FxGet('Generic1', 0));
        // End:0x148
        if(DecalFx != none)
        {
            DecalRotation = DecalFx.CalculateOrientedDecalRotation(HitLocation, HitNormal, Normal(m_vSpawnVelocity));
            DecalFx.SpawnDecalAt(HitLocation, -HitNormal, DecalRotation + (GetDecalRotationOffset()), 1.0000000);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DarklordBase.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_SpeedOverRange.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_DarklordBase.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_SpeedOverRange.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}