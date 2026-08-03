class TgChaosCapturePoint extends TgObjective
    native(Game)
    placeable
    hidecategories(Navigation);

const TG_UNCONTESTED = 0;
const TG_TEAM1_CAPTURING = 1;
const TG_TEAM2_CAPTURING = 2;
const TG_CONTESTED = 3;
const TG_CAPTUREPOINT_FOGHORN_FX_ID = 6694;

var() int m_nDisplayNameId;
var() int r_nUniqueCapturePointId;
var() int m_nLaneNumber;
var() int m_nTaskForce;
var() array<TgBotFactory_Minions> m_Taskforce1Factories;
var() array<TgBotFactory_Minions> m_Taskforce2Factories;
var() TgBotFactory_Minions m_GuardianFactory;
var() TgSplineActor m_Taskforce1PathStart;
var() TgSplineActor m_Taskforce2PathStart;
var() array<PlayerStart> m_PlayerBaseSpawnPoints;
var() array<PlayerStart> m_PlayerRespawnPoints;
var transient TgAnimNodeSlot m_CustomAnimNode;
var int c_MICStatus;
var bool c_bConfusedRendering;
var repnotify bool r_bFogActive;
var(Survival) const bool m_bForceSurvival;
var bool m_bAnnouncedDeathFog;
var bool m_bContested;
var bool m_bContestedThisTick;
var transient float m_fLastEnemyCapturingPointMessageTime;
var float m_fMinEnemyCapturingPointMessageTime;
var TgHelpTipActor m_HelpTip;
var float r_fCapturedPct;
var int c_DominationOuterMIC;
var int c_DominationInnerMIC;
var(capturePoint) array<TgStaticMeshActor_CapturePoint> CapturePointMeshActors;
var(capturePoint) array<Volume> m_Volumes;
var(capturePoint) int m_nCapturePriority;
var(capturePoint) Vector m_vIndicatorOffset;
var(Survival) const Class<TgSurvivalFogVolumeDensityInfo> m_TgSurvivalFogVolumeDensityInfoClass;
var TgSurvivalFogVolumeDensityInfo m_ConvergeFog;
var repnotify int r_nFogAboutToBeActive;
var(Survival) float m_fFogFadeInTotalTime;
var int m_nNumTF1OnPoint;
var int m_nNumTF2OnPoint;
var float m_fTF1TouchedPointTimer;
var float m_fTF2TouchedPointTimer;
var array<TgPawn_Character> m_TouchingChampions;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bFogActive, r_fCapturedPct, 
        r_nFogAboutToBeActive, r_nUniqueCapturePointId;
}

// Export UTgChaosCapturePoint::execPlayEnemyCapturingEmote(FFrame&, void* const)
native function PlayEnemyCapturingEmote(TgRepInfo_TaskForce Taskforce);

// Export UTgChaosCapturePoint::execAnnounceFogOfDeath(FFrame&, void* const)
native function AnnounceFogOfDeath();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x19
    if(VarName == 'r_nFogAboutToBeActive')
    {
        return;
    }
    // End:0x3C
    if(VarName == 'r_bFogActive')
    {
        UpdateFogStatus();
        return;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event PreBeginPlay()
{
    local int I;

    // End:0x88
    if(int(Role) == int(ROLE_Authority))
    {
        I = 0;
        J0x1F:

        // End:0x88 [Loop If]
        if(I < m_Volumes.Length)
        {
            // End:0x7A
            if(m_Volumes[I] != none)
            {
                m_Volumes[I].AssociatedActor = self;
            }
            I++;
            // [Loop Continue]
            goto J0x1F;
        }
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local TgRepInfo_Game GRI;

    // End:0x74
    if(int(Role) == int(ROLE_Authority))
    {
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x74
        if(GRI != none)
        {
            GRI.AddCapturePoint(self);
        }
    }
    //return;    
}

simulated event Tick(float DeltaTime)
{
    local TgRepInfo_Game GRI;
    local TgGame_PaladinsExtended Game;
    local TgRepInfo_TaskForce Taskforce;
    local TgPlayerController TgPC;
    local int localTaskForceID;
    local bool bLocalPlayerConfused;
    local int nCapturePointStatus;
    local float fCapturePercent;
    local TgStaticMeshActor_CapturePoint CPActor;
    local TgChaosCapturePoint_ParticleStorm pstorm;

    localTaskForceID = 0;
    switch(r_eStatus)
    {
        // End:0x61A
        case 1:
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x617
            if(GRI != none)
            {
                // End:0x1AD
                if((r_bFogActive && m_ConvergeFog != none) && m_ConvergeFog.m_fTargetStartDistance != GRI.r_fConvergeDistance)
                {
                    m_ConvergeFog.ConvergeFog(GRI.r_fConvergeDistance, GRI.r_fFogConvergeInterval);
                    pstorm = TgChaosCapturePoint_ParticleStorm(self);
                    // End:0x1AD
                    if((!m_bAnnouncedDeathFog && pstorm != none) && GRI.r_fConvergeDistance <= pstorm.m_fFogMapDistance)
                    {
                        m_bAnnouncedDeathFog = true;
                        AnnounceFogOfDeath();
                    }
                }
                TgPC = TgPlayerController(GetALocalPlayerController());
                bLocalPlayerConfused = false;
                // End:0x215
                if((TgPC != none) && TgPC.IsConfused())
                {
                    bLocalPlayerConfused = true;
                }
                fCapturePercent = 0.0000000;
                // End:0x34C
                if((int(r_nControllingTaskForceIndex) == 1) || int(r_nControllingTaskForceIndex) == 2)
                {
                    Taskforce = GRI.GetTaskForce(int(r_nControllingTaskForceIndex));
                    // End:0x2BC
                    if(Taskforce != none)
                    {
                        fCapturePercent = Taskforce.r_fSecondaryScore / 100.0000000;
                    }
                    // End:0x34C
                    if(c_MICStatus != int(r_nControllingTaskForceIndex))
                    {
                        // End:0x34C
                        if((m_fLastEnemyCapturingPointMessageTime + m_fMinEnemyCapturingPointMessageTime) < WorldInfo.TimeSeconds)
                        {
                            PlayEnemyCapturingEmote(GRI.GetTaskForce(((int(r_nControllingTaskForceIndex) == 1) ? 2 : 1)));
                        }
                    }
                }
                c_MICStatus = int(r_nControllingTaskForceIndex);
                c_bConfusedRendering = bLocalPlayerConfused;
                // End:0x3AE
                if(TgPC != none)
                {
                    localTaskForceID = TgPC.GetTaskForceNumber();
                }
                // End:0x3CD
                if(int(r_nControllingTaskForceIndex) == 0)
                {
                    nCapturePointStatus = 0;                    
                }
                else
                {
                    // End:0x405
                    if((int(r_nControllingTaskForceIndex) == localTaskForceID) && !c_bConfusedRendering)
                    {
                        nCapturePointStatus = 1;                        
                    }
                    else
                    {
                        nCapturePointStatus = 2;
                    }
                }
                // End:0x45A
                foreach CapturePointMeshActors(CPActor)
                {
                    CPActor.SetCaptureStatus(nCapturePointStatus, fCapturePercent);                    
                }                
                // End:0x617
                if(int(Role) == int(ROLE_Authority))
                {
                    Game = TgGame_PaladinsExtended(WorldInfo.Game);
                    // End:0x617
                    if(Game != none)
                    {
                        // End:0x4E9
                        if(m_nNumTF1OnPoint > 0)
                        {
                            m_fTF1TouchedPointTimer = Game.m_fPointClaimDuration;                            
                        }
                        else
                        {
                            // End:0x510
                            if(m_fTF1TouchedPointTimer > 0.0000000)
                            {
                                m_fTF1TouchedPointTimer -= DeltaTime;
                            }
                        }
                        // End:0x54A
                        if(m_nNumTF2OnPoint > 0)
                        {
                            m_fTF2TouchedPointTimer = Game.m_fPointClaimDuration;                            
                        }
                        else
                        {
                            // End:0x571
                            if(m_fTF2TouchedPointTimer > 0.0000000)
                            {
                                m_fTF2TouchedPointTimer -= DeltaTime;
                            }
                        }
                        // End:0x617
                        if(Game.m_bPointCaptureOvertime)
                        {
                            // End:0x5D5
                            if(int(r_nControllingTaskForceIndex) == int(1))
                            {
                                // End:0x5D5
                                if(m_nNumTF2OnPoint > 0)
                                {
                                    Game.RestartPointOvertime();
                                }
                            }
                            // End:0x617
                            if(int(r_nControllingTaskForceIndex) == int(2))
                            {
                                // End:0x617
                                if(m_nNumTF1OnPoint > 0)
                                {
                                    Game.RestartPointOvertime();
                                }
                            }
                        }
                    }
                }
            }
            // End:0x65E
            break;
        // End:0xFFFF
        default:
            // End:0x65A
            foreach CapturePointMeshActors(CPActor)
            {
                CPActor.SetCaptureStatus(0, 0.0000000);                
            }            
            // End:0x65E
            break;
            break;
    }
    //return;    
}

simulated event OnSetStatus()
{
    local TgPawn_Character TgP;
    local float ActivationRate;
    local int I;

    super.OnSetStatus();
    // End:0x1CE
    if(int(Role) == int(ROLE_Authority))
    {
        switch(r_eStatus)
        {
            // End:0xC1
            case 0:
                I = 0;
                J0x41:

                // End:0xB3 [Loop If]
                if(I < m_TouchingChampions.Length)
                {
                    TgP = m_TouchingChampions[I];
                    // End:0xA5
                    if(TgP != none)
                    {
                        TgP.PawnOnLeaveCapturePoint(self);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x41;
                }
                SetFogActive(false);
                // End:0x1CE
                break;
            // End:0x146
            case 1:
                I = 0;
                J0xD1:

                // End:0x143 [Loop If]
                if(I < m_TouchingChampions.Length)
                {
                    TgP = m_TouchingChampions[I];
                    // End:0x135
                    if(TgP != none)
                    {
                        TgP.PawnOnEnterCapturePoint(self);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0xD1;
                }
                // End:0x1CE
                break;
            // End:0x1CB
            case 2:
                I = 0;
                J0x156:

                // End:0x1C8 [Loop If]
                if(I < m_TouchingChampions.Length)
                {
                    TgP = m_TouchingChampions[I];
                    // End:0x1BA
                    if(TgP != none)
                    {
                        TgP.PawnOnLeaveCapturePoint(self);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x156;
                }
                // End:0x1CE
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        // End:0x3E2
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            switch(r_eStatus)
            {
                // End:0x2C9
                case 0:
                    // End:0x281
                    if((m_CustomAnimNode != none) && m_CustomAnimNode.bIsPlayingCustomAnim)
                    {
                        m_CustomAnimNode.PlayCustomAnim('Trans_Active_To_Inactive', 1.0000000, 0.0000000, -1.0000000, false, true, 0.0000000);
                    }
                    // End:0x2BB
                    if(m_HelpTip != none)
                    {
                        m_HelpTip.Remove(true);
                        m_HelpTip = none;
                    }
                    ShowPathfinder(false);
                    // End:0x3E2
                    break;
                // End:0x2E6
                case 1:
                    SpawnHelpTip();
                    ShowPathfinder(true);
                    // End:0x3E2
                    break;
                // End:0x3DF
                case 2:
                    SpawnHelpTip();
                    // End:0x3DC
                    if(m_CustomAnimNode != none)
                    {
                        // End:0x3A1
                        if(Class'TgGame.TgGame_PaladinsExtended'.default.m_fObjectiveActivationTime > 0.0000000)
                        {
                            ActivationRate = 1.0000000 / Class'TgGame.TgGame_PaladinsExtended'.default.m_fObjectiveActivationTime;
                            m_CustomAnimNode.PlayCustomAnim('Trans_Inactive_To_Active', ActivationRate, 0.0000000, -1.0000000, false, true, 0.0000000);                            
                        }
                        else
                        {
                            m_CustomAnimNode.PlayCustomAnim('Idle_Active', 1.0000000, 0.0000000, -1.0000000, false, true);
                        }
                    }
                    // End:0x3E2
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
            //return;            
        }
    }
}

simulated function UpdateFogStatus()
{
    local TgRepInfo_Game GRI;

    // End:0x183
    if(r_bFogActive)
    {
        PlayFogHorn();
        // End:0xB5
        if((m_ConvergeFog == none) && m_TgSurvivalFogVolumeDensityInfoClass != none)
        {
            m_ConvergeFog = Spawn(m_TgSurvivalFogVolumeDensityInfoClass, self,, Location,,, true);
            // End:0xB5
            if((m_ConvergeFog != none) && m_fFogFadeInTotalTime > 0.0000000)
            {
                m_ConvergeFog.m_fFadeInRate = 1.0000000 / m_fFogFadeInTotalTime;
            }
        }
        // End:0x180
        if(m_ConvergeFog != none)
        {
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x160
            if(GRI != none)
            {
                m_ConvergeFog.ConvergeFog(GRI.r_fConvergeDistance, GRI.r_fFogConvergeInterval);
            }
            m_ConvergeFog.ToggleFog(true);
        }        
    }
    else
    {
        // End:0x1B2
        if(m_ConvergeFog != none)
        {
            m_ConvergeFog.ToggleFog(false);
        }
    }
    //return;    
}

simulated function PlayFogHorn()
{
    local TgPlayerController TgPC;
    local TgSpecialFx Fx;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x218
    if(TgPC != none)
    {
        m_bAnnouncedDeathFog = false;
        // End:0x96
        if(TgPC.c_GameTipManager != none)
        {
            TgPC.c_GameTipManager.RequestHelpText(125);
        }
        Fx = Class'TgGame.TgPawn'.static.GetSpecialFx(6694);
        // End:0x218
        if((Fx != none) && Fx.c_SoundList.Length > 0)
        {
            // End:0x188
            if(Fx.c_SoundList[0].c_AkEvent != none)
            {
                TgPC.PostAkEvent(Fx.c_SoundList[0].c_AkEvent);                
            }
            else
            {
                // End:0x218
                if(Fx.c_SoundList[0].c_SoundObject != none)
                {
                    TgPC.PlaySoundBase(Fx.c_SoundList[0].c_SoundObject);
                }
            }
        }
    }
    //return;    
}

simulated function ShowPathfinder(bool bEnabled)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0xE3
    if((TgPC != none) && (TgPC.c_bEnablePathfinderGuide && TgPC.m_fPathfinderEnabled) || !bEnabled)
    {
        TgPC.ShowPathfinder(bEnabled, 5.0000000);
        // End:0xE3
        if(!bEnabled)
        {
            TgPC.m_fPathfinderEnabled = false;
        }
    }
    //return;    
}

simulated function SpawnHelpTip()
{
    local TgPlayerController TgPC;
    local Vector SpawnLoc, HitLocation, HitNormal, TraceEnd;

    // End:0x11
    if(m_HelpTip != none)
    {
        return;
    }
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x13A
    if((TgPC != none) && TgPC.c_GameTipManager != none)
    {
        SpawnLoc = Location;
        TraceEnd = Location;
        TraceEnd.Z -= 300.0000000;
        // End:0xF0
        if(Trace(HitLocation, HitNormal, TraceEnd, SpawnLoc) != none)
        {
            SpawnLoc = HitLocation;
        }
        TgPC.c_GameTipManager.RequestHelpText(99,,, SpawnLoc, m_HelpTip);
    }
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn_Character TgP;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    TgP = TgPawn_Character(Other);
    // End:0x14A
    if(TgP != none)
    {
        // End:0xB7
        if(TgP.IsGod() && !TgP.IsGodDecoy())
        {
            m_TouchingChampions.AddItem(TgP);
        }
        TgP.PawnOnEnterCapturePoint(self);
        // End:0x14A
        if(!TgP.IsA('TgPawn_Illusion'))
        {
            ((int(TgP.GetTaskForceNumber()) == int(1)) ? m_nNumTF1OnPoint++ : m_nNumTF2OnPoint++);
            m_bContestedThisTick = true;
        }
    }
    //return;    
}

event UnTouch(Actor Other)
{
    local TgPawn_Character TgP;

    super(Actor).UnTouch(Other);
    TgP = TgPawn_Character(Other);
    // End:0x123
    if(TgP != none)
    {
        // End:0x9C
        if(TgP.IsGod() && !TgP.IsGodDecoy())
        {
            m_TouchingChampions.RemoveItem(TgP);
        }
        TgP.PawnOnLeaveCapturePoint(self);
        // End:0x123
        if(!TgP.IsA('TgPawn_Illusion'))
        {
            ((int(TgP.GetTaskForceNumber()) == int(1)) ? m_nNumTF1OnPoint-- : m_nNumTF2OnPoint--);
        }
    }
    //return;    
}

function UpdateOccupationStatus()
{
    local TgRepInfo_Game GRI;
    local TgGame_PaladinsExtended Game;
    local bool bContested, bCalculatePointCapture;
    local TgRepInfo_TaskForce attackingTaskForce;
    local byte oldContested;

    r_nControllingTaskForceIndex = 0;
    oldContested = r_nContestingTaskForceIndex;
    r_nContestingTaskForceIndex = 0;
    // End:0x41
    if(int(r_eStatus) != int(1))
    {
        return;
    }
    bContested = ((m_nNumTF1OnPoint > 0) && m_nNumTF2OnPoint > 0) || m_bContestedThisTick;
    // End:0xA6
    if(!(m_nNumTF1OnPoint > 0) && m_nNumTF2OnPoint > 0)
    {
        m_bContestedThisTick = false;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x53C
    if(GRI != none)
    {
        GRI.r_CapturingTaskForce = none;
        Game = TgGame_PaladinsExtended(WorldInfo.Game);
        // End:0x178
        if(Game != none)
        {
            Game.UpdateOccupationStatus(self, m_nNumTF1OnPoint, m_nNumTF2OnPoint);
        }
        // End:0x344
        if(int(GRI.r_GameMode) == int(2))
        {
            attackingTaskForce = GRI.GetAttackingTaskForce();
            // End:0x341
            if(((m_nNumTF1OnPoint > 0) || m_nNumTF2OnPoint > 0) && attackingTaskForce != none)
            {
                // End:0x284
                if((m_nNumTF1OnPoint > 0) && int(attackingTaskForce.r_nTaskForce) == int(1))
                {
                    r_nControllingTaskForceIndex = 1;
                    r_nContestingTaskForceIndex = 1;
                    Game.CheckAwardObjectiveScore(1, self, m_nNumTF1OnPoint, m_nNumTF2OnPoint);                    
                }
                else
                {
                    // End:0x30D
                    if((m_nNumTF2OnPoint > 0) && int(attackingTaskForce.r_nTaskForce) == int(2))
                    {
                        r_nControllingTaskForceIndex = 2;
                        r_nContestingTaskForceIndex = 2;
                        Game.CheckAwardObjectiveScore(2, self, m_nNumTF2OnPoint, m_nNumTF1OnPoint);                        
                    }
                    else
                    {
                        Game.CheckAwardObjectiveScore(0, self, m_nNumTF2OnPoint, m_nNumTF1OnPoint);
                    }
                }
            }            
        }
        else
        {
            bCalculatePointCapture = true;
            // End:0x3C7
            if(int(GRI.r_GameMode) == int(1))
            {
                // End:0x3BB
                if((Game != none) && Game.m_bCanCaptureDuringSurvival)
                {
                    bCalculatePointCapture = true;                    
                }
                else
                {
                    bCalculatePointCapture = false;
                }
            }
            // End:0x53C
            if(bCalculatePointCapture)
            {
                // End:0x45F
                if(m_nNumTF1OnPoint > 0)
                {
                    // End:0x40A
                    if(!bContested)
                    {
                        r_nControllingTaskForceIndex = 1;
                        r_nContestingTaskForceIndex = 1;
                    }
                    TgGame_PaladinsExtended(WorldInfo.Game).CheckAwardObjectiveScore(1, self, m_nNumTF1OnPoint, m_nNumTF2OnPoint);                    
                }
                else
                {
                    // End:0x4EA
                    if(m_nNumTF2OnPoint > 0)
                    {
                        // End:0x495
                        if(!bContested)
                        {
                            r_nControllingTaskForceIndex = 2;
                            r_nContestingTaskForceIndex = 2;
                        }
                        TgGame_PaladinsExtended(WorldInfo.Game).CheckAwardObjectiveScore(2, self, m_nNumTF2OnPoint, m_nNumTF1OnPoint);                        
                    }
                    else
                    {
                        TgGame_PaladinsExtended(WorldInfo.Game).CheckAwardObjectiveScore(0, self, m_nNumTF2OnPoint, m_nNumTF1OnPoint);
                    }
                }
            }
        }
    }
    // End:0x555
    if(bContested)
    {
        r_nContestingTaskForceIndex = 3;
    }
    // End:0x5A5
    if((int(WorldInfo.NetMode) == int(NM_Standalone)) && int(oldContested) != int(r_nContestingTaskForceIndex))
    {
        OnContestedStatusChanged();
    }
    //return;    
}

simulated event int GetControllingPlayerCount()
{
    local int ReturnCount;
    local TgPawn_Character TgP;

    ReturnCount = 0;
    // End:0xBC
    if(int(r_nControllingTaskForceIndex) != 0)
    {
        // End:0xBB
        foreach TouchingActors(Class'TgGame.TgPawn_Character', TgP)
        {
            // End:0xBA
            if(((int(TgP.GetTaskForceNumber()) == int(r_nControllingTaskForceIndex)) && TgP.IsGod()) && !TgP.IsGodDecoy())
            {
                ReturnCount++;
            }            
        }        
    }
    return ReturnCount;
    //return ReturnValue;    
}

simulated function SetFogActive(bool bEnabled)
{
    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bFogActive = bEnabled;
    }
    // End:0x5C
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        UpdateFogStatus();
    }
    //return;    
}

simulated event Destroyed()
{
    super(Actor).Destroyed();
    // End:0x3C
    if(m_ConvergeFog != none)
    {
        m_ConvergeFog.Destroy();
        m_ConvergeFog = none;
    }
    //return;    
}

defaultproperties
{
    m_fMinEnemyCapturingPointMessageTime=150.0000000
    m_vIndicatorOffset=(X=0.0000000,Y=0.0000000,Z=100.0000000)
    m_TgSurvivalFogVolumeDensityInfoClass=Class'TgGame.TgSurvivalFogVolumeDensityInfo'
    m_fFogFadeInTotalTime=5.0000000
    Components[0]=none
    Components[1]=none
    // Reference: CylinderComponent'TgGame.Default__TgChaosCapturePoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=150.0000000
        CollisionRadius=400.0000000
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[2]=CollisionCylinder
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgChaosCapturePoint.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
    end object
    Components[3]=MyLightEnvironment
    bCollideActors=true
    CollisionComponent=CollisionCylinder
}