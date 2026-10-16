class LadderVolume extends PhysicsVolume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

var() Rotator WallDir;
var() bool m_bBotOnly;
var() bool bNoPhysicalLadder;
var() bool bAutoPath;
var() bool bAllowLadderStrafing;
var Vector LookDir;
var Vector ClimbDir;
var const Ladder LadderList;
var Pawn PendingClimber;
var export editinline ArrowComponent WallDirArrow;
var export editinline ArrowComponent m_WallDirArrow;

simulated event PostBeginPlay()
{
    local Ladder L, M;
    local Vector Dir;

    super.PostBeginPlay();
    LookDir = Vector(WallDir);
    // End:0x1EF
    if(!bAutoPath && LookDir.Z != float(0))
    {
        ClimbDir = vect(0.0000000, 0.0000000, 1.0000000);
        L = LadderList;
        J0x7E:

        // End:0x1A8 [Loop If]
        if(L != none)
        {
            M = LadderList;
            J0xA0:

            // End:0x17D [Loop If]
            if(M != none)
            {
                // End:0x152
                if(M != L)
                {
                    Dir = Normal(M.Location - L.Location);
                    // End:0x13E
                    if((Dir Dot ClimbDir) < float(0))
                    {
                        Dir *= float(-1);
                    }
                    ClimbDir += Dir;
                }
                M = M.LadderList;
                // [Loop Continue]
                goto J0xA0;
            }
            L = L.LadderList;
            // [Loop Continue]
            goto J0x7E;
        }
        ClimbDir = Normal(ClimbDir);
        // End:0x1EF
        if((ClimbDir Dot vect(0.0000000, 0.0000000, 1.0000000)) < float(0))
        {
            ClimbDir *= float(-1);
        }
    }
    //return;    
}

function bool InUse(Pawn Ignored)
{
    return false;
    //return ReturnValue;    
}

simulated event PawnEnteredVolume(Pawn P)
{
    super.PawnEnteredVolume(P);
    // End:0x39
    if(!P.CanGrabLadder())
    {
        return;
    }
    //return;    
}

simulated event PawnLeavingVolume(Pawn P)
{
    local Controller C;

    // End:0x26
    if(P.OnLadder != self)
    {
        return;
    }
    super.PawnLeavingVolume(P);
    P.OnLadder = none;
    P.EndClimbLadder(self);
    // End:0x9B
    if(P == PendingClimber)
    {
        PendingClimber = none;
    }
    return;
    // End:0x1CC
    if(!InUse(P))
    {
        // End:0x1CB
        foreach WorldInfo.AllControllers(Class'Engine.Controller', C)
        {
            // End:0x1CA
            if((C.bPreparingMove && Ladder(C.MoveTarget) != none) && Ladder(C.MoveTarget).MyLadder == self)
            {
                C.bPreparingMove = false;
                PendingClimber = C.Pawn;                
                return;
            }            
        }        
    }
    //return;    
}

simulated event PhysicsChangedFor(Actor Other)
{
    // End:0xC3
    if(((((int(Other.Physics) == int(2)) || int(Other.Physics) == int(9)) || Other.bDeleteMe) || Pawn(Other) == none) || Pawn(Other).Controller == none)
    {
        return;
    }
    Spawn(Class'Engine.PotentialClimbWatcher', Other);
    //return;    
}

defaultproperties
{
    bAutoPath=true
    bAllowLadderStrafing=true
    ClimbDir=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    // Reference: BrushComponent'Engine.Default__LadderVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    CollisionComponent=BrushComponent0
}