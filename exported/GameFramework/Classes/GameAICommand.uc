class GameAICommand extends AICommandBase within GameAIController
    abstract
    native;

var() const editinline transient GameAICommand ChildCommand;
var() const transient name ChildStatus;
var() transient GameAIController GameAIOwner;
var() transient name Status;
var bool bAllowNewSameClassInstance;
var bool bReplaceActiveSameClassInstance;
var private transient bool bAborted;
var bool bIgnoreNotifies;
var bool bIgnoreStepAside;
var private transient bool bPendingPop;

static function bool InitCommandUserActor(GameAIController AI, Actor UserActor)
{
    return InitCommand(AI);
    //return ReturnValue;    
}

static function bool InitCommand(GameAIController AI)
{
    local GameAICommand Cmd;

    // End:0x68
    if(AI != none)
    {
        Cmd = new (AI) default.Class;
        // End:0x68
        if(Cmd != none)
        {
            AI.PushCommand(Cmd);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

final event InternalPrePushed(GameAIController AI)
{
    GameAIOwner = AI;
    PrePushed(AI);
    //return;    
}

final event InternalPushed()
{
    GotoState('Auto');
    Pushed();
    //return;    
}

event InternalPopped()
{
    Popped();
    GameAIOwner = none;
    PostPopped();
    //return;    
}

final event InternalPaused(GameAICommand NewCommand)
{
    Paused(NewCommand);
    //return;    
}

final event InternalResumed(name OldCommandName)
{
    Resumed(OldCommandName);
    //return;    
}

final event InternalTick(float DeltaTime)
{
    Tick(DeltaTime);
    //return;    
}

// Export UGameAICommand::execShouldIgnoreNotifies(FFrame&, void* const)
native final function bool ShouldIgnoreNotifies();

function Tick(float DeltaTime)
{
    //return;    
}

function bool AllowTransitionTo(Class<GameAICommand> AttemptCommand)
{
    return (ChildCommand == none) || ChildCommand.AllowTransitionTo(AttemptCommand);
    //return ReturnValue;    
}

function bool AllowStateTransitionTo(name StateName)
{
    return (ChildCommand == none) || ChildCommand.AllowStateTransitionTo(StateName);
    //return ReturnValue;    
}

function PrePushed(GameAIController AI)
{
    //return;    
}

function PostPopped()
{
    //return;    
}

function Pushed()
{
    //return;    
}

function Popped()
{
    //return;    
}

function Paused(GameAICommand NewCommand)
{
    //return;    
}

function Resumed(name OldCommandName)
{
    //return;    
}

event string GetDumpString()
{
    return string(self);
    //return ReturnValue;    
}

event DrawDebug(HUD H, name Category)
{
    //return;    
}

function GetDebugOverheadText(PlayerController PC, out array<string> OutText)
{
    //return;    
}

event string GetDebugVerboseText()
{
    //return ReturnValue;    
}

function NotifyNeedRepath()
{
    //return;    
}

function bool MoveUnreachable(Vector AttemptedDest, Actor AttemptedTarget)
{
    //return ReturnValue;    
}

function bool HandlePathObstruction(Actor BlockedBy)
{
    // End:0x38
    if(ChildCommand != none)
    {
        return ChildCommand.HandlePathObstruction(BlockedBy);
    }
    return false;
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

state DelayFailure
{Begin:

    Outer.Sleep(0.5000000);
    Status = 'Failure';
    Outer.PopCommand(self);
    stop;                
}

state DelaySuccess
{Begin:

    Outer.Sleep(0.1000000);
    Status = 'Success';
    Outer.PopCommand(self);
    stop;                
}
