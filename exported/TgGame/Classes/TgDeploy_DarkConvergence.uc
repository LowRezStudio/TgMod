class TgDeploy_DarkConvergence extends TgDeploy_Bomb
    native(ChampOracle)
    placeable
    hidecategories(Navigation);

const MAX_DARK_CONVERGENCE_TARGETS = 5;
const DARK_CONVERGENCE_PULL_BEAM_FX_ID = 7681;

struct native PullData
{
    var TgPawn_Character Character;
    var Vector SourceLocation;
    var Vector TargetLocation;

    structdefaultproperties
    {
        Character=none
        SourceLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        TargetLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var array<PullData> m_PullDataList;
var repnotify TgPawn_Character r_PulledTargets[5];
var repnotify Vector r_PulledTargetLocations[5];
var array<TgBeamHelper> c_Beams;
var float c_fHideBeamsTimer;
var float s_fValidationRayDistance;
var float s_fValidationRayRadius;
var float s_fValidationRayHeight;
var float s_fValidationMaxFloorOffset;
var float s_fVerticalTargetLocationOffset;

replication
{
    // Pos:0x000
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && (!bNetOwner || bDemoRecording) || bNetTimelapse)
        r_PulledTargetLocations, r_PulledTargets;
}

simulated function float GetPullDelay()
{
    // End:0x2F
    if(m_FireMode != none)
    {
        return m_FireMode.GetCustomValue2();
    }
    return 0.4000000;
    //return ReturnValue;    
}

simulated function float GetPullTime()
{
    // End:0x2F
    if(m_FireMode != none)
    {
        return m_FireMode.GetCustomValue1();
    }
    return 0.5000000;
    //return ReturnValue;    
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x36
        case 'r_PulledTargets':
            ApplyForcedView();
            CreateBeams();
            // End:0x52
            break;
        // End:0x4F
        case 'r_PulledTargetLocations':
            UpdateBeams();
            // End:0x52
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function ApplyForcedView()
{
    local int I;

    // End:0xBF
    if(m_FireMode != none)
    {
        I = 0;
        J0x1A:

        // End:0xBF [Loop If]
        if(I < 5)
        {
            // End:0xB1
            if(r_PulledTargets[I] != none)
            {
                r_PulledTargets[I].AddForcedViewTarget(self, GetPullDelay(), (GetPullDelay()) + 0.1000000, self, r_PulledTargets[I].EyeHeight);
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

simulated function CreateBeams()
{
    local int I;
    local TgBeamHelper Beam;

    // End:0x10F
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        c_Beams.Length = 0;
        I = 0;
        J0x40:

        // End:0x105 [Loop If]
        if(I < 5)
        {
            Beam = none;
            // End:0xE1
            if(r_PulledTargets[I] != none)
            {
                Beam = Class'TgGame.TgBeamHelper'.static.Create(7681);
                Beam.AttachToOwner(self);
                Beam.Activate();
            }
            c_Beams.AddItem(Beam);
            I++;
            // [Loop Continue]
            goto J0x40;
        }
        UpdateBeams();
    }
    //return;    
}

simulated function HideBeams()
{
    local int I;

    // End:0xB2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        I = 0;
        J0x34:

        // End:0xB2 [Loop If]
        if(I < c_Beams.Length)
        {
            // End:0xA4
            if(c_Beams[I] != none)
            {
                c_Beams[I].Deactivate(true);
                c_Beams[I] = none;
            }
            I++;
            // [Loop Continue]
            goto J0x34;
        }
    }
    //return;    
}

simulated function UpdateBeams()
{
    local int Idx;
    local Vector vDirToCenter, vDirToTarget;

    // End:0x26F
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        Idx = 0;
        J0x34:

        // End:0x26F [Loop If]
        if(Idx < c_Beams.Length)
        {
            // End:0x261
            if((c_Beams[Idx] != none) && r_PulledTargets[Idx] != none)
            {
                c_Beams[Idx].SetEndPoint(r_PulledTargets[Idx].Location);
                vDirToTarget.X = r_PulledTargetLocations[Idx].X;
                vDirToTarget.Y = r_PulledTargetLocations[Idx].Y;
                vDirToTarget.Z = r_PulledTargets[Idx].Location.Z;
                vDirToTarget = Normal(r_PulledTargetLocations[Idx] - Location) * 10.0000000;
                vDirToCenter = Normal(Location - r_PulledTargets[Idx].Location) * 5.0000000;
                c_Beams[Idx].SetTangents(vDirToTarget, vDirToCenter);
            }
            Idx++;
            // [Loop Continue]
            goto J0x34;
        }
    }
    //return;    
}

simulated function ApplyHit(out array<ImpactInfo> ImpactList)
{
    local int Idx;
    local TgPawn TgP;
    local TgPawn_Character HitChar;
    local PullData Data;
    local int NumPulledTargets;

    TgP = TgPawn(Instigator);
    // End:0x2D
    if(TgP == none)
    {
        return;
    }
    m_PullDataList.Length = 0;
    // End:0x4CB
    if(m_FireMode != none)
    {
        Idx = 0;
        J0x53:

        // End:0x2C2 [Loop If]
        if((Idx < ImpactList.Length) && Idx < 5)
        {
            // End:0x2B4
            if(ImpactList[Idx].HitActor != none)
            {
                HitChar = TgPawn_Character(ImpactList[Idx].HitActor);
                // End:0x2B4
                if(((((((HitChar != none) && HitChar.CanApplyEffects()) && HitChar.GetPropCurrentValue(132) <= 0.0000000) && HitChar.GetPropCurrentValue(60) <= 0.0000000) && HitChar.GetPropCurrentValue(61) <= 0.0000000) && !HitChar.IsDebuffImmune()) && HitChar.WillHitSuccessfully(Instigator, ImpactList[Idx]))
                {
                    Data.Character = HitChar;
                    Data.SourceLocation = HitChar.Location;
                    Data.TargetLocation = HitChar.Location;
                    m_PullDataList.AddItem(Data);
                }
            }
            Idx++;
            // [Loop Continue]
            goto J0x53;
        }
        DetermineTeleportLocations();
        NumPulledTargets = 0;
        Idx = 0;
        J0x2E2:

        // End:0x336 [Loop If]
        if(Idx < 5)
        {
            r_PulledTargets[Idx] = none;
            r_PulledTargetLocations[Idx] = vect(0.0000000, 0.0000000, 0.0000000);
            Idx++;
            // [Loop Continue]
            goto J0x2E2;
        }
        bNetDirty = true;
        Idx = 0;
        J0x34D:

        // End:0x476 [Loop If]
        if(Idx < m_PullDataList.Length)
        {
            // End:0x468
            if(m_PullDataList[Idx].Character != none)
            {
                m_FireMode.ApplyHitSpecial(m_PullDataList[Idx].Character);
                // End:0x468
                if(NumPulledTargets < 5)
                {
                    r_PulledTargets[NumPulledTargets] = m_PullDataList[Idx].Character;
                    r_PulledTargetLocations[NumPulledTargets] = m_PullDataList[Idx].TargetLocation;
                    NumPulledTargets++;
                }
            }
            Idx++;
            // [Loop Continue]
            goto J0x34D;
        }
        ApplyForcedView();
        // End:0x4B3
        if(int(WorldInfo.NetMode) == int(NM_Standalone))
        {
            CreateBeams();
        }
        SetTimer(GetPullDelay(), false, 'StartPull');
    }
    //return;    
}

function StartPull()
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0xCD [Loop If]
    if(Idx < m_PullDataList.Length)
    {
        // End:0xBF
        if(m_PullDataList[Idx].Character != none)
        {
            m_PullDataList[Idx].Character.StartPhysTween(m_PullDataList[Idx].TargetLocation, GetPullTime(), 4, false, true);
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

// Export UTgDeploy_DarkConvergence::execDetermineTeleportLocations(FFrame&, void* const)
native simulated function DetermineTeleportLocations();

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0x8F
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && c_fHideBeamsTimer > 0.0000000)
    {
        c_fHideBeamsTimer -= DeltaSeconds;
        // End:0x85
        if(c_fHideBeamsTimer <= 0.0000000)
        {
            HideBeams();            
        }
        else
        {
            UpdateBeams();
        }
    }
    //return;    
}

defaultproperties
{
    c_fHideBeamsTimer=2.0000000
    s_fValidationRayDistance=15.0000000
    s_fValidationRayRadius=1.5000000
    s_fValidationRayHeight=6.0000000
    s_fValidationMaxFloorOffset=9.0000000
    s_fVerticalTargetLocationOffset=0.1250000
    // Reference: TgStaticMeshComponent'TgGame.Default__TgDeploy_DarkConvergence.CountdownIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CountdownIndicator'
    // Archetype: TgStaticMeshComponent'TgGame.Default__TgDeploy_Bomb.CountdownIndicator'
    begin object name="CountdownIndicator"
        ReplacementPrimitive=none
    end object
    m_CountdownIndicator=CountdownIndicator
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_DARK_CONVERGENCE
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_DarkConvergence.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Bomb.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=3072
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_DarkConvergence.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgDeploy_Bomb.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[1]=CollisionCylinder
    Components[2]=CountdownIndicator
    CollisionComponent=CollisionCylinder
}