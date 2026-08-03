class AIController extends Controller
    native(AI)
    notplaceable
    hidecategories(Navigation);

var bool bAdjustFromWalls;
var bool bReverseScriptedRoute;
var float Skill;
var Actor ScriptedMoveTarget;
var Route ScriptedRoute;
var int ScriptedRouteIndex;
var Actor ScriptedFocus;

event PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    // End:0x19
    if(bDeleteMe)
    {
        return;
    }
    // End:0x7B
    if(WorldInfo.Game != none)
    {
        Skill += WorldInfo.Game.GameDifficulty;
    }
    Skill = FClamp(Skill, 0.0000000, 3.0000000);
    //return;    
}

function Reset()
{
    super.Reset();
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local int I;
    local string T;
    local Canvas Canvas;

    Canvas = HUD.Canvas;
    super.DisplayDebug(HUD, out_YL, out_YPos);
    // End:0x53F
    if(HUD.ShouldDisplayDebug('AI'))
    {
        Canvas.DrawColor.B = 255;
        // End:0x191
        if(((Pawn != none) && MoveTarget != none) && Pawn.ReachedDestination(MoveTarget))
        {
            Canvas.DrawText((((("     Skill " $ string(Skill)) $ " NAVIGATION MoveTarget ") $ (GetItemName(string(MoveTarget)))) $ "(REACHED) MoveTimer ") $ string(MoveTimer), false);            
        }
        else
        {
            Canvas.DrawText((((("     Skill " $ string(Skill)) $ " NAVIGATION MoveTarget ") $ (GetItemName(string(MoveTarget)))) $ " MoveTimer ") $ string(MoveTimer), false);
        }
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
        Canvas.DrawText((((("      Destination " $ string(GetDestinationPosition())) $ " Focus ") $ (GetItemName(string(Focus)))) $ " Preparing Move ") $ string(bPreparingMove), false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
        Canvas.DrawText((("     RouteGoal " $ (GetItemName(string(RouteGoal)))) $ " RouteDist ") $ string(RouteDist), false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
        I = 0;
        J0x3E0:

        // End:0x4BB [Loop If]
        if(I < RouteCache.Length)
        {
            // End:0x464
            if(RouteCache[I] == none)
            {
                // End:0x45E
                if(I > 5)
                {
                    T = (T $ "--") $ (GetItemName(string(RouteCache[I - 1])));
                }
                // [Explicit Break]
                goto J0x4BB;                
            }
            else
            {
                // End:0x4AD
                if(I < 5)
                {
                    T = (T $ (GetItemName(string(RouteCache[I])))) $ "-";
                }
            }
            I++;
            // [Loop Continue]
            goto J0x3E0;
        }
        J0x4BB:

        Canvas.DrawText("     RouteCache: " $ T, false);
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
    }
    //return;    
}

event SetTeam(int inTeamIdx)
{
    WorldInfo.Game.ChangeTeam(self, inTeamIdx, true);
    //return;    
}

// Export UAIController::execGetPlayerViewPoint(FFrame&, void* const)
native function GetPlayerViewPoint(out Vector out_Location, out Rotator out_Rotation);

function NotifyWeaponFired(Weapon W, byte FireMode)
{
    //return;    
}

function NotifyWeaponFinishedFiring(Weapon W, byte FireMode)
{
    //return;    
}

function bool CanFireWeapon(Weapon Wpn, byte FireModeNum)
{
    return true;
    //return ReturnValue;    
}

state ScriptedMove
{
    event PoppedState()
    {
        // End:0x2F
        if(ScriptedRoute == none)
        {
            ClearLatentAction(Class'Engine.SeqAct_AIMoveToActor', ScriptedMoveTarget == none);
        }
        ScriptedMoveTarget = none;
        //return;        
    }

    event PushedState()
    {
        // End:0x2E
        if(Pawn != none)
        {
            Pawn.SetMovementPhysics();
        }
        //return;        
    }
    J0x00:
    // End:0xCA [Loop If]
    if(((Pawn != none) && ScriptedMoveTarget != none) && !Pawn.ReachedDestination(ScriptedMoveTarget))
    {
        // End:0x79
        if(ActorReachable(ScriptedMoveTarget))
        {
            MoveToward(ScriptedMoveTarget, ScriptedFocus);            
        }
        else
        {
            MoveTarget = FindPathToward(ScriptedMoveTarget);
            // End:0xBC
            if(MoveTarget != none)
            {
                MoveToward(MoveTarget, ScriptedFocus);                
            }
            else
            {
                ScriptedMoveTarget = none;
            }
        }
        // [Loop Continue]
        goto J0x00;
    }
    PopState();
    stop;            
}

state ScriptedRouteMove
{
    event PoppedState()
    {
        ClearLatentAction(Class'Engine.SeqAct_AIMoveToActor', ScriptedRoute == none);
        ScriptedRoute = none;
        //return;        
    }
    J0x00:
    // End:0x178 [Loop If]
    if((((Pawn != none) && ScriptedRoute != none) && ScriptedRouteIndex < ScriptedRoute.RouteList.Length) && ScriptedRouteIndex >= 0)
    {
        ScriptedMoveTarget = ScriptedRoute.RouteList[ScriptedRouteIndex].Actor;
        // End:0xC8
        if(ScriptedMoveTarget != none)
        {
            PushState('ScriptedMove');
        }
        // End:0x15F
        if((Pawn != none) && Pawn.ReachedDestination(ScriptedRoute.RouteList[ScriptedRouteIndex].Actor))
        {
            // End:0x151
            if(bReverseScriptedRoute)
            {
                ScriptedRouteIndex--;                
            }
            else
            {
                ScriptedRouteIndex++;
            }            
        }
        else
        {
            ScriptedRoute = none;
            PopState();
        }
        // [Loop Continue]
        goto J0x00;
    }
    // End:0x285
    if(((Pawn != none) && ScriptedRoute != none) && ScriptedRoute.RouteList.Length > 0)
    {
        switch(ScriptedRoute.RouteType)
        {
            // End:0x1FA
            case 0:
                PopState();
                // End:0x282
                break;
            // End:0x249
            case 1:
                bReverseScriptedRoute = !bReverseScriptedRoute;
                // End:0x231
                if(bReverseScriptedRoute)
                {
                    ScriptedRouteIndex--;                    
                }
                else
                {
                    ScriptedRouteIndex++;
                }
                goto 'Begin';
                // End:0x282
                break;
            // End:0x266
            case 2:
                ScriptedRouteIndex = 0;
                goto 'Begin';
                // End:0x282
                break;
            // End:0xFFFF
            default:
                ScriptedRoute = none;
                PopState();
                // End:0x282
                break;
                break;
        }        
    }
    else
    {
        ScriptedRoute = none;
        PopState();
    }
    ScriptedRoute = none;
    PopState();
    stop;            
}

defaultproperties
{
    bAdjustFromWalls=true
    bCanDoSpecial=true
    MinHitWall=-0.5000000
}