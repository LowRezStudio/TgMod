class LiftCenter extends NavigationPoint
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

var InterpActor MyLift;
var float MaxDist2D;
var Vector LiftOffset;
var bool bJumpLift;
var float CollisionHeight;
var() Trigger LiftTrigger;

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    // End:0x86
    if((Base == MyLift) && MyLift != none)
    {
        LiftOffset = Location - MyLift.Location;
        MyLift.bIsLift = true;
    }
    //return;    
}

event Actor SpecialHandling(Pawn Other)
{
    // End:0x49
    if(((MyLift == none) || LiftTrigger == none) || LiftTrigger.bRecentlyTriggered)
    {
        return self;        
    }
    else
    {
        return LiftTrigger;
    }
    //return ReturnValue;    
}

event bool SuggestMovePreparation(Pawn Other)
{
    // End:0x2E
    if(Other.Base == MyLift)
    {
        return false;
    }
    // End:0xB9
    if((Base != MyLift) || Location != (MyLift.Location + LiftOffset))
    {
        SetLocation(MyLift.Location + LiftOffset);
        SetBase(MyLift);
    }
    // End:0x138
    if(!IsZero(MyLift.Velocity) || !ProceedWithMove(Other))
    {
        Other.Controller.WaitForMover(MyLift);
        return true;
    }
    return false;
    //return ReturnValue;    
}

function bool ProceedWithMove(Pawn Other)
{
    // End:0x29
    if(Other.Controller == none)
    {
        return false;        
    }
    else
    {
        // End:0xEF
        if((LiftExit(Other.Controller.MoveTarget) != none) && Other.ReachedDestination(self))
        {
            return LiftExit(Other.Controller.MoveTarget).CanBeReachedFromLiftBy(Other);            
        }
        else
        {
            // End:0x2DB
            if((((Location.Z - CollisionHeight) < (((Other.Location.Z - Other.GetCollisionHeight()) + Other.MaxStepHeight) + 2.0000000)) && (Location.Z - CollisionHeight) > ((Other.Location.Z - Other.GetCollisionHeight()) - float(1200))) && (VSize2D(Location - Other.Location) < MaxDist2D) || (IsZero(MyLift.Velocity) && Other.ValidAnchor()) && LiftExit(Other.Anchor) != none)
            {
                return true;
            }
        }
    }
    // End:0x360
    if(((LiftTrigger != none) && !LiftTrigger.bRecentlyTriggered) && IsZero(MyLift.Velocity))
    {
        Other.SetMoveTarget(LiftTrigger);
        return true;
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    MaxDist2D=400.0000000
    CollisionHeight=50.0000000
    bNeverUseStrafing=true
    bForceNoStrafing=true
    bSpecialMove=true
    bNoAutoConnect=true
    ExtraCost=400
    // Reference: CylinderComponent'Engine.Default__LiftCenter.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__NavigationPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    bStatic=false
    CollisionComponent=CollisionCylinder
}