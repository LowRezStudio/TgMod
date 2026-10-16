class GameAIController extends AIController
    abstract
    native
    config(Game)
    hidecategories(Navigation);

var() const editinline transient GameAICommand CommandList;
var transient bool bHasRunawayCommandList;
var(Debug) config bool bAILogging;
var(Debug) config bool bAILogToWindow;
var(Debug) config bool bFlushAILogEachLine;
var(Debug) config bool bMapBasedLogName;
var(Debug) config bool bAIDrawDebug;
var transient bool bAIBroken;
var transient FileLog AILogFile;
var(Debug) float DebugTextMaxLen;
var(Debug) const transient array<AICmdHistoryItem> CommandHistory;
var(Debug) config int CommandHistoryNum;
var(Debug) config array<config name> AILogFilter;
var string DemoActionString;

replication
{
    // Pos:0x000
    if(bDemoRecording)
        DemoActionString;
}

// Export UGameAIController::execAllCommands(FFrame&, void* const)
native final iterator function AllCommands(Class<GameAICommand> BaseClass, out GameAICommand Cmd);

// Export UGameAIController::execPushCommand(FFrame&, void* const)
native function PushCommand(GameAICommand NewCommand);

// Export UGameAIController::execPopCommand(FFrame&, void* const)
native function PopCommand(GameAICommand ToBePoppedCommand);

// Export UGameAIController::execAbortCommand(FFrame&, void* const)
native function bool AbortCommand(GameAICommand AbortCmd, optional Class<GameAICommand> AbortClass);

// Export UGameAIController::execGetActiveCommand(FFrame&, void* const)
native final function GameAICommand GetActiveCommand();

// Export UGameAIController::execCheckCommandCount(FFrame&, void* const)
native final function CheckCommandCount();

// Export UGameAIController::execDumpCommandStack(FFrame&, void* const)
native final function DumpCommandStack();

// Export UGameAIController::execFindCommandOfClass(FFrame&, void* const)
native final function GameAICommand FindCommandOfClass(Class<GameAICommand> SearchClass);

// Export UGameAIController::execGetAICommandInStack(FFrame&, void* const)
native function GameAICommand GetAICommandInStack(const Class<GameAICommand> InClass);

function float GetDestinationOffset()
{
    //return ReturnValue;    
}

function ReachedMoveGoal()
{
    //return;    
}

function ReachedIntermediateMoveGoal()
{
    //return;    
}

event Destroyed()
{
    super(Controller).Destroyed();
    // End:0x31
    if(AILogFile != none)
    {
        AILogFile.Destroy();
    }
    // End:0x54
    if(CommandList != none)
    {
        AbortCommand(CommandList);
    }
    //return;    
}

protected function RecordDemoAILog(coerce string LogText)
{
    //return;    
}

event AILog_Internal(coerce string LogText, optional name LogCategory, optional bool bForce)
{
    //return;    
}

function SetDesiredRotation(Rotator TargetDesiredRotation, optional bool InLockDesiredRotation = false, optional bool InUnlockWhenReached = false, optional float InterpolationTime = -1.0000000)
{
    // End:0x68
    if(Pawn != none)
    {
        Pawn.super(GameAIController).SetDesiredRotation(TargetDesiredRotation, InLockDesiredRotation, InUnlockWhenReached, InterpolationTime);
    }
    //return;    
}

final simulated event string GetActionString()
{
    local string ActionStr;
    local GameAICommand ActiveCmd;

    // End:0x2F
    if(WorldInfo.IsPlayingDemo())
    {
        return DemoActionString;        
    }
    else
    {
        ActiveCmd = GetActiveCommand();
        // End:0xA0
        if(ActiveCmd != none)
        {
            ActionStr = (string(ActiveCmd.Class) $ ":") $ string(ActiveCmd.GetStateName());            
        }
        else
        {
            ActionStr = (string(default.Class) $ ":") $ string(GetStateName());
        }
        return ActionStr;
    }
    //return ReturnValue;    
}

state DebugState
{
    function BeginState(name PreviousStateName)
    {
        //return;        
    }

    function EndState(name NextStateName)
    {
        //return;        
    }

    function PushedState()
    {
        //return;        
    }

    function PoppedState()
    {
        //return;        
    }

    function ContinuedState()
    {
        //return;        
    }

    function PausedState()
    {
        //return;        
    }
    stop;    
}
