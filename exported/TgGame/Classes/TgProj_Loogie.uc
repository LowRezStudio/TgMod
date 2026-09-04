class TgProj_Loogie extends TgProj_Simulated
    native(ChampDrogoz)
    hidecategories(Navigation);

var bool m_bWasExplodedByRocket;
var bool m_bIgnoreRocketOwner;

simulated function HideProjectile()
{
    super(TgProjectile).HideProjectile();
    // End:0x67
    if(c_Mesh != none)
    {
        // End:0x67
        if(m_bWasExplodedByRocket)
        {
            c_Mesh.FxActivateIndependant('Loogie_Explosion', 0, Location, Vector(Rotation));
        }
    }
    //return;    
}

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams)
{
    local TgSpecialFx HitWallFx;

    // End:0xE2
    if(c_Mesh != none)
    {
        // End:0xE2
        if(!m_bWasExplodedByRocket)
        {
            c_Mesh.FxActivateIndependant('Loogie_Impact', 0, Location, Vector(Rotation));
            HitWallFx = TgSpecialFx(c_Mesh.FxGet('Loogie_Impact', 0));
            // End:0xE2
            if(HitWallFx != none)
            {
                HitWallFx.SpawnDecalAt(FXLocation, -HitNormal);
            }
        }
    }
    //return;    
}

simulated event ScaleAbilityFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local int I, J;
    local float Radius;

    Radius = m_fProximityDistance / float(16);
    // End:0x30B
    if((Radius > 0.0000000) && c_Mesh != none)
    {
        FxList = c_Mesh.FxGetAll('AlwaysOn', 0);
        I = 0;
        J0x7E:

        // End:0x1A4 [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x196
            if(Fx != none)
            {
                J = 0;
                J0xD6:

                // End:0x196 [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x188
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', Radius);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0xD6;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x7E;
        }
        FxList = c_Mesh.FxGetAll('Loogie_Explosion', 0);
        I = 0;
        J0x1E5:

        // End:0x30B [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x2FD
            if(Fx != none)
            {
                J = 0;
                J0x23D:

                // End:0x2FD [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x2EF
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('DamageRadius', Radius);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x23D;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x1E5;
        }
    }
    //return;    
}

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgProj_DrogozRocket rocketProjectile;

    // End:0x0F
    if(m_bWasExplodedByRocket)
    {
        return;
    }
    // End:0x1B0
    if(((Other != none) && Other.Owner != none) && !m_bHasExploded)
    {
        // End:0x1B0
        if(Other.Owner.IsA('TgProj_DrogozRocket') || Other.Owner.IsA('TgDevice_DragonSlam'))
        {
            // End:0x1B0
            if((Other.Owner.Instigator == Instigator) || m_bIgnoreRocketOwner)
            {
                DetonateFromRocket(Other.Owner, HitLocation, HitNormal);
                rocketProjectile = TgProj_DrogozRocket(Other.Owner);
                // End:0x1B0
                if(rocketProjectile != none)
                {
                    rocketProjectile.ShutDown();
                }
            }
        }
    }
    super(TgProjectile).ProxyTouch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x3F
    if(m_bWasExplodedByRocket && m_OwnerFireMode != none)
    {
        m_OwnerFireMode.m_bIsAOE = true;
    }
    super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    // End:0xA3
    if(m_bWasExplodedByRocket && m_OwnerFireMode != none)
    {
        m_OwnerFireMode.m_bIsAOE = false;
    }
    //return;    
}

simulated function DetonateFromRocket(Actor Target, Vector HitLocation, Vector HitNormal)
{
    m_bFlashSpecialExplosion = true;
    m_bWasExplodedByRocket = true;
    ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TgProj_DrogozRocket rocketProjectile;

    m_bWasExplodedByRocket = true;
    // End:0xB6
    if((int(WorldInfo.NetMode) == int(NM_Client)) && Target != none)
    {
        rocketProjectile = TgProj_DrogozRocket(Target);
        // End:0xB6
        if((rocketProjectile != none) && !rocketProjectile.m_bIsShutDown)
        {
            rocketProjectile.ShutDown();
        }
    }
    super.ClientExplodeSpecial(Target, HitLocation, HitNormal);
    //return;    
}

event bool UseAOE()
{
    // End:0x12
    if(m_bWasExplodedByRocket)
    {
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator)
{
    local TgPawn_Drogoz drogozOwner;

    // End:0xEE
    if(m_bWasExplodedByRocket)
    {
        FireMode.ApplyHitSpecial(Impact.HitActor, Impact, 10693);
        drogozOwner = TgPawn_Drogoz(r_Owner);
        // End:0xEC
        if((drogozOwner != none) && drogozOwner.r_bCombustibleActive)
        {
            FireMode.ApplyHitSpecial(Impact.HitActor, Impact);
        }
        return true;
    }
    return FireMode.ApplyHit(Impact, DamageInstigator);
    //return ReturnValue;    
}

defaultproperties
{
    m_fGravityScale=0.7000000
    m_nShadowFXID=6883
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Loogie.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Loogie.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Physics=EPhysics.PHYS_Falling
    CollisionComponent=CollisionCylinder
}