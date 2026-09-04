class AutoTestManager extends Info
    native
    config(Game)
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var bool bAutomatedPerfTesting;
var bool bAutoContinueToNextRound;
var bool bUsingAutomatedTestingMapList;
var bool bAutomatedTestingWithOpen;
var globalconfig bool bExitOnCyclesComplete;
var bool bCheckingForFragmentation;
var bool bCheckingForMemLeaks;
var bool bIsDoingASimplePerfRun;
var bool bDoingASentinelRun;
var bool bSentinelRunInProgress;
var transient bool bSentinelStreamingLevelStillLoading;
var int AutomatedPerfRemainingTime;
var int AutomatedTestingMapIndex;
var globalconfig array<config string> AutomatedMapTestingList;
var globalconfig int NumAutomatedMapTestingCycles;
var int NumberOfMatchesPlayed;
var int NumMapListCyclesDone;
var string AutomatedTestingExecCommandToRunAtStartMatch;
var string AutomatedTestingExecCommandToRunAtStartMatchOnPC;
var string AutomatedMapTestingTransitionMap;
var string SentinelTaskDescription;
var string SentinelTaskParameter;
var string SentinelTagDesc;
var transient PlayerController SentinelPC;
var transient array<Vector> SentinelTravelArray;
var transient int SentinelNavigationIdx;
var transient int SentinelIdx;
var transient int NumRotationsIncrement;
var transient int TravelPointsIncrement;
var config int NumMinutesPerMap;
var int TotalNumMinutesToRun;
var float ProfilingInterval;
var config array<config string> CommandsToRunAtEachTravelTheWorldNode;
var transient string CommandStringToExec;

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    SetTimer(1.0000000, true);
    //return;    
}

event Timer()
{
    // End:0x63
    if((bAutomatedPerfTesting && AutomatedPerfRemainingTime > 0) && !bAutoContinueToNextRound)
    {
        AutomatedPerfRemainingTime--;
        // End:0x63
        if(AutomatedPerfRemainingTime <= 0)
        {            
            ConsoleCommand("EXIT");
        }
    }
    //return;    
}

function InitializeOptions(string Options)
{
    local string InOpt;

    AutomatedPerfRemainingTime = 60 * WorldInfo.Game.TimeLimit;
    bAutomatedPerfTesting = (WorldInfo.Game.ParseOption(Options, "AutomatedPerfTesting") ~= "1") || WorldInfo.Game.ParseOption(Options, "gAPT") ~= "1";
    bCheckingForFragmentation = (WorldInfo.Game.ParseOption(Options, "CheckingForFragmentation") ~= "1") || WorldInfo.Game.ParseOption(Options, "gCFF") ~= "1";
    bCheckingForMemLeaks = (WorldInfo.Game.ParseOption(Options, "CheckingForMemLeaks") ~= "1") || WorldInfo.Game.ParseOption(Options, "gCFML") ~= "1";
    bIsDoingASimplePerfRun = WorldInfo.Game.ParseOption(Options, "SimplePerfRun") ~= "1";
    bDoingASentinelRun = (WorldInfo.Game.ParseOption(Options, "DoingASentinelRun") ~= "1") || WorldInfo.Game.ParseOption(Options, "gDASR") ~= "1";
    SentinelTaskDescription = WorldInfo.Game.ParseOption(Options, "SentinelTaskDescription");
    // End:0x41C
    if(SentinelTaskDescription == "")
    {
        SentinelTaskDescription = WorldInfo.Game.ParseOption(Options, "gSTD");
    }
    SentinelTaskParameter = WorldInfo.Game.ParseOption(Options, "SentinelTaskParameter");
    // End:0x4D7
    if(SentinelTaskParameter == "")
    {
        SentinelTaskParameter = WorldInfo.Game.ParseOption(Options, "gSTP");
    }
    SentinelTagDesc = WorldInfo.Game.ParseOption(Options, "SentinelTagDesc");
    // End:0x58D
    if(SentinelTagDesc == "")
    {
        SentinelTagDesc = WorldInfo.Game.ParseOption(Options, "gSTDD");
    }
    InOpt = WorldInfo.Game.ParseOption(Options, "AutoContinueToNextRound");
    // End:0x613
    if(InOpt != "")
    {
        bAutoContinueToNextRound = bool(InOpt);
    }
    InOpt = WorldInfo.Game.ParseOption(Options, "TotalNumMinutesToRun");
    // End:0x695
    if(InOpt != "")
    {
        TotalNumMinutesToRun = int(InOpt);
    }
    ProfilingInterval = 3.0000000;
    InOpt = WorldInfo.Game.ParseOption(Options, "ProfilingInterval");
    // End:0x723
    if(InOpt != "")
    {
        ProfilingInterval = float(InOpt);
    }
    InOpt = WorldInfo.Game.ParseOption(Options, "bUsingAutomatedTestingMapList");
    // End:0x7AF
    if(InOpt != "")
    {
        bUsingAutomatedTestingMapList = bool(InOpt);
    }
    // End:0x7D8
    if(bUsingAutomatedTestingMapList)
    {
        // End:0x7D8
        if(AutomatedMapTestingList.Length == 0)
        {
            bUsingAutomatedTestingMapList = false;
        }
    }
    InOpt = WorldInfo.Game.ParseOption(Options, "bAutomatedTestingWithOpen");
    // End:0x860
    if(InOpt != "")
    {
        bAutomatedTestingWithOpen = bool(InOpt);
    }
    AutomatedTestingExecCommandToRunAtStartMatch = WorldInfo.Game.ParseOption(Options, "AutomatedTestingExecCommandToRunAtStartMatch");
    AutomatedTestingExecCommandToRunAtStartMatchOnPC = WorldInfo.Game.ParseOption(Options, "AutomatedTestingExecCommandToRunAtStartMatchOnPC");
    AutomatedMapTestingTransitionMap = WorldInfo.Game.ParseOption(Options, "AutomatedMapTestingTransitionMap");
    InOpt = WorldInfo.Game.ParseOption(Options, "AutomatedTestingMapIndex");
    // End:0xA3D
    if(InOpt != "")
    {
        AutomatedTestingMapIndex = int(InOpt);
    }
    // End:0xB52
    if(bAutomatedTestingWithOpen)
    {
        InOpt = WorldInfo.Game.ParseOption(Options, "NumberOfMatchesPlayed");
        // End:0xACD
        if(InOpt != "")
        {
            NumberOfMatchesPlayed = int(InOpt);
        }
        InOpt = WorldInfo.Game.ParseOption(Options, "NumMapListCyclesDone");
        // End:0xB4F
        if(InOpt != "")
        {
            NumMapListCyclesDone = int(InOpt);
        }        
    }
    else
    {
        AutomatedMapTestingTransitionMap = "";
    }
    //return;    
}

// Export UAutoTestManager::execBeginSentinelRun(FFrame&, void* const)
native function BeginSentinelRun(const string TaskDescription, const string TaskParameter, const string TagDesc);

// Export UAutoTestManager::execAddSentinelPerTimePeriodStats(FFrame&, void* const)
native function AddSentinelPerTimePeriodStats(const Vector InLocation, const Rotator InRotation);

// Export UAutoTestManager::execEndSentinelRun(FFrame&, void* const)
native function EndSentinelRun(Object.EAutomatedRunResult RunResult);

function DoTravelTheWorld()
{
    GotoState('TravelTheWorld');
    //return;    
}

// Export UAutoTestManager::execDoSentinelActionPerLoadedMap(FFrame&, void* const)
native function DoSentinelActionPerLoadedMap();

// Export UAutoTestManager::execHandlePerLoadedMapAudioStats(FFrame&, void* const)
native function HandlePerLoadedMapAudioStats();

// Export UAutoTestManager::execGetTravelLocations(FFrame&, void* const)
native function GetTravelLocations(name LevelName, PlayerController PC, out array<Vector> TravelPoints);

// Export UAutoTestManager::execDoSentinel_MemoryAtSpecificLocation(FFrame&, void* const)
native function DoSentinel_MemoryAtSpecificLocation(const Vector InLocation, const Rotator InRotation);

// Export UAutoTestManager::execDoSentinel_PerfAtSpecificLocation(FFrame&, void* const)
native function DoSentinel_PerfAtSpecificLocation(const out Vector InLocation, const out Rotator InRotation);

// Export UAutoTestManager::execDoSentinel_ViewDependentMemoryAtSpecificLocation(FFrame&, void* const)
native function DoSentinel_ViewDependentMemoryAtSpecificLocation(const out Vector InLocation, const out Rotator InRotation);

function DoTimeBasedSentinelStatGathering()
{
    local PlayerController PC;
    local Vector ViewLocation;
    local Rotator ViewRotation;

    // End:0x23
    foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
    {
        // End:0x23
        break;        
    }    
    PC.GetPlayerViewPoint(ViewLocation, ViewRotation);
    // End:0xF7
    if((SentinelTaskDescription != "FlyThrough") && SentinelTaskDescription != "FlyThroughSplitScreen")
    {
        // End:0xF7
        if(PC.Pawn != none)
        {
            ViewLocation = PC.Pawn.Location;
        }
    }
    AddSentinelPerTimePeriodStats(ViewLocation, ViewRotation);
    //return;    
}

function EndTimeBasedSentinelStatGatheringAndExit()
{
    ConsoleCommand("exit");
    //return;    
}

// Export UAutoTestManager::execDoMemoryTracking(FFrame&, void* const)
native function DoMemoryTracking();

event StartAutomatedMapTestTimer()
{
    SetTimer(5.0000000, true, 'StartAutomatedMapTestTimerWorker');
    //return;    
}

function StartAutomatedMapTestTimerWorker()
{
    local int LevelIdx;

    // End:0xB2
    if(WorldInfo != none)
    {
        LevelIdx = 0;
        J0x1A:

        // End:0x9B [Loop If]
        if(LevelIdx < WorldInfo.StreamingLevels.Length)
        {
            // End:0x8D
            if(WorldInfo.StreamingLevels[LevelIdx].bHasLoadRequestPending == true)
            {
                return;
            }
            ++LevelIdx;
            // [Loop Continue]
            goto J0x1A;
        }
        // End:0xB2
        if(bCheckingForMemLeaks)
        {
            DoMemoryTracking();
        }
    }
    ClearTimer('StartAutomatedMapTestTimerWorker');
    SetTimer(15.0000000, false, 'CloseAutomatedMapTestTimer');
    //return;    
}

function CloseAutomatedMapTestTimer()
{
    // End:0x57
    if(Len(AutomatedMapTestingTransitionMap) > 0)
    {
        // End:0x54
        if(AutomatedTestingMapIndex < 0)
        {
            WorldInfo.Game.RestartGame();
        }        
    }
    else
    {
        WorldInfo.Game.RestartGame();
    }
    //return;    
}

function IncrementAutomatedTestingMapIndex()
{
    // End:0x3D
    if(bUsingAutomatedTestingMapList == true)
    {
        // End:0x23
        if(bAutomatedTestingWithOpen == true)
        {            
        }
        else
        {
            // End:0x3D
            if(AutomatedTestingMapIndex >= 0)
            {
                AutomatedTestingMapIndex++;
            }
        }
    }
    //return;    
}

function IncrementNumberOfMatchesPlayed()
{
    NumberOfMatchesPlayed++;
    //return;    
}

function string GetNextAutomatedTestingMap()
{
    local string MapName;
    local PlayerController PC;
    local bool bResetMapIndex;

    // End:0x2E7
    if(bUsingAutomatedTestingMapList)
    {
        // End:0x62
        if((AutomatedTestingMapIndex >= 0) && Len(AutomatedMapTestingTransitionMap) > 0)
        {
            AutomatedTestingMapIndex++;
            AutomatedTestingMapIndex *= float(-1);
            MapName = AutomatedMapTestingTransitionMap;            
        }
        else
        {
            // End:0x85
            if(Len(AutomatedMapTestingTransitionMap) > 0)
            {
                AutomatedTestingMapIndex *= float(-1);
            }
            // End:0xBF
            if(AutomatedTestingMapIndex >= AutomatedMapTestingList.Length)
            {
                AutomatedTestingMapIndex = 0;
                NumMapListCyclesDone++;
                bResetMapIndex = true;
            }
            MapName = AutomatedMapTestingList[AutomatedTestingMapIndex];
        }
        // End:0x182
        if(bAutomatedTestingWithOpen == true)
        {
            // End:0x17F
            if((NumMapListCyclesDone >= NumAutomatedMapTestingCycles) && NumAutomatedMapTestingCycles != 0)
            {
                // End:0x158
                if(bCheckingForMemLeaks)
                {                    
                    ConsoleCommand("DEFERRED_STOPMEMTRACKING_AND_DUMP");
                }
                // End:0x17F
                if(bExitOnCyclesComplete)
                {                    
                    ConsoleCommand("EXIT");
                }
            }            
        }
        else
        {
            // End:0x2DC
            foreach WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
            {
                // End:0x20B
                if(bResetMapIndex)
                {
                    PC.PlayerReplicationInfo.AutomatedTestingData.NumMapListCyclesDone++;
                }
                // End:0x2DB
                if((PC.PlayerReplicationInfo.AutomatedTestingData.NumMapListCyclesDone >= NumAutomatedMapTestingCycles) && NumAutomatedMapTestingCycles != 0)
                {
                    // End:0x2B4
                    if(bCheckingForMemLeaks)
                    {                        
                        ConsoleCommand("DEFERRED_STOPMEMTRACKING_AND_DUMP");
                    }
                    // End:0x2DB
                    if(bExitOnCyclesComplete)
                    {                        
                        ConsoleCommand("EXIT");
                    }
                }                
            }            
        }
        return MapName;
    }
    return "";
    //return ReturnValue;    
}

function StartMatch()
{
    local PlayerController PC;

    // End:0x1A
    if(bAutomatedTestingWithOpen)
    {
        IncrementNumberOfMatchesPlayed();        
    }
    else
    {
        // End:0x71
        foreach WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
        {
            PC.IncrementNumberOfMatchesPlayed();
            // End:0x71
            break;            
        }        
    }
    IncrementAutomatedTestingMapIndex();
    // End:0xAB
    if(bCheckingForFragmentation)
    {        
        ConsoleCommand("MemFragCheck");
    }
    // End:0xD8
    if(AutomatedTestingExecCommandToRunAtStartMatch != "")
    {        
        ConsoleCommand(AutomatedTestingExecCommandToRunAtStartMatch);
    }
    // End:0x11A
    if(AutomatedTestingExecCommandToRunAtStartMatchOnPC != "")
    {        
        PC.ConsoleCommand(AutomatedTestingExecCommandToRunAtStartMatchOnPC);
    }
    //return;    
}

function bool CheckForSentinelRun()
{
    local float TimeWeGetInSeconds;

    // End:0xF0
    if(bDoingASentinelRun && !bSentinelRunInProgress)
    {
        // End:0x75
        if(SentinelTaskDescription ~= "TravelTheWorld")
        {
            WorldInfo.Game.DoTravelTheWorld();
            return true;            
        }
        else
        {
            BeginSentinelRun(SentinelTaskDescription, SentinelTaskParameter, SentinelTagDesc);
            SetTimer(ProfilingInterval, true, 'DoTimeBasedSentinelStatGathering');
        }
        // End:0xF0
        if(TotalNumMinutesToRun > 0)
        {
            TimeWeGetInSeconds = float(TotalNumMinutesToRun * 60);
            SetTimer(TimeWeGetInSeconds, false, 'EndTimeBasedSentinelStatGatheringAndExit');
        }
    }
    return false;
    //return ReturnValue;    
}

state TravelTheWorld
{
    ignores PrintOutTravelWorldTimes;

    function BeginState(name PreviousStateName)
    {
        local PlayerController PC;

        super(Object).BeginState(PreviousStateName);
        // End:0x68
        foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
        {
            SentinelPC = PC;
            SentinelPC.Sentinel_SetupForGamebasedTravelTheWorld();
            // End:0x68
            break;            
        }        
        SentinelPC.bIsUsingStreamingVolumes = false;
        BeginSentinelRun(SentinelTaskDescription, SentinelTaskParameter, SentinelTagDesc);
        //return;        
    }

    function float CalcTravelTheWorldTime(const int NumTravelLocations, const int NumRotations)
    {
        local float TotalTimeInSeconds, PerTravelLocTime;

        TotalTimeInSeconds += (float(WorldInfo.StreamingLevels.Length) * 2.0000000);
        TotalTimeInSeconds += 10.0000000;
        TotalTimeInSeconds += (float(WorldInfo.StreamingLevels.Length) * 10.0000000);
        TotalTimeInSeconds += 10.0000000;
        TotalTimeInSeconds += 10.0000000;
        PerTravelLocTime = (((((0.5000000 + 4.0000000) + 1.0000000) + 0.5000000) + 1.0000000) + (float(NumRotations) * 1.5000000)) + (float(NumRotations) * 1.5000000);
        TotalTimeInSeconds += (PerTravelLocTime * float(NumTravelLocations));
        return TotalTimeInSeconds;
        //return ReturnValue;        
    }

    function SetIncrementsForLoops(const float NumTravelLocations)
    {
        local float TimeWeGetInSeconds;

        TimeWeGetInSeconds = float(NumMinutesPerMap * 60);
        // End:0x7A
        if((CalcTravelTheWorldTime(int(NumTravelLocations), 8)) < TimeWeGetInSeconds)
        {
            TravelPointsIncrement = 1;
            NumRotationsIncrement = 1;
            PrintOutTravelWorldTimes(int(CalcTravelTheWorldTime(int(NumTravelLocations), 8)));            
        }
        else
        {
            // End:0xDC
            if((CalcTravelTheWorldTime(int(NumTravelLocations), 4)) < TimeWeGetInSeconds)
            {
                TravelPointsIncrement = 1;
                NumRotationsIncrement = 2;
                PrintOutTravelWorldTimes(int(CalcTravelTheWorldTime(int(NumTravelLocations), 4)));                
            }
            else
            {
                TravelPointsIncrement = int((CalcTravelTheWorldTime(int(NumTravelLocations), 4)) / TimeWeGetInSeconds);
                NumRotationsIncrement = 2;
                PrintOutTravelWorldTimes(int(CalcTravelTheWorldTime(int(NumTravelLocations / float(TravelPointsIncrement)), 4)));
            }
        }
        //return;        
    }
Begin:

    SentinelPC.Sentinel_PreAcquireTravelTheWorldPoints();
    SentinelIdx = 0;
    J0x2A:

    // End:0xC4 [Loop If]
    if(SentinelIdx < WorldInfo.StreamingLevels.Length)
    {
        SentinelPC.ClientUpdateLevelStreamingStatus(WorldInfo.StreamingLevels[SentinelIdx].PackageName, false, false, true);
        ++SentinelIdx;
        // [Loop Continue]
        goto J0x2A;
    }
    Sleep(10.0000000);
    WorldInfo.ForceGarbageCollection(true);
    SentinelIdx = 0;
    J0xF7:

    // End:0x36C [Loop If]
    if(SentinelIdx < WorldInfo.StreamingLevels.Length)
    {
        SentinelPC.ClientUpdateLevelStreamingStatus(WorldInfo.StreamingLevels[SentinelIdx].PackageName, true, true, true);
        Sleep(7.0000000);
        GetTravelLocations(WorldInfo.StreamingLevels[SentinelIdx].PackageName, SentinelPC, SentinelTravelArray);
        DoSentinelActionPerLoadedMap();        
        SentinelPC.ConsoleCommand("FractureAllMeshesToMaximizeMemoryUsage");        
        SentinelPC.ConsoleCommand("stat memory");
        Sleep(0.5000000);
        DoSentinel_MemoryAtSpecificLocation(vect(0.0000000, 0.0000000, 0.0000000), rot(0, 0, 0));        
        SentinelPC.ConsoleCommand("stat memory");
        SentinelPC.ClientUpdateLevelStreamingStatus(WorldInfo.StreamingLevels[SentinelIdx].PackageName, false, false, true);
        Sleep(3.0000000);
        WorldInfo.ForceGarbageCollection(true);
        ++SentinelIdx;
        // [Loop Continue]
        goto J0xF7;
    }
    // End:0x505
    if(WorldInfo.StreamingLevels.Length == 0)
    {
        GetTravelLocations(WorldInfo.StreamingLevels[SentinelIdx].PackageName, SentinelPC, SentinelTravelArray);
        DoSentinelActionPerLoadedMap();        
        SentinelPC.ConsoleCommand("FractureAllMeshesToMaximizeMemoryUsage");        
        SentinelPC.ConsoleCommand("stat memory");
        Sleep(0.5000000);
        DoSentinel_MemoryAtSpecificLocation(vect(0.0000000, 0.0000000, 0.0000000), rot(0, 0, 0));        
        SentinelPC.ConsoleCommand("stat memory");
        Sleep(3.0000000);
        WorldInfo.ForceGarbageCollection(true);
    }
    SetIncrementsForLoops(float(SentinelTravelArray.Length));
    SentinelIdx = 0;
    J0x526:

    // End:0x5F7 [Loop If]
    if(SentinelIdx < WorldInfo.StreamingLevels.Length)
    {
        // End:0x5E9
        if(LevelStreamingAlwaysLoaded(WorldInfo.StreamingLevels[SentinelIdx]) != none)
        {
            SentinelPC.ClientUpdateLevelStreamingStatus(WorldInfo.StreamingLevels[SentinelIdx].PackageName, true, true, true);
        }
        ++SentinelIdx;
        // [Loop Continue]
        goto J0x526;
    }
    SentinelPC.bIsUsingStreamingVolumes = true;
    Sleep(10.0000000);
    SentinelPC.Sentinel_PostAcquireTravelTheWorldPoints();
    Sleep(10.0000000);
    SentinelTravelArray.AddItem(SentinelTravelArray[0]);
    SentinelNavigationIdx = 0;
    J0x66A:

    // End:0xB61 [Loop If]
    if(SentinelNavigationIdx < SentinelTravelArray.Length)
    {
        SentinelPC.SetLocation(SentinelTravelArray[SentinelNavigationIdx]);
        SentinelPC.SetRotation(rot(0, 0, 0));
        Sleep(0.5000000);
        J0x6DA:

        bSentinelStreamingLevelStillLoading = false;
        SentinelIdx = 0;
        J0x6F1:

        // End:0x787 [Loop If]
        if(SentinelIdx < WorldInfo.StreamingLevels.Length)
        {
            // End:0x779
            if(WorldInfo.StreamingLevels[SentinelIdx].bHasLoadRequestPending == true)
            {
                bSentinelStreamingLevelStillLoading = true;
                Sleep(1.0000000);
                // [Explicit Break]
                goto J0x787;
            }
            ++SentinelIdx;
            // [Loop Continue]
            goto J0x6F1;
        }
        J0x787:

        // End:0x6DA
        if(!(bSentinelStreamingLevelStillLoading == false))
            goto J0x6DA;
        WorldInfo.ForceGarbageCollection(true);
        Sleep(1.0000000);
        // End:0x7F0
        if(SentinelNavigationIdx == 0)
        {            
            ConsoleCommand("MemLeakCheck");
        }        
        SentinelPC.ConsoleCommand("stat memory");
        Sleep(0.5000000);
        DoSentinel_MemoryAtSpecificLocation(SentinelPC.Location, SentinelPC.Rotation);        
        SentinelPC.ConsoleCommand("stat memory");        
        SentinelPC.ConsoleCommand("stat scenerendering");        
        SentinelPC.ConsoleCommand("stat streaming");
        Sleep(1.0000000);
        SentinelIdx = 0;
        J0x934:

        // End:0x9E3 [Loop If]
        if(SentinelIdx < 8)
        {
            SentinelPC.SetRotation(rot(0, 1, 0) * float(8192 * SentinelIdx));
            Sleep(1.5000000);
            DoSentinel_ViewDependentMemoryAtSpecificLocation(SentinelPC.Location, SentinelPC.Rotation);
            SentinelIdx += NumRotationsIncrement;
            // [Loop Continue]
            goto J0x934;
        }        
        SentinelPC.ConsoleCommand("stat scenerendering");        
        SentinelPC.ConsoleCommand("stat streaming");
        SentinelIdx = 0;
        J0xA65:

        // End:0xB14 [Loop If]
        if(SentinelIdx < 8)
        {
            SentinelPC.SetRotation(rot(0, 1, 0) * float(8192 * SentinelIdx));
            Sleep(1.5000000);
            DoSentinel_PerfAtSpecificLocation(SentinelPC.Location, SentinelPC.Rotation);
            SentinelIdx += NumRotationsIncrement;
            // [Loop Continue]
            goto J0xA65;
        }
        // End:0xB49
        foreach CommandsToRunAtEachTravelTheWorldNode(CommandStringToExec)
        {            
            ConsoleCommand(CommandStringToExec);            
        }        
        SentinelNavigationIdx += TravelPointsIncrement;
        // [Loop Continue]
        goto J0x66A;
    }    
    ConsoleCommand("MemLeakCheck");    
    ConsoleCommand("exit");
    stop;            
}

state SentinelHandleCauseEventCommand
{    J0x00:
    bSentinelStreamingLevelStillLoading = false;
    SentinelIdx = 0;
    J0x17:

    // End:0xAD [Loop If]
    if(SentinelIdx < WorldInfo.StreamingLevels.Length)
    {
        // End:0x9F
        if(WorldInfo.StreamingLevels[SentinelIdx].bHasLoadRequestPending == true)
        {
            bSentinelStreamingLevelStillLoading = true;
            Sleep(1.0000000);
            // [Explicit Break]
            goto J0xAD;
        }
        ++SentinelIdx;
        // [Loop Continue]
        goto J0x17;
    }
    J0xAD:

    // End:0x00
    if(!(bSentinelStreamingLevelStillLoading == false))
        goto J0x00;
    // End:0x193
    if(WorldInfo.Game.CauseEventCommand != "")
    {
        // End:0x192
        foreach WorldInfo.AllControllers(Class'Engine.PlayerController', SentinelPC)
        {            
            SentinelPC.ConsoleCommand("ce " $ WorldInfo.Game.CauseEventCommand);
            // End:0x192
            break;            
        }        
    }
    // End:0x1E7
    if((SentinelTaskDescription == "FlyThrough") || SentinelTaskDescription == "FlyThroughSplitScreen")
    {
        SetTimer(0.5000000, true, 'DoTimeBasedSentinelStatGathering');
    }
    stop;                    
}

defaultproperties
{
    NumMinutesPerMap=50
}