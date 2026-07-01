class TgGame_Paladins_Payload extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nPayloadOnlyCurrentAttackingTeam;
var int s_nCurrentTurn;

function OnRoundEnded(){}
function CaptureAndPayloadRoundEnded(){}
function ToggleAttackingTaskforce(){}
function SetResetEscapedPlayersTimers(bool bFirstRound){}

state GameRunning
{

    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {       
    }

    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {

    }
    stop;    
}

state AttackDefend
{

    function BeginState(name PreviousStateName)
    {
    }

    function float GetPayloadStartingDuration()
    {     
    }

    function float GetOvertimeDuration()
    {       
    }

    function bool OvertimePreventsPayloadExpiring()
    {       
    }

    function TgChaosCapturePoint GetCapturePointToSpawnSiegeEngineAt()
    {       
    }

    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {      
    }

    function Tick(float DeltaTime)
    {      
    }
}