class GamePlayerController extends PlayerController
    abstract
    native
    config(Game)
    hidecategories(Navigation);

var bool bWarnCrowdMembers;
var(Debug) bool bDebugCrowdAwareness;
var transient bool bIsWarmupPaused;
var transient bool bEnableMouseCursor;
var float AgentAwareRadius;
var protected transient name CurrentSoundMode;

function OnToggleMouseCursor(SeqAct_ToggleMouseCursor inAction)
{
    local GameViewportClient GVC;

    GVC = ((LocalPlayer(Player) != none) ? LocalPlayer(Player).ViewportClient : none);
    // End:0xAE
    if(GVC != none)
    {
        GVC.SetHardwareMouseCursorVisibility(inAction.InputLinks[0].bHasImpulse);
    }
    //return;    
}

// Export UGamePlayerController::execGetUIPlayerIndex(FFrame&, void* const)
native function int GetUIPlayerIndex();

exec function CrowdDebug(bool bEnabled)
{
    local GameCrowdAgent GCA;
    local int I, AgentCount;
    local float DebugRadius;

    myHUD.bShowOverlays = bEnabled;
    I = 0;
    J0x35:

    // End:0xE2 [Loop If]
    if(I < myHUD.PostRenderedActors.Length)
    {
        GCA = GameCrowdAgent(myHUD.PostRenderedActors[I]);
        // End:0xD4
        if(GCA != none)
        {
            myHUD.RemovePostRenderedActor(GCA);
        }
        I++;
        // [Loop Continue]
        goto J0x35;
    }
    // End:0x216
    if(bEnabled)
    {
        DebugRadius = 2000.0000000;
        // End:0x163
        foreach VisibleActors(Class'GameFramework.GameCrowdAgent', GCA, DebugRadius, ((Pawn != none) ? Pawn.Location : Location))
        {
            AgentCount++;            
        }        
        // End:0x193
        if(AgentCount > 100)
        {
            DebugRadius *= Sqrt(100.0000000 / float(AgentCount));
        }
        // End:0x215
        foreach VisibleActors(Class'GameFramework.GameCrowdAgent', GCA, DebugRadius, ((Pawn != none) ? Pawn.Location : Location))
        {
            myHUD.AddPostRenderedActor(GCA);            
        }        
    }
    //return;    
}

event NotifyCrowdAgentRefresh()
{
    //return;    
}

event NotifyCrowdAgentInRadius(GameCrowdAgent Agent)
{
    //return;    
}

protected simulated function DoForceFeedbackForScreenShake(CameraShake ShakeData, float Scale)
{
    local int ShakeLevel;
    local float RotMag, LocMag, FOVMag;

    // End:0x2C1
    if(ShakeData != none)
    {
        RotMag = ShakeData.GetRotOscillationMagnitude() * Scale;
        // End:0x65
        if(RotMag > 40.0000000)
        {
            ShakeLevel = 2;            
        }
        else
        {
            // End:0x83
            if(RotMag > 20.0000000)
            {
                ShakeLevel = 1;
            }
        }
        // End:0x19D
        if(ShakeLevel < 2)
        {
            LocMag = ShakeData.GetLocOscillationMagnitude() * Scale;
            // End:0xE9
            if(LocMag > 10.0000000)
            {
                ShakeLevel = 2;                
            }
            else
            {
                // End:0x107
                if(LocMag > 5.0000000)
                {
                    ShakeLevel = 1;
                }
            }
            FOVMag = ShakeData.FOVOscillation.Amplitude * Scale;
            // End:0x19D
            if(ShakeLevel < 2)
            {
                // End:0x17F
                if(FOVMag > 5.0000000)
                {
                    ShakeLevel = 2;                    
                }
                else
                {
                    // End:0x19D
                    if(FOVMag > 2.0000000)
                    {
                        ShakeLevel = 1;
                    }
                }
            }
        }
        // End:0x231
        if(ShakeLevel == 2)
        {
            // End:0x202
            if(ShakeData.OscillationDuration <= float(1))
            {
                ClientPlayForceFeedbackWaveform(Class'GameFramework.GameWaveForms'.default.CameraShakeBigShort);                
            }
            else
            {
                ClientPlayForceFeedbackWaveform(Class'GameFramework.GameWaveForms'.default.CameraShakeBigLong);
            }            
        }
        else
        {
            // End:0x2C1
            if(ShakeLevel == 1)
            {
                // End:0x295
                if(ShakeData.OscillationDuration <= float(1))
                {
                    ClientPlayForceFeedbackWaveform(Class'GameFramework.GameWaveForms'.default.CameraShakeMediumShort);                    
                }
                else
                {
                    ClientPlayForceFeedbackWaveform(Class'GameFramework.GameWaveForms'.default.CameraShakeMediumLong);
                }
            }
        }
    }
    //return;    
}

simulated function SetSoundMode(name InSoundModeName)
{
    local AudioDevice Audio;
    local bool bSet;

    Audio = Class'Engine.Engine'.static.GetAudioDevice();
    // End:0xA5
    if(Audio != none)
    {
        // End:0xA5
        if(CurrentSoundMode != InSoundModeName)
        {
            bSet = Audio.super(GamePlayerController).SetSoundMode(InSoundModeName);
            // End:0xA5
            if(bSet == true)
            {
                CurrentSoundMode = InSoundModeName;
            }
        }
    }
    //return;    
}

// Export UGamePlayerController::execShowLoadingMovie(FFrame&, void* const)
native static final function ShowLoadingMovie(bool bShowMovie, optional bool bPauseAfterHide, optional float PauseDuration, optional float KeepPlayingDuration, optional bool bOverridePreviousDelays);

// Export UGamePlayerController::execKeepPlayingLoadingMovie(FFrame&, void* const)
native static final function KeepPlayingLoadingMovie();

// Export UGamePlayerController::execClientPlayMovie(FFrame&, void* const)
reliable client native final simulated event ClientPlayMovie(string MovieName, int InStartOfRenderingMovieFrame, int InEndOfRenderingMovieFrame, bool bRestrictPausing, bool bPlayOnceFromStream, bool bOnlyBackButtonSkipsMovie);

// Export UGamePlayerController::execClientStopMovie(FFrame&, void* const)
reliable client native final simulated event ClientStopMovie(float DelayInSeconds, bool bAllowMovieToFinish, bool bForceStopNonSkippable, bool bForceStopLoadingMovie);

// Export UGamePlayerController::execGetCurrentMovie(FFrame&, void* const)
native final function GetCurrentMovie(out string MovieName);

function bool CanUnpauseWarmup()
{
    return !bIsWarmupPaused;
    //return ReturnValue;    
}

event WarmupPause(bool bDesiredPauseState)
{
    local Color FadeColor;
    local PlayerController PC;
    local string MovieName;

    bIsWarmupPaused = bDesiredPauseState;
    SetPause(bDesiredPauseState, CanUnpauseWarmup);
    // End:0xC7
    if(!bDesiredPauseState)
    {
        GetCurrentMovie(MovieName);
        // End:0xC7
        if(MovieName != "")
        {
            // End:0xC6
            foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
            {
                GamePlayerController(PC).ClientColorFade(FadeColor, 255, 0, 2.0000000);                
            }            
        }
    }
    //return;    
}

exec function DoMemLeakChecking(float InTimeBetweenMemLeakChecks)
{
    ConsoleCommand("TrackLowestMemory 1");
    SetTimer(InTimeBetweenMemLeakChecks, true, 'CallMemLeakCheck');
    //return;    
}

exec function StopMemLeakChecking()
{
    ClearTimer('CallMemLeakCheck');
    //return;    
}

private final function CallMemLeakCheck()
{
    ConsoleCommand("MemLeakCheck -FAST -WAITFORTEXSTREAMING");
    //return;    
}

reliable client simulated function ClientColorFade(Color FadeColor, byte FromAlpha, byte ToAlpha, float FadeTime)
{
    //return;    
}

defaultproperties
{
    AgentAwareRadius=200.0000000
    CheatClass=Class'GameFramework.GameCheatManager'
    // Reference: CylinderComponent'GameFramework.Default__GamePlayerController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}