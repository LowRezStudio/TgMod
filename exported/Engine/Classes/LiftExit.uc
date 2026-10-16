class LiftExit extends NavigationPoint
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

var() LiftCenter MyLiftCenter;
var() bool bExitOnly;

function bool CanBeReachedFromLiftBy(Pawn Other)
{
    return (Location.Z < (Other.Location.Z + Other.GetCollisionHeight())) && Other.LineOfSightTo(self);
    //return ReturnValue;    
}

function WaitForLift(Pawn Other)
{
    // End:0xAF
    if(MyLiftCenter != none)
    {
        Other.SetDesiredRotation(Rotator(Location - Other.Location));
        Other.Controller.WaitForMover(MyLiftCenter.MyLift);
    }
    //return;    
}

event bool SuggestMovePreparation(Pawn Other)
{
    local Controller C;

    // End:0x37
    if((MyLiftCenter == none) || Other.Controller == none)
    {
        return false;
    }
    // End:0x10E
    if(int(Other.Physics) == int(4))
    {
        // End:0x10C
        if(Other.AirSpeed > float(0))
        {
            Other.Controller.MoveTimer = 2.0000000 + (VSize(Location - Other.Location) / Other.AirSpeed);
        }
        return false;
    }
    // End:0x1AC
    if((Other.Base == MyLiftCenter.Base) || Other.ReachedDestination(MyLiftCenter))
    {
        // End:0x194
        if(CanBeReachedFromLiftBy(Other))
        {
            return false;
        }
        WaitForLift(Other);
        return true;        
    }
    else
    {
        // End:0x33C
        if(MyLiftCenter != none)
        {
            // End:0x307
            foreach WorldInfo.AllControllers(Class'Engine.Controller', C)
            {
                // End:0x306
                if((((C.Pawn != none) && C.PendingMover == MyLiftCenter.MyLift) && WorldInfo.GRI.OnSameTeam(C, Other.Controller)) && C.Pawn.ReachedDestination(self))
                {
                    WaitForLift(Other);                    
                    return true;
                }                
            }            
            Other.Controller.ReadyForLift();
        }
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    bNeverUseStrafing=true
    bForceNoStrafing=true
    bSpecialMove=true
    // Reference: CylinderComponent'Engine.Default__LiftExit.CollisionCylinder'
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
    CollisionComponent=CollisionCylinder
}