class DoorMarker extends NavigationPoint
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

enum EDoorType
{
    DOOR_Shoot,                     // 0
    DOOR_Touch,                     // 1
    DOOR_MAX                        // 2
};

var() InterpActor MyDoor;
var() DoorMarker.EDoorType DoorType;
var() Actor DoorTrigger;
var() bool bWaitUntilCompletelyOpened;
var() bool bInitiallyClosed;
var() bool bBlockedWhenClosed;
var bool bDoorOpen;
var const transient bool bTempDisabledCollision;

event PostBeginPlay()
{
    bBlocked = bInitiallyClosed && bBlockedWhenClosed;
    bDoorOpen = !bInitiallyClosed;
    super(Actor).PostBeginPlay();
    //return;    
}

function MoverOpened()
{
    bBlocked = !bInitiallyClosed && bBlockedWhenClosed;
    bDoorOpen = bInitiallyClosed;
    WorldInfo.Game.NotifyNavigationChanged(self);
    //return;    
}

function MoverClosed()
{
    bBlocked = bInitiallyClosed && bBlockedWhenClosed;
    bDoorOpen = !bInitiallyClosed;
    WorldInfo.Game.NotifyNavigationChanged(self);
    //return;    
}

event Actor SpecialHandling(Pawn Other)
{
    local Actor TouchActor;

    // End:0x6A
    if((bDoorOpen || MyDoor == none) || bInitiallyClosed == (bDoorOpen || VSizeSq(MyDoor.Velocity) > 1.0000000))
    {
        return self;        
    }
    else
    {
        // End:0xFB
        if(int(DoorType) == int(1))
        {
            // End:0x9A
            if(DoorTrigger == none)
            {
                return MyDoor;                
            }
            else
            {
                TouchActor = DoorTrigger.SpecialHandling(Other);
                // End:0xEE
                if(TouchActor == none)
                {
                    TouchActor = DoorTrigger;
                }
                return TouchActor;
            }            
        }
        else
        {
            return self;
        }
    }
    //return ReturnValue;    
}

function bool ProceedWithMove(Pawn Other)
{
    // End:0x8B
    if((int(DoorType) == int(0)) && Other.Controller.Focus == MyDoor)
    {
        Other.Controller.StopFiring();
    }
    // End:0xB0
    if(bDoorOpen || int(DoorType) != int(0))
    {
        return true;
    }
    Other.Controller.Focus = ((DoorTrigger != none) ? DoorTrigger : MyDoor);
    // End:0x1AF
    if(!Other.Controller.FireWeaponAt(Other.Controller.Focus))
    {
        Other.Controller.MoveTimer = 0.2500000;        
    }
    else
    {
        // End:0x1F9
        if(bWaitUntilCompletelyOpened)
        {
            Other.Controller.WaitForMover(MyDoor);
        }
    }
    return false;
    //return ReturnValue;    
}

event bool SuggestMovePreparation(Pawn Other)
{
    // End:0x23
    if(bDoorOpen || MyDoor == none)
    {
        return false;        
    }
    else
    {
        // End:0x8F
        if(VSizeSq(MyDoor.Velocity) > 1.0000000)
        {
            Other.Controller.WaitForMover(MyDoor);
            return true;            
        }
        else
        {
            // End:0x264
            if(int(DoorType) == int(0))
            {
                Other.Controller.Focus = ((DoorTrigger != none) ? DoorTrigger : MyDoor);
                // End:0x1DA
                if(!Other.Controller.FireWeaponAt(Other.Controller.Focus))
                {
                    Other.Controller.MoveTimer = 0.2500000;
                    Other.Controller.bPreparingMove = true;
                    return true;                    
                }
                else
                {
                    // End:0x25F
                    if(bWaitUntilCompletelyOpened)
                    {
                        Other.Controller.WaitForMover(MyDoor);
                        Other.Controller.bPreparingMove = true;
                        return true;                        
                    }
                    else
                    {
                        return false;
                    }
                }                
            }
            else
            {
                // End:0x418
                if(((int(DoorType) == int(1)) && DoorTrigger != none) && Other.Controller.ActorReachable(DoorTrigger))
                {
                    // End:0x36C
                    if(Other.Controller.Focus == Other.Controller.MoveTarget)
                    {
                        Other.Controller.Focus = DoorTrigger;
                    }
                    Other.Controller.MoveTarget = DoorTrigger;
                    Other.Controller.CurrentPath = none;
                    Other.Controller.NextRoutePath = none;
                    return false;                    
                }
                else
                {
                    return false;
                }
            }
        }
    }
    //return ReturnValue;    
}

defaultproperties
{
    bInitiallyClosed=true
    bSpecialMove=true
    ExtraCost=100
    // Reference: CylinderComponent'Engine.Default__DoorMarker.CollisionCylinder'
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