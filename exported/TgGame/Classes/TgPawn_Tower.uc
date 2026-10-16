class TgPawn_Tower extends TgPawn_TowerBase
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var float m_TimeSinceDeath;
var array<MaterialInstanceConstant> m_DestroyedMICs;
var float m_fFadeOutStartTime;
var float m_fFadeOutEndTime;
var Vector r_vInitialRotation;
var bool m_bUseDestruction;
var bool r_bSide0Destroyed;
var bool r_bSide1Destroyed;
var bool r_bSide2Destroyed;
var bool r_bSide3Destroyed;
var repnotify byte r_PlaySide0Destruction;
var repnotify byte r_PlaySide1Destruction;
var repnotify byte r_PlaySide2Destruction;
var repnotify byte r_PlaySide3Destruction;
var int m_nSide0MeshId;
var int m_nSide1MeshId;
var int m_nSide2MeshId;
var int m_nSide3MeshId;
var int m_nSide0Health;
var int m_nSide1Health;
var int m_nSide2Health;
var int m_nSide3Health;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bSide0Destroyed, r_bSide1Destroyed, 
        r_bSide2Destroyed, r_bSide3Destroyed, 
        r_vInitialRotation;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && !bNetInitial)
        r_PlaySide0Destruction, r_PlaySide1Destruction, 
        r_PlaySide2Destruction, r_PlaySide3Destruction;
}

// Export UTgPawn_Tower::execSendAttackAlert(FFrame&, void* const)
native function SendAttackAlert();

// Export UTgPawn_Tower::execSendDeathAlert(FFrame&, void* const)
native function SendDeathAlert();

// Export UTgPawn_Tower::execSendTargetedAlert(FFrame&, void* const)
native function SendTargetedAlert(TgPawn Target);

// Export UTgPawn_Tower::execSwapToBrokenMesh(FFrame&, void* const)
native function SwapToBrokenMesh();

// Export UTgPawn_Tower::execBroadcastDiedToGame(FFrame&, void* const)
native function BroadcastDiedToGame();

// Export UTgPawn_Tower::execGetMeshOverrideForScript(FFrame&, void* const)
native function int GetMeshOverrideForScript(int MeshId);

simulated function PostBeginPlay()
{
    super(TgPawn).PostBeginPlay();
    // End:0x6A
    if(int(Role) == int(ROLE_Authority))
    {
        r_vInitialRotation = Vector(Rotation);
        r_vInitialRotation.Z = 0.0000000;
        r_vInitialRotation = Normal(r_vInitialRotation);
    }
    //return;    
}

simulated event bool PostPawnSetup()
{
    local bool Retval;

    Retval = super(TgPawn).PostPawnSetup();
    CheckSideDestructionSkelControls();
    return Retval;
    //return ReturnValue;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x9F
    if(m_bUseDestruction)
    {
        // End:0x31
        if(VarName == 'r_PlaySide0Destruction')
        {
            PlaySideDestructionAnim(0);
            return;
        }
        // End:0x55
        if(VarName == 'r_PlaySide1Destruction')
        {
            PlaySideDestructionAnim(1);
            return;
        }
        // End:0x7A
        if(VarName == 'r_PlaySide2Destruction')
        {
            PlaySideDestructionAnim(2);
            return;
        }
        // End:0x9F
        if(VarName == 'r_PlaySide3Destruction')
        {
            PlaySideDestructionAnim(3);
            return;
        }
    }
    super(TgPawn).ReplicatedEvent(VarName);
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local Vector ForwardDir, LeftDir, HitDir;
    local float ForwardPct, LeftPct;

    super(TgPawn_Structure).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo);
    // End:0x3A6
    if(m_bUseDestruction && !ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        ForwardDir = r_vInitialRotation;
        LeftDir = ForwardDir Cross vect(0.0000000, 0.0000000, 1.0000000);
        HitDir = Location - HitLocation;
        HitDir.Z = 0.0000000;
        HitDir = Normal(HitDir);
        ForwardPct = HitDir Dot ForwardDir;
        LeftPct = HitDir Dot LeftDir;
        // End:0x277
        if(ForwardPct >= 0.0000000)
        {
            // End:0x1E8
            if(LeftPct >= 0.0000000)
            {
                // End:0x1E5
                if(!r_bSide3Destroyed)
                {
                    // End:0x1E5
                    if(m_nSide3Health > 0)
                    {
                        m_nSide3Health -= Damage;
                        // End:0x1E5
                        if(m_nSide3Health <= 0)
                        {
                            // End:0x1CE
                            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                            {
                                PlaySideDestructionAnim(3);
                            }
                            r_bSide3Destroyed = true;
                            r_PlaySide3Destruction++;
                        }
                    }
                }                
            }
            else
            {
                // End:0x274
                if(!r_bSide1Destroyed)
                {
                    // End:0x274
                    if(m_nSide1Health > 0)
                    {
                        m_nSide1Health -= Damage;
                        // End:0x274
                        if(m_nSide1Health <= 0)
                        {
                            // End:0x25D
                            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                            {
                                PlaySideDestructionAnim(1);
                            }
                            r_bSide1Destroyed = true;
                            r_PlaySide1Destruction++;
                        }
                    }
                }
            }            
        }
        else
        {
            // End:0x31A
            if(LeftPct >= 0.0000000)
            {
                // End:0x317
                if(!r_bSide2Destroyed)
                {
                    // End:0x317
                    if(m_nSide2Health > 0)
                    {
                        m_nSide2Health -= Damage;
                        // End:0x317
                        if(m_nSide2Health <= 0)
                        {
                            // End:0x300
                            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                            {
                                PlaySideDestructionAnim(2);
                            }
                            r_bSide2Destroyed = true;
                            r_PlaySide2Destruction++;
                        }
                    }
                }                
            }
            else
            {
                // End:0x3A6
                if(!r_bSide0Destroyed)
                {
                    // End:0x3A6
                    if(m_nSide0Health > 0)
                    {
                        m_nSide0Health -= Damage;
                        // End:0x3A6
                        if(m_nSide0Health <= 0)
                        {
                            // End:0x38F
                            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
                            {
                                PlaySideDestructionAnim(0);
                            }
                            r_bSide0Destroyed = true;
                            r_PlaySide0Destruction++;
                        }
                    }
                }
            }
        }
    }
    //return;    
}

simulated function PlaySideDestructionAnim(int SideIndex)
{
    local TgSkeletalMeshActor_DestructibleTowerChunk TowerChunk;
    local Vector SpawnLoc;

    SpawnLoc = Location;
    SpawnLoc.Z -= (NativeGetCollisionHeight());
    TowerChunk = Spawn(Class'TgGame.TgSkeletalMeshActor_DestructibleTowerChunk', self,, SpawnLoc, Rotator(r_vInitialRotation),, true);
    switch(SideIndex)
    {
        // End:0xBD
        case 0:
            TowerChunk.PlayDestruction(GetMeshOverrideForScript(m_nSide0MeshId), self);
            // End:0x170
            break;
        // End:0xF7
        case 1:
            TowerChunk.PlayDestruction(GetMeshOverrideForScript(m_nSide1MeshId), self);
            // End:0x170
            break;
        // End:0x132
        case 2:
            TowerChunk.PlayDestruction(GetMeshOverrideForScript(m_nSide2MeshId), self);
            // End:0x170
            break;
        // End:0x16D
        case 3:
            TowerChunk.PlayDestruction(GetMeshOverrideForScript(m_nSide3MeshId), self);
            // End:0x170
            break;
        // End:0xFFFF
        default:
            break;
    }
    CheckSideDestructionSkelControls(SideIndex);
    //return;    
}

simulated function CheckSideDestructionSkelControls(optional int ForceSideIndexHidden = -1)
{
    // End:0x2B
    if((Mesh == none) || !m_bUseDestruction)
    {
        return;
    }
    // End:0x185
    if(ForceSideIndexHidden == -1)
    {
        SkelControlSingleBone(Mesh.FindSkelControl('Side0')).SetSkelControlActive(r_bSide0Destroyed);
        SkelControlSingleBone(Mesh.FindSkelControl('Side1')).SetSkelControlActive(r_bSide1Destroyed);
        SkelControlSingleBone(Mesh.FindSkelControl('Side2')).SetSkelControlActive(r_bSide2Destroyed);
        SkelControlSingleBone(Mesh.FindSkelControl('Side3')).SetSkelControlActive(r_bSide3Destroyed);        
    }
    else
    {
        switch(ForceSideIndexHidden)
        {
            // End:0x1E7
            case 0:
                SkelControlSingleBone(Mesh.FindSkelControl('Side0')).SetSkelControlActive(true);
                // End:0x2D9
                break;
            // End:0x236
            case 1:
                SkelControlSingleBone(Mesh.FindSkelControl('Side1')).SetSkelControlActive(true);
                // End:0x2D9
                break;
            // End:0x286
            case 2:
                SkelControlSingleBone(Mesh.FindSkelControl('Side2')).SetSkelControlActive(true);
                // End:0x2D9
                break;
            // End:0x2D6
            case 3:
                SkelControlSingleBone(Mesh.FindSkelControl('Side3')).SetSkelControlActive(true);
                // End:0x2D9
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local bool retValue;

    retValue = super.Died(Killer, dmgType, HitLocation);
    BroadcastDiedToGame();
    return retValue;
    //return ReturnValue;    
}

simulated function OnSwapToDestroyedMesh()
{
    local int I;
    local MaterialInstanceConstant MIC;
    local TgAnimBlendByPosture BlendByPostureNode;

    // End:0x77
    if(m_bUseDestruction)
    {
        // End:0x27
        if(!r_bSide0Destroyed)
        {
            PlaySideDestructionAnim(0);
        }
        // End:0x41
        if(!r_bSide1Destroyed)
        {
            PlaySideDestructionAnim(1);
        }
        // End:0x5C
        if(!r_bSide2Destroyed)
        {
            PlaySideDestructionAnim(2);
        }
        // End:0x77
        if(!r_bSide3Destroyed)
        {
            PlaySideDestructionAnim(3);
        }
    }
    SwapToBrokenMesh();
    SwapToDestroyedMesh();
    // End:0xC2
    foreach m_PostureBlendNodes(BlendByPostureNode)
    {
        BlendByPostureNode.ReplayAnim();        
    }    
    I = 0;
    J0xCE:

    MIC = MaterialInstanceConstant(Mesh.GetMaterial(I));
    // End:0x12E
    if(MIC != none)
    {
        m_DestroyedMICs.AddItem(MIC);
    }
    ++I;
    // End:0xCE
    if(!(MIC == none))
        goto J0xCE;
    //return;    
}

simulated event PostDemoRewind()
{
    super(TgPawn_Structure).PostDemoRewind();
    CheckSideDestructionSkelControls();
    //return;    
}

simulated state Dying
{
    local bool HasRemovedMesh;

    simulated function Tick(float DeltaSeconds)
    {
        local MaterialInstanceConstant MIC;
        local float HalfFadeOutDuration;

        super.Tick(DeltaSeconds);
        HalfFadeOutDuration = (m_fFadeOutEndTime - m_fFadeOutStartTime) * 0.5000000;
        m_TimeSinceDeath += DeltaSeconds;
        // End:0x160
        foreach m_DestroyedMICs(MIC)
        {
            // End:0xE1
            if((m_TimeSinceDeath >= m_fFadeOutStartTime) && m_TimeSinceDeath <= (m_fFadeOutStartTime + HalfFadeOutDuration))
            {
                MIC.SetScalarParameterValue('addvalue', 1.0000000 - (m_TimeSinceDeath - m_fFadeOutStartTime));
            }
            // End:0x15F
            if((m_TimeSinceDeath >= (m_fFadeOutStartTime + HalfFadeOutDuration)) && m_TimeSinceDeath <= m_fFadeOutEndTime)
            {
                MIC.SetScalarParameterValue('subvalue', (m_TimeSinceDeath - m_fFadeOutStartTime) - 1.0000000);
            }            
        }        
        // End:0x1B3
        if(!HasRemovedMesh && m_TimeSinceDeath >= m_fFadeOutEndTime)
        {
            DetachComponent(Mesh);
            Mesh = none;
            HasRemovedMesh = true;
        }
        //return;        
    }

    simulated function OnLifeAfterDeathTimerExpired()
    {
        // End:0x27
        if(Controller != none)
        {
            Controller.Destroy();
        }
        bTearOff = true;
        bReplicateMovement = false;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fFadeOutStartTime=4.0000000
    m_fFadeOutEndTime=6.5000000
    // Reference: TgMarkComponent'TgGame.Default__TgPawn_Tower.TowerDamageScaler'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TowerDamageScaler'
    // Archetype: TgMarkComponent'TgGame.Default__TgPawn_TowerBase.TowerDamageScaler'
    begin object name="TowerDamageScaler"
    end object
    s_DamageScaler=TowerDamageScaler
    m_nNumGuardianLevels=1
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Tower.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_TowerBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    FireLocationOffsets[2]=(X=0.0000000,Y=0.0000000,Z=380.0000000)
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Tower.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_TowerBase.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Tower.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_TowerBase.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Tower.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_TowerBase.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Tower.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_TowerBase.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Tower.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_TowerBase.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Tower.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_TowerBase.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=TowerDamageScaler
    CollisionComponent=CollisionCylinder
}