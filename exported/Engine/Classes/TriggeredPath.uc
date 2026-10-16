class TriggeredPath extends NavigationPoint
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

var() bool bOpen;
var() Actor MyTrigger;

function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bOpen = true;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bOpen = false;            
        }
        else
        {
            // End:0xDB
            if(inAction.InputLinks[2].bHasImpulse)
            {
                bOpen = !bOpen;
            }
        }
    }
    WorldInfo.Game.NotifyNavigationChanged(self);
    //return;    
}

event Actor SpecialHandling(Pawn Other)
{
    local Actor TouchActor;

    // End:0x23
    if(bOpen || MyTrigger == none)
    {
        return self;        
    }
    else
    {
        TouchActor = MyTrigger.SpecialHandling(Other);
        // End:0x77
        if(TouchActor == none)
        {
            TouchActor = MyTrigger;
        }
        return TouchActor;
    }
    //return ReturnValue;    
}

event bool SuggestMovePreparation(Pawn Other)
{
    // End:0x12
    if(bOpen)
    {
        return false;        
    }
    else
    {
        // End:0x1B0
        if((MyTrigger != none) && Other.Controller.ActorReachable(MyTrigger))
        {
            // End:0x104
            if(Other.Controller.Focus == Other.Controller.MoveTarget)
            {
                Other.Controller.Focus = MyTrigger;
            }
            Other.Controller.MoveTarget = MyTrigger;
            Other.Controller.CurrentPath = none;
            Other.Controller.NextRoutePath = none;
            return false;            
        }
        else
        {
            Other.Controller.MoveTimer = 1.0000000;
            Other.Controller.bPreparingMove = true;
            Other.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
            Other.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
            return true;
        }
    }
    //return ReturnValue;    
}

defaultproperties
{
    bSpecialMove=true
    ExtraCost=100
    // Reference: CylinderComponent'Engine.Default__TriggeredPath.CollisionCylinder'
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