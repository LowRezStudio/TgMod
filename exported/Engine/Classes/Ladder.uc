class Ladder extends NavigationPoint
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

var LadderVolume MyLadder;
var Ladder LadderList;

event bool SuggestMovePreparation(Pawn Other)
{
    // End:0x11
    if(MyLadder == none)
    {
        return false;
    }
    // End:0x68
    if(!MyLadder.InUse(Other))
    {
        MyLadder.PendingClimber = Other;
        return false;
    }
    Other.Controller.bPreparingMove = true;
    Other.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    bSpecialMove=true
    bNotBased=true
    // Reference: CylinderComponent'Engine.Default__Ladder.CollisionCylinder'
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