class TgDeploy_GeometryBarrierTank extends TgDeploy_Geometry
    native(ChampBarrierTank)
    notplaceable
    hidecategories(Navigation);

const IMPASSE_SIDE_WALL_SEGMENTS = 2;

var TgPawn_BarrierTank m_CachedInaraPawn;
var export editinline MeshComponent m_CenterMesh;
var export editinline MeshComponent m_LeftMeshes[2];
var export editinline MeshComponent m_RightMeshes[2];
var int m_WallMeshIDCenter;
var int m_WallMeshIDEndCap;
var repnotify bool r_bGrowthModeActivationSignal;
var bool m_bInGrowthMode;
var bool m_bDidInitialHit;
var repnotify bool r_bEarthenGuardActive;
var repnotify bool r_bHasAlpine;
var float m_fGrowStartTime;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && !bNetInitial)
        r_bEarthenGuardActive, r_bGrowthModeActivationSignal, 
        r_bHasAlpine;
}

// Export UTgDeploy_GeometryBarrierTank::execSpawnMeshSegments(FFrame&, void* const)
native function SpawnMeshSegments();

// Export UTgDeploy_GeometryBarrierTank::execInitializeMeshSegment(FFrame&, void* const)
native function InitializeMeshSegment(MeshComponent Mesh, float fOffset);

// Export UTgDeploy_GeometryBarrierTank::execSignalGrowthModeStart(FFrame&, void* const)
native function SignalGrowthModeStart();

// Export UTgDeploy_GeometryBarrierTank::execToggleGrowthMode(FFrame&, void* const)
native function ToggleGrowthMode(bool bTurnOn);

// Export UTgDeploy_GeometryBarrierTank::execPushBasedActors(FFrame&, void* const)
native function PushBasedActors();

// Export UTgDeploy_GeometryBarrierTank::execDoInitialHit(FFrame&, void* const)
native function DoInitialHit();

// Export UTgDeploy_GeometryBarrierTank::execPushOverlappingActors(FFrame&, void* const)
native function PushOverlappingActors(float DeltaSeconds);

// Export UTgDeploy_GeometryBarrierTank::execGetSegmentWorldLocation(FFrame&, void* const)
native function Vector GetSegmentWorldLocation(Vector vLocalLocation);

// Export UTgDeploy_GeometryBarrierTank::execHasCachedInaraPawn(FFrame&, void* const)
native function bool HasCachedInaraPawn();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x25
    if(VarName == 'r_bGrowthModeActivationSignal')
    {
        ToggleGrowthMode(true);        
    }
    else
    {
        // End:0x5A
        if(VarName == 'r_bEarthenGuardActive')
        {
            ActivateDisplayGroups('Generic4', false, r_bEarthenGuardActive);
        }
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

event AddBasedPawn(TgPawn basedPawn)
{
    local TgPlayerController TgPC;

    super(TgDeployable).AddBasedPawn(basedPawn);
    // End:0xB4
    if((m_bInGrowthMode && basedPawn != none) && m_PawnsBasedOnMe.Find(basedPawn) != -1)
    {
        TgPC = TgPlayerController(basedPawn.Controller);
        // End:0xB4
        if(TgPC != none)
        {
            TgPC.SetNoSmoothedMovementCorrection(true, true);
        }
    }
    //return;    
}

event RemoveBasedPawn(TgPawn basedPawn)
{
    local TgPlayerController TgPC;

    super(TgDeployable).RemoveBasedPawn(basedPawn);
    // End:0xB4
    if((m_bInGrowthMode && basedPawn != none) && m_PawnsBasedOnMe.Find(basedPawn) == -1)
    {
        TgPC = TgPlayerController(basedPawn.Controller);
        // End:0xB4
        if(TgPC != none)
        {
            TgPC.SetNoSmoothedMovementCorrection(false, true);
        }
    }
    //return;    
}

simulated event ActivateDisplayGroups(name DisplayGroup, bool bActivateIndependent, optional bool bTurnOn = true)
{
    local int I, J;
    local TgSpecialFx meshFX;
    local editinline ParticleSystemComponent PSC;
    local Vector vSegmentLocation, vRotation;

    // End:0x74A
    if(c_Mesh != none)
    {
        vRotation = Normal(Vector(Rotation));
        // End:0x255
        if(m_CenterMesh != none)
        {
            vSegmentLocation = GetSegmentWorldLocation(m_CenterMesh.Translation);
            // End:0xBB
            if(bActivateIndependent)
            {
                m_CenterMesh.FxActivateIndependant(DisplayGroup, 0, vSegmentLocation, vRotation);                
            }
            else
            {
                // End:0x22A
                if(bTurnOn)
                {
                    meshFX = TgSpecialFx(m_CenterMesh.FxGet(DisplayGroup, 0));
                    // End:0x1FA
                    if(meshFX != none)
                    {
                        J = 0;
                        J0x121:

                        // End:0x1FA [Loop If]
                        if(J < meshFX.c_PSCList.Length)
                        {
                            PSC = meshFX.c_PSCList[J].c_PSC;
                            // End:0x1EC
                            if(PSC != none)
                            {
                                PSC.SetAbsolute(true, true, true);
                                PSC.SetTranslation(vSegmentLocation);
                            }
                            J++;
                            // [Loop Continue]
                            goto J0x121;
                        }
                    }
                    m_CenterMesh.FxActivateGroup(DisplayGroup, 0);                    
                }
                else
                {
                    m_CenterMesh.FxDeactivateGroup(DisplayGroup, 0);
                }
            }
        }
        I = 0;
        J0x260:

        // End:0x74A [Loop If]
        if(I < 2)
        {
            // End:0x4D6
            if(m_LeftMeshes[I] != none)
            {
                vSegmentLocation = GetSegmentWorldLocation(m_LeftMeshes[I].Translation);
                // End:0x31E
                if(bActivateIndependent)
                {
                    m_LeftMeshes[I].FxActivateIndependant(DisplayGroup, 0, vSegmentLocation, vRotation);                    
                }
                else
                {
                    // End:0x4A1
                    if(bTurnOn)
                    {
                        meshFX = TgSpecialFx(m_LeftMeshes[I].FxGet(DisplayGroup, 0));
                        // End:0x467
                        if(meshFX != none)
                        {
                            J = 0;
                            J0x38E:

                            // End:0x467 [Loop If]
                            if(J < meshFX.c_PSCList.Length)
                            {
                                PSC = meshFX.c_PSCList[J].c_PSC;
                                // End:0x459
                                if(PSC != none)
                                {
                                    PSC.SetAbsolute(true, true, true);
                                    PSC.SetTranslation(vSegmentLocation);
                                }
                                J++;
                                // [Loop Continue]
                                goto J0x38E;
                            }
                        }
                        m_LeftMeshes[I].FxActivateGroup(DisplayGroup, 0);                        
                    }
                    else
                    {
                        m_LeftMeshes[I].FxDeactivateGroup(DisplayGroup, 0);
                    }
                }
            }
            // End:0x73C
            if(m_RightMeshes[I] != none)
            {
                vSegmentLocation = GetSegmentWorldLocation(m_RightMeshes[I].Translation);
                // End:0x584
                if(bActivateIndependent)
                {
                    m_RightMeshes[I].FxActivateIndependant(DisplayGroup, 0, vSegmentLocation, vRotation);                    
                }
                else
                {
                    // End:0x707
                    if(bTurnOn)
                    {
                        meshFX = TgSpecialFx(m_RightMeshes[I].FxGet(DisplayGroup, 0));
                        // End:0x6CD
                        if(meshFX != none)
                        {
                            J = 0;
                            J0x5F4:

                            // End:0x6CD [Loop If]
                            if(J < meshFX.c_PSCList.Length)
                            {
                                PSC = meshFX.c_PSCList[J].c_PSC;
                                // End:0x6BF
                                if(PSC != none)
                                {
                                    PSC.SetAbsolute(true, true, true);
                                    PSC.SetTranslation(vSegmentLocation);
                                }
                                J++;
                                // [Loop Continue]
                                goto J0x5F4;
                            }
                        }
                        m_RightMeshes[I].FxActivateGroup(DisplayGroup, 0);                        
                    }
                    else
                    {
                        m_RightMeshes[I].FxDeactivateGroup(DisplayGroup, 0);
                    }
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x260;
        }
    }
    //return;    
}

simulated function DeployComplete()
{
    local int I, J;
    local MaterialInstanceConstant MIC;
    local float fEnemyScalarValue;

    // End:0x1E
    if(m_bIsDeployed || m_bInDestroyedState)
    {
        return;
    }
    // End:0x37
    if(!r_bGrowthModeActivationSignal)
    {
        SignalGrowthModeStart();
    }
    SetCollision(true, true, false);
    ActivateDisplayGroups('Generic3', true);
    ActivateDisplayGroups('AlwaysOn', false, true);
    fEnemyScalarValue = ((IsFriendlyWithLocalPawn()) ? 0.0000000 : 1.0000000);
    // End:0x17A
    if(m_CenterMesh != none)
    {
        I = 0;
        J0xA4:

        // End:0x15A [Loop If]
        if(I < m_CenterMesh.Materials.Length)
        {
            MIC = MaterialInstanceConstant(m_CenterMesh.Materials[I]);
            // End:0x14C
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
            }
            I++;
            // [Loop Continue]
            goto J0xA4;
        }
        m_CenterMesh.SetHidden(false);
    }
    I = 0;
    J0x185:

    // End:0x3D3 [Loop If]
    if(I < 2)
    {
        // End:0x2AD
        if(m_LeftMeshes[I] != none)
        {
            J = 0;
            J0x1B9:

            // End:0x283 [Loop If]
            if(J < m_LeftMeshes[I].Materials.Length)
            {
                MIC = MaterialInstanceConstant(m_LeftMeshes[I].Materials[J]);
                // End:0x275
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
                }
                J++;
                // [Loop Continue]
                goto J0x1B9;
            }
            m_LeftMeshes[I].SetHidden(false);
        }
        // End:0x3C5
        if(m_RightMeshes[I] != none)
        {
            J = 0;
            J0x2D1:

            // End:0x39B [Loop If]
            if(J < m_RightMeshes[I].Materials.Length)
            {
                MIC = MaterialInstanceConstant(m_RightMeshes[I].Materials[J]);
                // End:0x38D
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('FRIENDLY_ENEMY', fEnemyScalarValue);
                }
                J++;
                // [Loop Continue]
                goto J0x2D1;
            }
            m_RightMeshes[I].SetHidden(false);
        }
        ++I;
        // [Loop Continue]
        goto J0x185;
    }
    super(TgDeployable).DeployComplete();
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local int I;

    super(TgDeployable).DestroyIt(bSkipFx);
    // End:0x41
    if((GetHealth()) <= 0.0000000)
    {
        ActivateDisplayGroups('Generic1', true);        
    }
    else
    {
        ActivateDisplayGroups('Generic2', true);
    }
    ActivateDisplayGroups('AlwaysOn', false, false);
    // End:0x9A
    if(m_CenterMesh != none)
    {
        m_CenterMesh.SetHidden(true);
    }
    I = 0;
    J0xA5:

    // End:0x149 [Loop If]
    if(I < 2)
    {
        // End:0xF8
        if(m_LeftMeshes[I] != none)
        {
            m_LeftMeshes[I].SetHidden(true);
        }
        // End:0x13B
        if(m_RightMeshes[I] != none)
        {
            m_RightMeshes[I].SetHidden(true);
        }
        ++I;
        // [Loop Continue]
        goto J0xA5;
    }
    //return;    
}

defaultproperties
{
    m_WallMeshIDCenter=7094
    m_WallMeshIDEndCap=7166
    m_fGrowStartTime=-0.5000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_GeometryBarrierTank.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Geometry.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bPawnsCanBaseOnMe=true)
    Components[0]=MyLightEnvironment
}