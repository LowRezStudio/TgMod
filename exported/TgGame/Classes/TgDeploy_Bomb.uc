class TgDeploy_Bomb extends TgDeployable
    native(Deployable)
    placeable
    hidecategories(Navigation);

var float r_fPersistTime;
var() export editinline StaticMeshComponent m_CountdownIndicator;
var transient MaterialInstanceConstant m_CountdownIndicatorMIC;
var repnotify float r_fRadiusScale;

replication
{
    // Pos:0x000
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        r_fPersistTime;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_fRadiusScale;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_fRadiusScale')
    {
        ScaleAbilityFX();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0xAD
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0xAD
        if(m_CountdownIndicator != none)
        {
            m_CountdownIndicatorMIC = m_CountdownIndicator.CreateAndSetMaterialInstanceConstant(0);
            m_CountdownIndicatorMIC.SetScalarParameterValue('bIsFriendly', ((IsFriendlyWithLocalPawn()) ? 1.0000000 : 0.0000000));
        }
    }
    //return;    
}

function OnPersistTimerExpire()
{
    StartFire();
    DestroyIt();
    //return;    
}

simulated function ApplyHit(out array<ImpactInfo> ImpactList)
{
    local int Idx, NumEnemiesHit;

    NumEnemiesHit = GetNumEnemyPlayersInList(ImpactList);
    Idx = 0;
    J0x28:

    // End:0xF0 [Loop If]
    if(Idx < ImpactList.Length)
    {
        // End:0xE2
        if(ImpactList[Idx].HitActor != none)
        {
            ImpactList[Idx].HitInfo.Item = NumEnemiesHit;
            m_FireMode.ApplyHit(ImpactList[Idx], self);
        }
        Idx++;
        // [Loop Continue]
        goto J0x28;
    }
    //return;    
}

function int GetNumEnemyPlayersInList(out array<ImpactInfo> ImpactList)
{
    local int Idx, NumEnemyPlayers;
    local TgPawn_Character HitChar;
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x2D
    if(TgP == none)
    {
        return 0;
    }
    NumEnemyPlayers = 0;
    Idx = 0;
    J0x43:

    // End:0x12F [Loop If]
    if(Idx < ImpactList.Length)
    {
        // End:0x121
        if(ImpactList[Idx].HitActor != none)
        {
            HitChar = TgPawn_Character(ImpactList[Idx].HitActor);
            // End:0x121
            if(HitChar != none)
            {
                // End:0x121
                if(int(TgP.GetTaskForceNumber()) != int(HitChar.GetTaskForceNumber()))
                {
                    NumEnemyPlayers++;
                }
            }
        }
        Idx++;
        // [Loop Continue]
        goto J0x43;
    }
    return NumEnemyPlayers;
    //return ReturnValue;    
}

simulated function Tick(float DeltaSeconds)
{
    local float Percent;

    super.Tick(DeltaSeconds);
    // End:0x165
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x165
        if(((m_CountdownIndicator != none) && m_CountdownIndicatorMIC != none) && r_fPersistTime > 0.0000000)
        {
            Percent = ((WorldInfo.TimeSeconds - r_fTimeToDeploySecs) - CreationTime) / r_fPersistTime;
            Percent = 1.0000000 - Percent;
            Percent = FClamp(Percent, 0.0000000, 1.0000000);
            m_CountdownIndicatorMIC.SetScalarParameterValue('Perc', Percent);
            m_CountdownIndicatorMIC.SetScalarParameterValue('bIsFriendly', ((IsFriendlyWithLocalPawn()) ? 1.0000000 : 0.0000000));
        }
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    super.DestroyIt(true);
    // End:0xB0
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0xAD
        if(!bSkipFx && c_Mesh != none)
        {
            c_Mesh.FxActivateGroup('Destroyed', 0);
            c_Mesh.FxDeactivateGroup('OnWhenDeployed', 0);
        }        
    }
    else
    {
        r_nReplicateDestroyIt = ((bSkipFx) ? 2 : 1);
    }
    //return;    
}

event ScaleAbilityRadius()
{
    local TgProperty EffectRadiusProperty, EffectiveRadiusProperty;
    local float EffectRadius, EffectiveRadius, radiusScale;

    // End:0x1C0
    if(int(Role) == int(ROLE_Authority))
    {
        radiusScale = 1.0000000;
        // End:0x1C0
        if((m_FireMode != none) && radiusScale > 0.0000000)
        {
            EffectRadiusProperty = m_FireMode.GetProperty(6);
            EffectiveRadiusProperty = m_FireMode.GetProperty(343);
            // End:0x11F
            if(EffectRadiusProperty != none)
            {
                EffectRadius = EffectRadiusProperty.m_fBase * radiusScale;
                // End:0x11F
                if(EffectRadius > 0.0000000)
                {
                    m_FireMode.SetProperty(6, EffectRadius);
                }
            }
            // End:0x1A1
            if(EffectiveRadiusProperty != none)
            {
                EffectiveRadius = EffectiveRadiusProperty.m_fBase * radiusScale;
                // End:0x1A1
                if(EffectiveRadius > 0.0000000)
                {
                    m_FireMode.SetProperty(343, EffectiveRadius);
                }
            }
            r_fRadiusScale = radiusScale;
            bNetDirty = true;
        }
    }
    //return;    
}

simulated event ScaleAbilityFX()
{
    local array<Object> FxList;
    local TgSpecialFx Fx;
    local editinline ParticleSystemComponent PSC;
    local TgProperty EffectRadiusProperty, EffectiveRadiusProperty;
    local float fFullyEffectiveRadius, fDamageRadius, fFullyEffectiveRadiusUU, fDamageRadiusUU;
    local int I, J;

    // End:0x595
    if(c_Mesh != none)
    {
        fFullyEffectiveRadius = 0.0000000;
        fDamageRadius = 0.0000000;
        fFullyEffectiveRadiusUU = 0.0000000;
        fDamageRadiusUU = 0.0000000;
        // End:0x169
        if(m_FireMode != none)
        {
            EffectRadiusProperty = m_FireMode.GetProperty(6);
            // End:0xE0
            if(EffectRadiusProperty != none)
            {
                fDamageRadius = EffectRadiusProperty.m_fBase * r_fRadiusScale;
                fDamageRadiusUU = fDamageRadius * float(16);
            }
            EffectiveRadiusProperty = m_FireMode.GetProperty(343);
            // End:0x169
            if(EffectiveRadiusProperty != none)
            {
                fFullyEffectiveRadius = EffectiveRadiusProperty.m_fBase * r_fRadiusScale;
                fFullyEffectiveRadiusUU = fFullyEffectiveRadius * float(16);
            }
        }
        FxList = c_Mesh.FxGetAll('AlwaysOn', 0);
        I = 0;
        J0x1AA:

        // End:0x37F [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x371
            if(Fx != none)
            {
                J = 0;
                J0x202:

                // End:0x355 [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x347
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('FullyEffectiveRadius', fFullyEffectiveRadius);
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('FullyEffectiveRadiusUU', fFullyEffectiveRadiusUU);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x202;
                }
                UpdateDecalScale(Fx, r_fRadiusScale);
            }
            I++;
            // [Loop Continue]
            goto J0x1AA;
        }
        FxList = c_Mesh.FxGetAll('Destroyed', 0);
        I = 0;
        J0x3C0:

        // End:0x595 [Loop If]
        if(I < FxList.Length)
        {
            Fx = TgSpecialFx(FxList[I]);
            // End:0x56B
            if(Fx != none)
            {
                J = 0;
                J0x418:

                // End:0x56B [Loop If]
                if(J < Fx.c_PSCList.Length)
                {
                    PSC = Fx.c_PSCList[J].c_PSC;
                    // End:0x55D
                    if(PSC != none)
                    {
                        PSC.SetFloatParameter('FullyEffectiveRadius', fFullyEffectiveRadius);
                        PSC.SetFloatParameter('DamageRadius', fDamageRadius);
                        PSC.SetFloatParameter('FullyEffectiveRadiusUU', fFullyEffectiveRadiusUU);
                        PSC.SetFloatParameter('DamageRadiusUU', fDamageRadiusUU);
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x418;
                }
            }
            UpdateDecalScale(Fx, r_fRadiusScale);
            I++;
            // [Loop Continue]
            goto J0x3C0;
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgStaticMeshComponent'TgGame.Default__TgDeploy_Bomb.CountdownIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CountdownIndicator'
    begin object name="CountdownIndicator" class=TgGame.TgStaticMeshComponent
        Materials=/* Array type was not detected. */
        ReplacementPrimitive=none
        DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_Foreground
        AbsoluteRotation=true
        Translation=(X=0.0000000,Y=0.0000000,Z=80.0000000)
        Scale3D=(X=0.2000000,Y=0.2000000,Z=0.2000000)
    end object
    m_CountdownIndicator=CountdownIndicator
    r_fRadiusScale=1.0000000
    m_bFireOnDeploy=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Bomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_Bomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    Components[2]=CountdownIndicator
    bCollideActors=true
    CollisionComponent=CollisionCylinder
}