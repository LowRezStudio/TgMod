class GameCrowdAgent extends CrowdAgentBase
    abstract
    native
    hidecategories(Navigation,Advanced,Attachment,Collision,Object)
    implements(Interface_RVO);

enum EConformType
{
    CFM_NavMesh,                    // 0
    CFM_BSP,                        // 1
    CFM_World,                      // 2
    CFM_None,                       // 3
    CFM_MAX                         // 4
};

struct native AvoidOtherSampleItem
{
    var() int RotOffset;
    var() byte NumMagSamples;
    var() bool bFallbackOnly;

    structdefaultproperties
    {
        RotOffset=0
        NumMagSamples=0
        bFallbackOnly=false
    }
};

struct native RecentInteraction
{
    var name InteractionTag;
    var float InteractionDelay;

    structdefaultproperties
    {
        InteractionTag="None"
        InteractionDelay=0.0000000
    }
};

struct native BehaviorEntry
{
    var() GameCrowdAgentBehavior BehaviorArchetype;
    var() Actor LookAtActor;
    var() float BehaviorFrequency;
    var() bool bNeverRepeat;
    var bool bHasBeenUsed;
    var bool bCanBeUsed;

    structdefaultproperties
    {
        BehaviorArchetype=none
        LookAtActor=none
        BehaviorFrequency=1.0000000
        bNeverRepeat=false
        bHasBeenUsed=false
        bCanBeUsed=false
    }
};

var private native const noexport Pointer VfTable_IInterface_RVO;
var GameCrowdGroup MyGroup;
var Vector PreferredVelocity;
var Vector PendingVelocity;
var GameCrowdDestination CurrentDestination;
var GameCrowdDestination BehaviorDestination;
var GameCrowdDestination PreviousDestination;
var float InterpZTranslation;
var() int Health;
var(Behavior) float DeadBodyDuration;
var const editconst export editinline DynamicLightEnvironmentComponent LightEnvironment;
var transient int ConformTraceFrameCount;
var transient array<NearbyDynamicItem> NearbyDynamics;
var bool bUniformScale;
var(Pathing) bool bCheckForObstacles;
var(Pathing) bool bUseNavMeshPathing;
var bool bWantsSeePlayerNotification;
var(Movement) bool bAllowPitching;
var bool bHitObstacle;
var bool bBadHitNormal;
var bool bSimulateThisTick;
var bool bPotentialEncounter;
var bool bIsPanicked;
var bool bWantsGroupIdle;
var() bool bPreferVisibleDestination;
var() bool bPreferVisibleDestinationOnSpawn;
var bool bHasNotifiedSpawner;
var bool bIsInSpawnPool;
var(Debug) bool bPaused;
var(Movement) GameCrowdAgent.EConformType ConformType;
var(Movement) float ConformTraceDist;
var(Movement) int ConformTraceInterval;
var int CurrentConformTraceInterval;
var float LastGroundZ;
var(Pathing) float AwareRadius;
var(Pathing) float AvoidOtherRadius;
var(Pathing) array<AvoidOtherSampleItem> AvoidOtherSampleList;
var(Pathing) float PENALTY_COEFF_ANGLETOGOAL;
var(Pathing) float PENALTY_COEFF_ANGLETOVEL;
var(Pathing) float PENALTY_COEFF_MAG;
var(Pathing) float MIN_PENALTY_THRESHOLD;
var(Pathing) float LastProgressTime;
var(Pathing) float LastFallbackActiveTime;
var(Pathing) float MaxPathLaneValue;
var(Pathing) float CurrentPathLaneValue;
var(Pathing) int ExtraPathCost;
var(Movement) float RotateToTargetSpeed;
var(Movement) float MaxYawRate;
var(Rendering) Vector MeshMinScale3D;
var(Rendering) Vector MeshMaxScale3D;
var float EyeZOffset;
var(LOD) float ProximityLODDist;
var(LOD) float VisibleProximityLODDist;
var Vector LastKnownGoodPosition;
var(Rendering) float GroundOffset;
var Vector IntermediatePoint;
var Vector SearchExtent;
var Class<NavigationHandle> NavigationHandleClass;
var NavigationHandle NavigationHandle;
var int ObstacleCheckCount;
var float WalkableFloorZ;
var float LastPathingAttempt;
var float LastUpdateTime;
var(LOD) float NotVisibleLifeSpan;
var GameCrowdAgent MyArchetype;
var(Movement) float MaxWalkingSpeed;
var(Movement) float MaxRunningSpeed;
var float MaxSpeed;
var array<RecentInteraction> RecentInteractions;
var float BeaconMaxDist;
var Vector BeaconOffset;
var const Texture2D BeaconTexture;
var const LinearColor BeaconColor;
var() SoundCue AmbientSoundCue;
var export editinline AudioComponent AmbientSoundComponent;
var GameCrowdAgentBehavior CurrentBehavior;
var float CurrentBehaviorActivationTime;
var(Behavior) array<BehaviorEntry> EncounterAgentBehaviors;
var(Behavior) array<BehaviorEntry> SeePlayerBehaviors;
var float MaxSeePlayerDistSq;
var(Behavior) float SeePlayerInterval;
var(Behavior) array<BehaviorEntry> SpawnBehaviors;
var(Behavior) array<BehaviorEntry> UneasyBehaviors;
var(Behavior) array<BehaviorEntry> AlertBehaviors;
var(Behavior) array<BehaviorEntry> PanicBehaviors;
var(Behavior) array<BehaviorEntry> RandomBehaviors;
var(Behavior) array<BehaviorEntry> TakeDamageBehaviors;
var(Behavior) float RandomBehaviorInterval;
var float ForceUpdateTime;
var float ReachThreshold;
var(Behavior) array<BehaviorEntry> GroupWaitingBehaviors;
var(Behavior) float DesiredGroupRadius;
var float DesiredGroupRadiusSq;
var float MaxLOSLifeDistanceSq;
var GameCrowdSpawnerInterface MySpawner;
var Vector SpawnOffset;
var float InitialLastRenderTime;
var(Debug) Color DebugAgentColor;
var(Debug) GameCrowdDestination DebugSpawnDest;

// Export UGameCrowdAgent::execGetCollisionExtent(FFrame&, void* const)
native function Vector GetCollisionExtent();

simulated event FellOutOfWorld(Class<DamageType> dmgType)
{
    Health = -1;
    LifeSpan = -0.1000000;
    //return;    
}

// Export UGameCrowdAgent::execIsPanicked(FFrame&, void* const)
native function bool IsPanicked();

function bool PickBehaviorFrom(array<BehaviorEntry> BehaviorList, optional Vector BestCameraLoc = vect(0.0000000, 0.0000000, 0.0000000))
{
    local Vector CameraLoc;
    local Rotator CameraRot;
    local PlayerController PC;
    local float BestDistSq, NewDistSq;
    local int I;
    local float FreqSum, RandPick;

    // End:0xEA
    if(BestCameraLoc == vect(0.0000000, 0.0000000, 0.0000000))
    {
        BestDistSq = 90000000.0000000;
        // End:0xE9
        foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
        {
            PC.GetPlayerViewPoint(CameraLoc, CameraRot);
            NewDistSq = VSizeSq(CameraLoc - Location);
            // End:0xE8
            if(NewDistSq < BestDistSq)
            {
                BestDistSq = NewDistSq;
                BestCameraLoc = CameraLoc;
            }            
        }        
    }
    I = 0;
    J0xF5:

    // End:0x26F [Loop If]
    if(I < BehaviorList.Length)
    {
        // End:0x13C
        if(BehaviorList[I].BehaviorArchetype == none)
        {            
        }
        else
        {
            BehaviorList[I].bCanBeUsed = (!BehaviorList[I].bHasBeenUsed || !BehaviorList[I].bNeverRepeat) && BehaviorList[I].BehaviorArchetype.CanBeUsedBy(self, BestCameraLoc);
            // End:0x261
            if(BehaviorList[I].bCanBeUsed)
            {
                FreqSum += BehaviorList[I].BehaviorFrequency;
            }
        }
        I++;
        // [Loop Continue]
        goto J0xF5;
    }
    RandPick = FMax(1.0000000, FreqSum) * FRand();
    // End:0x2A6
    if(RandPick >= FreqSum)
    {
        return false;
    }
    I = 0;
    J0x2B1:

    // End:0x3C6 [Loop If]
    if(I < BehaviorList.Length)
    {
        // End:0x3B8
        if(BehaviorList[I].bCanBeUsed)
        {
            RandPick -= BehaviorList[I].BehaviorFrequency;
            // End:0x3B8
            if(RandPick < 0.0000000)
            {
                ActivateBehavior(BehaviorList[I].BehaviorArchetype, BehaviorList[I].LookAtActor);
                BehaviorList[I].bHasBeenUsed = true;
                return true;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x2B1;
    }
    return false;
    //return ReturnValue;    
}

event WaitForGroupMembers()
{
    local int I;

    PickBehaviorFrom(GroupWaitingBehaviors);
    // End:0x252
    if(CurrentBehavior != none)
    {
        CurrentBehavior.ActionTarget = MyGroup.Members[0];
        I = 0;
        J0x6D:

        // End:0x252 [Loop If]
        if(I < MyGroup.Members.Length)
        {
            // End:0x244
            if((((MyGroup.Members[I] != none) && !MyGroup.Members[I].bDeleteMe) && VSizeSq(MyGroup.Members[I].Location - Location) > DesiredGroupRadiusSq) && (MyGroup.Members[I].Velocity Dot (Location - MyGroup.Members[I].Location)) > 0.0000000)
            {
                CurrentBehavior.ActionTarget = MyGroup.Members[I];
                // [Explicit Break]
                goto J0x252;
            }
            I++;
            // [Loop Continue]
            goto J0x6D;
        }
    }
    J0x252:

    //return;    
}

event SetCurrentDestination(GameCrowdDestination NewDest)
{
    // End:0xC4
    if(NewDest != CurrentDestination)
    {
        // End:0x4E
        if(CurrentBehavior != none)
        {
            CurrentBehavior.ChangingDestination(NewDest);
        }
        CurrentDestination = NewDest;
        CurrentDestination.IncrementCustomerCount(self);
        ReachThreshold = ((CurrentDestination.bSoftPerimeter) ? 0.5000000 + (0.5000000 * FRand()) : 1.0000000);
    }
    //return;    
}

function SetMaxSpeed()
{
    MaxSpeed = ((IsPanicked()) ? MaxRunningSpeed : MaxWalkingSpeed);
    //return;    
}

simulated function PostBeginPlay()
{
    local Vector AgentScale3D;
    local int I;
    local float MaxSeePlayerDist;

    super(Actor).PostBeginPlay();
    // End:0x19
    if(bDeleteMe)
    {
        return;
    }
    WorldInfo.bHaveActiveCrowd = true;
    // End:0x77
    if(bUniformScale)
    {
        AgentScale3D = MeshMinScale3D + (FRand() * (MeshMaxScale3D - MeshMinScale3D));        
    }
    else
    {
        AgentScale3D.X = RandRange(MeshMinScale3D.X, MeshMaxScale3D.X);
        AgentScale3D.Y = RandRange(MeshMinScale3D.Y, MeshMaxScale3D.Y);
        AgentScale3D.Z = RandRange(MeshMinScale3D.Z, MeshMaxScale3D.Z);
    }
    SetDrawScale3D(AgentScale3D);
    LastKnownGoodPosition = Location;
    LastKnownGoodPosition.Z += EyeZOffset;
    ForceUpdateTime = WorldInfo.TimeSeconds;
    SetMaxSpeed();
    // End:0x2A3
    if(AmbientSoundCue != none)
    {
        AmbientSoundComponent = new (self) Class'Engine.AudioComponent';
        // End:0x2A3
        if(AmbientSoundComponent != none)
        {
            AttachComponent(AmbientSoundComponent);
            AmbientSoundComponent.SoundCue = AmbientSoundCue;
            AmbientSoundComponent.Play();
        }
    }
    bWantsSeePlayerNotification = SeePlayerBehaviors.Length > 0;
    I = 0;
    J0x2C6:

    // End:0x33C [Loop If]
    if(I < SeePlayerBehaviors.Length)
    {
        MaxSeePlayerDist = FMax(MaxSeePlayerDist, SeePlayerBehaviors[I].BehaviorArchetype.MaxPlayerDistance);
        I++;
        // [Loop Continue]
        goto J0x2C6;
    }
    MaxSeePlayerDistSq = MaxSeePlayerDist * MaxSeePlayerDist;
    DesiredGroupRadiusSq = DesiredGroupRadius * DesiredGroupRadius;
    // End:0x3B1
    if(RandomBehaviors.Length > 0)
    {
        SetTimer((0.8000000 + (0.4000000 * FRand())) * RandomBehaviorInterval, true, 'TryRandomBehavior');
    }
    //return;    
}

event KillAgent()
{
    // End:0x0F
    if(bIsInSpawnPool)
    {
        return;
    }
    LifeSpan = -0.1000000;
    TimeSinceLastTick = 1000.0000000;
    //return;    
}

function ResetPooledAgent()
{
    bIsInSpawnPool = false;
    SetHidden(false);
    BehaviorDestination = none;
    PreviousDestination = none;
    LifeSpan = 0.0000000;
    Health = default.Health;
    TimeSinceLastTick = 0.0000000;
    LastKnownGoodPosition = Location;
    LastKnownGoodPosition.Z += EyeZOffset;
    ForceUpdateTime = WorldInfo.TimeSeconds;
    SetMaxSpeed();
    // End:0x103
    if(RandomBehaviors.Length > 0)
    {
        SetTimer((0.8000000 + (0.4000000 * FRand())) * RandomBehaviorInterval, true, 'TryRandomBehavior');
    }
    //return;    
}

simulated function Destroyed()
{
    super(Actor).Destroyed();
    // End:0x68
    if(NotEqual_InterfaceInterface(MySpawner, GameCrowdSpawnerInterface(none)) && !bHasNotifiedSpawner)
    {
        bHasNotifiedSpawner = true;
        MySpawner.AgentDestroyed(self);
    }
    // End:0xA2
    if(CurrentDestination != none)
    {
        CurrentDestination.DecrementCustomerCount(self);
        CurrentDestination = none;
    }
    // End:0xD1
    if(MyGroup != none)
    {
        MyGroup.RemoveMember(self);
    }
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local string T;
    local Canvas Canvas;

    super(Actor).DisplayDebug(HUD, out_YL, out_YPos);
    Canvas = HUD.Canvas;
    Canvas.SetPos(4.0000000, out_YPos);
    Canvas.SetDrawColor(255, 0, 0);
    T = GetDebugName();
    // End:0xF5
    if(bDeleteMe)
    {
        T = T $ " DELETED (bDeleteMe == true)";
    }
    // End:0x174
    if(T != "")
    {
        Canvas.DrawText(T, false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
    }
    Canvas.SetDrawColor(255, 255, 255);
    Canvas.DrawText((((((("Location:" @ string(Location)) @ "Rotation:") @ string(Rotation)) @ " Speed: ") $ string(VSize(Velocity))) @ "ZVel") @ string(Velocity.Z), false);
    out_YPos += out_YL;
    Canvas.SetPos(4.0000000, out_YPos);
    Canvas.DrawText((((("Hit obestacle:" @ string(bHitObstacle)) @ "BadHitNormal:") @ string(bBadHitNormal)) @ "count") @ string(ObstacleCheckCount), false);
    out_YPos += out_YL;
    Canvas.SetPos(4.0000000, out_YPos);
    Canvas.DrawText((((("Current conform interval:" @ string(CurrentConformTraceInterval)) @ "Base Conform Interval:") @ string(ConformTraceInterval)) @ " Last Ground Z ") @ string(LastGroundZ), false);
    out_YPos += out_YL;
    Canvas.SetPos(4.0000000, out_YPos);
    // End:0x48B
    if(CurrentDestination == none)
    {
        Canvas.DrawText("NO DESTINATION", false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);        
    }
    else
    {
        // End:0x4BC
        if(NavigationHandle != none)
        {
            NavigationHandle.DrawPathCache();
        }
        T = "DESTINATION " $ string(CurrentDestination);
        // End:0x56A
        if(MyGroup != none)
        {
            T = (T $ " Group ") $ string(MyGroup);
            DrawDebugLine(MyGroup.Members[0].Location, Location, 255, 128, 0, false);
        }
        Canvas.DrawText(T, false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
        // End:0x62B
        if(IntermediatePoint == CurrentDestination.Location)
        {
            DrawDebugLine(IntermediatePoint, Location, 0, 128, 255, false);            
        }
        else
        {
            DrawDebugLine(IntermediatePoint, Location, 0, 255, 0, false);
            DrawDebugLine(CurrentDestination.Location, Location, 255, 255, 0, false);
        }
    }
    //return;    
}

simulated function SetLighting(bool bEnableLightEnvironment, LightingChannelContainer AgentLightingChannel, bool bCastShadows)
{
    // End:0x30
    if(bEnableLightEnvironment)
    {
        LightEnvironment.SetEnabled(true);        
    }
    else
    {
        DetachComponent(LightEnvironment);
    }
    //return;    
}

simulated function Vector GetAttemptedSpawnLocation(float Pct, Vector CurPos, float CurRadius, Vector DestPos, float DestRadius)
{
    local float MaxLateralOffset, LateralOffset;
    local Vector LateralDir;

    MaxLateralOffset = CurRadius + (Pct * (DestRadius - CurRadius));
    LateralDir = Normal((CurPos - DestPos) Cross vect(0.0000000, 0.0000000, 1.0000000));
    LateralOffset = RandRange(-MaxLateralOffset, MaxLateralOffset);
    return ((Pct * DestPos) + ((1.0000000 - Pct) * CurPos)) + (LateralOffset * LateralDir);
    //return ReturnValue;    
}

simulated function InitializeAgent(Actor SpawnLoc, const out array<CrowdSpawnerPlayerInfo> PlayerInfo, GameCrowdAgent AgentTemplate, GameCrowdGroup NewGroup, float AgentWarmupTime, bool bWarmupPosition, bool bCheckWarmupVisibility)
{
    local bool bGroupDestination, bRealPreferVisible;
    local GameCrowdDestination SpawnDest;
    local float TryPct, MaxSpawnDist, DestDist, StartDist;
    local Vector TryLoc;
    local Actor HitActor;
    local Vector HitLocation, HitNormal, NearestViewLocation, YAdjust;
    local bool bVisibleTryLoc, bFoundOption;
    local int CheckCnt, MaxCheckCnt, OptionIdx;
    local array<Vector> TryOptions;
    local float SpawnDestRadius, TravelDestRadius;
    local int PlayerIdx;
    local float NearestViewDistSq, ViewDistSq;
    local bool bVisibleOption;

    MyArchetype = AgentTemplate;
    LastRenderTime = WorldInfo.TimeSeconds + (AgentWarmupTime * (0.5000000 + FRand()));
    InitialLastRenderTime = LastRenderTime;
    // End:0x103
    if(NewGroup != none)
    {
        NewGroup.AddMember(self);
        // End:0x103
        if(NewGroup.Members.Length > 1)
        {
            bGroupDestination = true;
            SetCurrentDestination(NewGroup.Members[0].CurrentDestination);
        }
    }
    // End:0xC74
    if(!bGroupDestination)
    {
        SpawnDest = GameCrowdDestination(SpawnLoc);
        // End:0xC74
        if(SpawnDest != none)
        {
            DebugSpawnDest = SpawnDest;
            SetCurrentDestination(SpawnDest);
            bRealPreferVisible = bPreferVisibleDestination;
            bPreferVisibleDestination = bPreferVisibleDestinationOnSpawn || !SpawnDest.bWillBeVisible;
            LastRenderTime = WorldInfo.TimeSeconds;
            CurrentDestination.ReachedDestination(self);
            bPreferVisibleDestination = bRealPreferVisible;
            // End:0x21F
            if(CurrentDestination == none)
            {
            }
            // End:0xC74
            if(bWarmupPosition)
            {
                PlayerIdx = 0;
                J0x237:

                // End:0x31E [Loop If]
                if(PlayerIdx < PlayerInfo.Length)
                {
                    ViewDistSq = VSizeSq(PlayerInfo[PlayerIdx].ViewLocation - SpawnDest.Location);
                    // End:0x310
                    if((NearestViewDistSq == 0.0000000) || ViewDistSq < NearestViewDistSq)
                    {
                        NearestViewDistSq = ViewDistSq;
                        NearestViewLocation = PlayerInfo[PlayerIdx].ViewLocation;
                    }
                    PlayerIdx++;
                    // [Loop Continue]
                    goto J0x237;
                }
                // End:0xAB7
                if((NewGroup == none) || NewGroup.Members.Length == 1)
                {
                    TryPct = FRand();
                    MaxSpawnDist = ((NotEqual_InterfaceInterface(MySpawner, GameCrowdSpawnerInterface(none))) ? MySpawner.GetMaxSpawnDist() : 0.0000000);
                    // End:0x563
                    if(SpawnDest.bIsBeyondSpawnDistance && NotEqual_InterfaceInterface(MySpawner, GameCrowdSpawnerInterface(none)))
                    {
                        DestDist = VSize(CurrentDestination.Location - NearestViewLocation);
                        // End:0x4B7
                        if(CurrentDestination.bIsBeyondSpawnDistance || DestDist > MaxSpawnDist)
                        {
                            TryPct = ((DestDist < VSizeSq(SpawnDest.Location - NearestViewLocation)) ? 1.0000000 : 0.0000000);                            
                        }
                        else
                        {
                            StartDist = VSize(SpawnDest.Location - NearestViewLocation);
                            // End:0x551
                            if(StartDist > DestDist)
                            {
                                TryPct = 1.0000000 - ((MaxSpawnDist - DestDist) / (StartDist - DestDist));
                                TryPct *= 0.9000000;                                
                            }
                            else
                            {
                                TryPct = 0.0000000;
                            }
                        }                        
                    }
                    else
                    {
                        // End:0x5AB
                        if(!SpawnDest.bWillBeVisible)
                        {
                            TryPct = (0.5000000 * TryPct) + 0.5000000;                            
                        }
                        else
                        {
                            TryPct *= 0.9000000;
                        }
                    }
                    SpawnDestRadius = SpawnDest.GetDestinationRadius();
                    TravelDestRadius = ((CurrentDestination != none) ? CurrentDestination.GetDestinationRadius() : SpawnDestRadius);
                    TryLoc = GetAttemptedSpawnLocation(TryPct, SpawnDest.Location, SpawnDestRadius, CurrentDestination.Location, TravelDestRadius);
                    bVisibleTryLoc = false;
                    // End:0x91D
                    if(NavigationHandle != none)
                    {
                        bFoundOption = false;
                        CheckCnt = 0;
                        MaxCheckCnt = 4;
                        J0x6D0:

                        // End:0x906 [Loop If]
                        if((CheckCnt < MaxCheckCnt) && !bFoundOption)
                        {
                            TryOptions.Length = 0;
                            NavigationHandle.GetValidPositionsForBox(TryLoc, 128.0000000, GetCollisionExtent(), false, TryOptions, 1);
                            OptionIdx = 0;
                            J0x753:

                            // End:0x86E [Loop If]
                            if(OptionIdx < TryOptions.Length)
                            {
                                bVisibleOption = false;
                                PlayerIdx = 0;
                                J0x782:

                                // End:0x825 [Loop If]
                                if(PlayerIdx < PlayerInfo.Length)
                                {
                                    HitActor = Trace(HitLocation, HitNormal, PlayerInfo[PlayerIdx].ViewLocation, TryOptions[OptionIdx], false);
                                    // End:0x817
                                    if(HitActor == none)
                                    {
                                        bVisibleOption = true;
                                        // [Explicit Break]
                                        goto J0x825;                                        
                                    }
                                    PlayerIdx++;
                                    // [Loop Continue]
                                    goto J0x782;
                                }
                                J0x825:

                                // End:0x860
                                if(!bVisibleOption)
                                {
                                    bFoundOption = true;
                                    TryLoc = TryOptions[OptionIdx];
                                    // [Explicit Break]
                                    goto J0x86E;
                                }
                                OptionIdx++;
                                // [Loop Continue]
                                goto J0x753;
                            }
                            J0x86E:

                            // End:0x903
                            if(!bFoundOption)
                            {
                                TryPct *= 0.5000000;
                                TryLoc = GetAttemptedSpawnLocation(TryPct, SpawnDest.Location, SpawnDestRadius, CurrentDestination.Location, TravelDestRadius);
                                CheckCnt++;
                            }
                            // [Loop Continue]
                            goto J0x6D0;
                        }
                        bVisibleTryLoc = !bFoundOption;
                    }
                    // End:0x9FE
                    if(!bVisibleTryLoc)
                    {
                        SpawnOffset = TryLoc;
                        SetLocation(TryLoc);
                        // End:0x9FB
                        if((SpawnDest.bWillBeVisible && CurrentDestination.bIsVisible) && FRand() < 0.5000000)
                        {
                            PreviousDestination = CurrentDestination;
                            CurrentDestination.DecrementCustomerCount(self);
                            CurrentDestination = none;
                            BehaviorDestination = none;
                            SetCurrentDestination(SpawnDest);
                        }                        
                    }
                    else
                    {
                        PlayerIdx = 0;
                        J0xA09:

                        // End:0xAB4 [Loop If]
                        if(PlayerIdx < PlayerInfo.Length)
                        {
                            HitActor = Trace(HitLocation, HitNormal, Location, PlayerInfo[PlayerIdx].ViewLocation, false);
                            // End:0xAA6
                            if(HitActor == none)
                            {
                                SetLocation(SpawnDest.Location);
                                // [Explicit Break]
                                goto J0xAB4;
                            }
                            PlayerIdx++;
                            // [Loop Continue]
                            goto J0xA09;
                        }
                    }
                    J0xAB4:
                    
                }
                else
                {
                    TryLoc = SpawnOffset;
                    TryPct = (2.0000000 * FRand()) - 1.0000000;
                    YAdjust = TryLoc + ((TryPct * AvoidOtherRadius) * Normal((CurrentDestination.Location - SpawnDest.Location) Cross vect(0.0000000, 0.0000000, 1.0000000)));
                    HitActor = Trace(HitLocation, HitNormal, YAdjust, CurrentDestination.Location, false);
                    // End:0xBCA
                    if(HitActor == none)
                    {
                        TryLoc = YAdjust;
                    }
                    HitActor = Trace(HitLocation, HitNormal, TryLoc - vect(0.0000000, 0.0000000, 250.0000000), TryLoc, false);
                    // End:0xC68
                    if(HitActor != none)
                    {
                        TryLoc.Z = (HitLocation.Z + GroundOffset) + 5.0000000;
                    }
                    SetLocation(TryLoc);
                }
            }
        }
    }
    LastKnownGoodPosition = Location;
    LastKnownGoodPosition.Z += EyeZOffset;
    // End:0xCC8
    if(SpawnBehaviors.Length > 0)
    {
        PlaySpawnBehavior();
    }
    UpdateIntermediatePoint();
    InitDebugColor();
    //return;    
}

simulated function OnPlayAgentAnimation(SeqAct_PlayAgentAnimation Action)
{
    CurrentDestination.ReachedDestination(self);
    //return;    
}

simulated event PlayIdleAnimation()
{
    //return;    
}

simulated event StopIdleAnimation()
{
    //return;    
}

event HandlePotentialAgentEncounter()
{
    // End:0x23
    if(CurrentBehavior == none)
    {
        PickBehaviorFrom(EncounterAgentBehaviors);
    }
    //return;    
}

function PlaySpawnBehavior()
{
    // End:0x23
    if(CurrentBehavior == none)
    {
        PickBehaviorFrom(SpawnBehaviors);
    }
    //return;    
}

event NotifySeePlayer(PlayerController PC)
{
    local bool bFoundBehavior;
    local int I;

    bWantsSeePlayerNotification = false;
    // End:0x11E
    if(CurrentBehavior == none)
    {
        // End:0x11E
        if(!PickBehaviorFrom(SeePlayerBehaviors, PC.Pawn.Location))
        {
            I = 0;
            J0x71:

            // End:0x100 [Loop If]
            if(I < SeePlayerBehaviors.Length)
            {
                // End:0xF2
                if(!SeePlayerBehaviors[I].bNeverRepeat || !SeePlayerBehaviors[I].bHasBeenUsed)
                {
                    bFoundBehavior = true;
                    // [Explicit Break]
                    goto J0x100;
                }
                I++;
                // [Loop Continue]
                goto J0x71;
            }
            J0x100:

            // End:0x11E
            if(!bFoundBehavior)
            {
                SeePlayerInterval = 0.0000000;
            }
        }
    }
    // End:0x15A
    if(SeePlayerInterval > 0.0000000)
    {
        SetTimer((0.8000000 + (0.4000000 * FRand())) * SeePlayerInterval, false, 'ResetSeePlayer');
    }
    //return;    
}

function TryRandomBehavior()
{
    local bool bFoundBehavior;
    local int I;

    // End:0x11A
    if((CurrentBehavior == none) && (WorldInfo.TimeSeconds - LastRenderTime) < 0.1000000)
    {
        // End:0x11A
        if(!PickBehaviorFrom(RandomBehaviors))
        {
            I = 0;
            J0x68:

            // End:0xF7 [Loop If]
            if(I < RandomBehaviors.Length)
            {
                // End:0xE9
                if(!RandomBehaviors[I].bNeverRepeat || !RandomBehaviors[I].bHasBeenUsed)
                {
                    bFoundBehavior = true;
                    // [Explicit Break]
                    goto J0xF7;
                }
                I++;
                // [Loop Continue]
                goto J0x68;
            }
            J0xF7:

            // End:0x11A
            if(!bFoundBehavior)
            {
                ClearTimer('TryRandomBehavior');
            }
        }
    }
    //return;    
}

function ResetSeePlayer()
{
    bWantsSeePlayerNotification = true;
    //return;    
}

event ActivateBehavior(GameCrowdAgentBehavior NewBehaviorArchetype, optional Actor LookAtActor)
{
    StopBehavior();
    // End:0x1C
    if(NewBehaviorArchetype == none)
    {
        return;
    }
    SetCurrentBehavior(NewBehaviorArchetype);
    // End:0x66
    if(LookAtActor != none)
    {
        CurrentBehavior.ActionTarget = LookAtActor;
    }
    // End:0x95
    if(CurrentBehavior != none)
    {
        CurrentBehavior.InitBehavior(self);
    }
    //return;    
}

function ActivateInstancedBehavior(GameCrowdAgentBehavior NewBehaviorObject)
{
    StopBehavior();
    CurrentBehavior = NewBehaviorObject;
    CurrentBehavior.InitBehavior(self);
    //return;    
}

event HandleBehaviorEvent(GameCrowdAgentBehavior.ECrowdBehaviorEvent EventType, Actor InInstigator, bool bViralCause, bool bPropagateViralFlag)
{
    local bool bActivatedBehavior;

    switch(EventType)
    {
        // End:0x3A
        case 1:
            bActivatedBehavior = PickBehaviorFrom(SpawnBehaviors);
            // End:0x175
            break;
        // End:0x61
        case 2:
            bActivatedBehavior = PickBehaviorFrom(RandomBehaviors);
            // End:0x175
            break;
        // End:0x88
        case 3:
            bActivatedBehavior = PickBehaviorFrom(SeePlayerBehaviors);
            // End:0x175
            break;
        // End:0xAF
        case 4:
            bActivatedBehavior = PickBehaviorFrom(EncounterAgentBehaviors);
            // End:0x175
            break;
        // End:0xD6
        case 5:
            bActivatedBehavior = PickBehaviorFrom(TakeDamageBehaviors);
            // End:0x175
            break;
        // End:0xFD
        case 6:
            bActivatedBehavior = PickBehaviorFrom(GroupWaitingBehaviors);
            // End:0x175
            break;
        // End:0x124
        case 7:
            bActivatedBehavior = PickBehaviorFrom(UneasyBehaviors);
            // End:0x175
            break;
        // End:0x14B
        case 8:
            bActivatedBehavior = PickBehaviorFrom(AlertBehaviors);
            // End:0x175
            break;
        // End:0x172
        case 9:
            bActivatedBehavior = PickBehaviorFrom(PanicBehaviors);
            // End:0x175
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x1F2
    if(bActivatedBehavior && CurrentBehavior != none)
    {
        // End:0x1CA
        if(bPropagateViralFlag)
        {
            CurrentBehavior.bIsViralBehavior = bViralCause;
        }
        CurrentBehavior.ActivatedBy(InInstigator);
    }
    //return;    
}

event StopBehavior()
{
    // End:0x39
    if(CurrentBehavior != none)
    {
        CurrentBehavior.StopBehavior();
        CurrentBehavior = none;
    }
    //return;    
}

// Export UGameCrowdAgent::execSetCurrentBehavior(FFrame&, void* const)
native final function SetCurrentBehavior(GameCrowdAgentBehavior BehaviorArchetype);

// Export UGameCrowdAgent::execIsIdle(FFrame&, void* const)
native function bool IsIdle();

simulated function bool CalcCamera(float fDeltaTime, out Vector out_CamLoc, out Rotator out_CamRot, out float out_FOV)
{
    local Vector HitNormal;
    local float Radius;

    Radius = 20.0000000;
    // End:0x8F
    if(Trace(out_CamLoc, HitNormal, Location - ((Vector(out_CamRot) * Radius) * float(20)), Location, false) == none)
    {
        out_CamLoc = Location - ((Vector(out_CamRot) * Radius) * float(20));
    }
    return false;
    //return ReturnValue;    
}

event UpdateIntermediatePoint(optional Actor DestinationActor)
{
    // End:0x6F
    if(DestinationActor == none)
    {
        // End:0x4B
        if(CurrentBehavior != none)
        {
            DestinationActor = CurrentBehavior.GetDestinationActor();            
        }
        else
        {
            DestinationActor = CurrentDestination;
        }
        // End:0x6F
        if(DestinationActor == none)
        {
            return;
        }
    }
    // End:0xA9
    if(!bUseNavMeshPathing)
    {
        IntermediatePoint = DestinationActor.Location;        
    }
    else
    {
        IntermediatePoint = GeneratePathToActor(DestinationActor);
        // End:0x10B
        if(IntermediatePoint == vect(0.0000000, 0.0000000, 0.0000000))
        {
            IntermediatePoint = DestinationActor.Location;
        }
    }
    //return;    
}

// Export UGameCrowdAgent::execPlayDeath(FFrame&, void* const)
native function PlayDeath(Vector KillMomentum);

simulated event FireDeathEvent()
{
    TriggerEventClass(Class'Engine.SeqEvent_Death', self);
    //return;    
}

function TakeDamage(int DamageAmount, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    // End:0xD3
    if(Health > 0)
    {
        Health -= DamageAmount;
        // End:0xB0
        if(Health <= 0)
        {
            Health = -1;
            SetCollision(false, false, false);
            PlayDeath((Normal(Momentum) * DamageType.default.KDamageImpulse) + (vect(0.0000000, 0.0000000, 1.0000000) * DamageType.default.KDeathUpKick));            
        }
        else
        {
            // End:0xD3
            if(CurrentBehavior == none)
            {
                PickBehaviorFrom(TakeDamageBehaviors);
            }
        }
    }
    //return;    
}

event OverlappedActorEvent(Actor A)
{
    //return;    
}

event InitNavigationHandle()
{
    // End:0x27
    if(NavigationHandleClass != none)
    {
        NavigationHandle = new (self) NavigationHandleClass;
    }
    //return;    
}

event Vector GeneratePathToActor(Actor Goal, optional float WithinDistance, optional bool bAllowPartialPath)
{
    local Vector NextDest;

    LastPathingAttempt = WorldInfo.TimeSeconds;
    NextDest = Goal.Location;
    // End:0x6B
    if(NavigationHandle == none)
    {
        InitNavigationHandle();
    }
    // End:0x1A6
    if((NavigationHandle != none) && !NavigationHandle.ActorReachable(Goal))
    {
        Class'Engine.NavMeshPath_Toward'.static.TowardGoal(NavigationHandle, Goal);
        Class'Engine.NavMeshGoal_At'.static.AtActor(NavigationHandle, Goal, WithinDistance, bAllowPartialPath);
        // End:0x187
        if(NavigationHandle.FindPath())
        {
            NavigationHandle.GetNextMoveLocation(NextDest, SearchExtent.X);
        }
        NavigationHandle.ClearConstraints();
    }
    return NextDest;
    //return ReturnValue;    
}

// Export UGameCrowdAgent::execNativePostRenderFor(FFrame&, void* const)
native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir);

simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local float NameXL, TextXL, BehavXL, TextYL, YL, XL;

    local Vector ScreenLoc;
    local string ScreenName, DestString, BehaviorString;
    local FontRenderInfo FontInfo;

    ScreenLoc = Canvas.Project(Location + BeaconOffset);
    // End:0x10B
    if((((ScreenLoc.X < float(0)) || ScreenLoc.X >= Canvas.ClipX) || ScreenLoc.Y < float(0)) || ScreenLoc.Y >= Canvas.ClipY)
    {
        return;
    }
    ScreenName = "Agent" @ string(self);
    // End:0x1AA
    if(MyGroup != none)
    {
        ScreenName = (ScreenName $ " Group ") $ string(MyGroup);
        DrawDebugLine(MyGroup.Members[0].Location, Location, 255, 0, 255, false);
    }
    ScreenName = (ScreenName @ "Last Rendered") @ string(WorldInfo.TimeSeconds - LastRenderTime);
    Canvas.StrLen(ScreenName, NameXL, TextYL);
    XL = FMax(XL, NameXL);
    YL += TextYL;
    DestString = GetDestString();
    Canvas.StrLen(DestString, TextXL, TextYL);
    XL = FMax(XL, TextXL);
    YL += TextYL;
    BehaviorString = GetBehaviorString();
    Canvas.StrLen(BehaviorString, BehavXL, TextYL);
    XL = FMax(XL, BehavXL);
    YL += TextYL;
    Canvas.SetPos(ScreenLoc.X - (0.7000000 * XL), ScreenLoc.Y - (1.8000000 * YL));
    Canvas.DrawTile(BeaconTexture, 1.4000000 * XL, 1.2000000 * YL, 0.0000000, 0.0000000, 31.0000000, 31.0000000, BeaconColor);
    Canvas.DrawColor = Class'Engine.HUD'.default.GreenColor;
    Canvas.SetPos(ScreenLoc.X - (0.5000000 * NameXL), ScreenLoc.Y - (1.7000000 * YL));
    FontInfo.bClipText = true;
    Canvas.DrawText(ScreenName, true,,, FontInfo);
    Canvas.SetPos(ScreenLoc.X - (0.5000000 * TextXL), (ScreenLoc.Y - (1.7000000 * YL)) + (1.1000000 * TextYL));
    FontInfo.bClipText = true;
    Canvas.DrawText(DestString, true,,, FontInfo);
    Canvas.SetPos(ScreenLoc.X - (0.5000000 * BehavXL), (ScreenLoc.Y - (1.7000000 * YL)) + (2.2000000 * TextYL));
    FontInfo.bClipText = true;
    Canvas.DrawText(BehaviorString, true,,, FontInfo);
    // End:0x763
    if(CurrentDestination != none)
    {
        DrawDebugLine(Location, CurrentDestination.Location, 255, 255, 0, false);
    }
    //return;    
}

function string GetDestString()
{
    local string DestString;

    DestString = ((CurrentDestination == none) ? "NO DESTINATION" : "" $ string(CurrentDestination));
    // End:0xC7
    if(IsIdle())
    {
        DestString = (((CurrentDestination != none) && CurrentDestination.ReachedByAgent(self, Location, true)) ? "Idle at " $ DestString : "Idle en route to " $ DestString);        
    }
    else
    {
        DestString = "Moving to " $ DestString;
    }
    return DestString;
    //return ReturnValue;    
}

function string GetBehaviorString()
{
    local string BehaviorString;

    // End:0x3B
    if(CurrentBehavior != none)
    {
        BehaviorString = CurrentBehavior.GetBehaviorString();        
    }
    else
    {
        BehaviorString = "Moving between Destinations";
    }
    return BehaviorString;
    //return ReturnValue;    
}

simulated function InitDebugColor()
{
    DebugAgentColor.G = byte(int(50) + Rand(205));
    //return;    
}

defaultproperties
{
    Health=100
    DeadBodyDuration=10.0000000
    // Reference: DynamicLightEnvironmentComponent'GameFramework.Default__GameCrowdAgent.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        MinTimeBetweenFullUpdates=2.0000000
        bEnabled=false
    end object
    LightEnvironment=MyLightEnvironment
    bUniformScale=true
    bUseNavMeshPathing=true
    bPreferVisibleDestinationOnSpawn=true
    ConformTraceDist=35.0000000
    ConformTraceInterval=10
    CurrentConformTraceInterval=10
    AwareRadius=256.0000000
    AvoidOtherRadius=32.0000000
    AvoidOtherSampleList[0]=(RotOffset=0,NumMagSamples=10,bFallbackOnly=false)
    AvoidOtherSampleList[1]=(RotOffset=2048,NumMagSamples=8,bFallbackOnly=false)
    AvoidOtherSampleList[2]=(RotOffset=-2048,NumMagSamples=8,bFallbackOnly=false)
    AvoidOtherSampleList[3]=(RotOffset=4096,NumMagSamples=6,bFallbackOnly=false)
    AvoidOtherSampleList[4]=(RotOffset=-4096,NumMagSamples=6,bFallbackOnly=false)
    AvoidOtherSampleList[5]=(RotOffset=6144,NumMagSamples=4,bFallbackOnly=false)
    AvoidOtherSampleList[6]=(RotOffset=-6144,NumMagSamples=4,bFallbackOnly=false)
    AvoidOtherSampleList[7]=(RotOffset=8192,NumMagSamples=4,bFallbackOnly=false)
    AvoidOtherSampleList[8]=(RotOffset=-8192,NumMagSamples=4,bFallbackOnly=false)
    AvoidOtherSampleList[9]=(RotOffset=12288,NumMagSamples=2,bFallbackOnly=false)
    AvoidOtherSampleList[10]=(RotOffset=-12288,NumMagSamples=2,bFallbackOnly=false)
    AvoidOtherSampleList[11]=(RotOffset=16384,NumMagSamples=1,bFallbackOnly=true)
    AvoidOtherSampleList[12]=(RotOffset=-16384,NumMagSamples=1,bFallbackOnly=true)
    AvoidOtherSampleList[13]=(RotOffset=24576,NumMagSamples=1,bFallbackOnly=true)
    AvoidOtherSampleList[14]=(RotOffset=-24576,NumMagSamples=1,bFallbackOnly=true)
    AvoidOtherSampleList[15]=(RotOffset=32768,NumMagSamples=1,bFallbackOnly=true)
    PENALTY_COEFF_ANGLETOGOAL=2.5000000
    PENALTY_COEFF_ANGLETOVEL=1.0000000
    PENALTY_COEFF_MAG=1.0000000
    MIN_PENALTY_THRESHOLD=0.0500000
    MaxPathLaneValue=10.0000000
    ExtraPathCost=50
    RotateToTargetSpeed=30000.0000000
    MaxYawRate=40000.0000000
    MeshMinScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    MeshMaxScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    EyeZOffset=40.0000000
    ProximityLODDist=2000.0000000
    VisibleProximityLODDist=5000.0000000
    GroundOffset=86.0000000
    SearchExtent=(X=32.0000000,Y=32.0000000,Z=86.0000000)
    NavigationHandleClass=Class'Engine.NavigationHandle'
    WalkableFloorZ=0.7000000
    NotVisibleLifeSpan=10.0000000
    MaxWalkingSpeed=100.0000000
    MaxRunningSpeed=300.0000000
    BeaconMaxDist=1500.0000000
    BeaconOffset=(X=0.0000000,Y=0.0000000,Z=140.0000000)
    BeaconTexture=Texture2D'EngineResources.WhiteSquareTexture'
    BeaconColor=(R=0.5000000,G=0.5000000,B=0.5000000,A=0.5000000)
    RandomBehaviorInterval=30.0000000
    ReachThreshold=1.0000000
    DesiredGroupRadius=200.0000000
    MaxLOSLifeDistanceSq=400000000.0000000
    Components[0]=MyLightEnvironment
    Physics=EPhysics.PHYS_Interpolating
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bCollideActors=true
    bProjTarget=true
    bNoEncroachCheck=true
    SupportedEvents=/* Array type was not detected. */
}