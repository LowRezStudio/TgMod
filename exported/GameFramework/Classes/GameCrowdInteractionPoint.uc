class GameCrowdInteractionPoint extends Actor
    abstract
    native
    placeable
    hidecategories(Navigation,Advanced,Collision,Display,Actor,Movement,Physics)
    classgroup(Crowd);

var() bool bIsEnabled;
var() export editinline CylinderComponent CylinderComponent;

replication
{
    // Pos:0x000
    if(bNoDelete)
        bIsEnabled;
}

function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bIsEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bIsEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bIsEnabled = !bIsEnabled;
            }
        }
    }
    ForceNetRelevant();
    //return;    
}

defaultproperties
{
    bIsEnabled=true
    // Reference: CylinderComponent'GameFramework.Default__GameCrowdInteractionPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=40.0000000
        CollisionRadius=200.0000000
        CylinderColor=(R=0,G=255,B=0,A=255)
        bDrawBoundingBox=false
        bDrawNonColliding=true
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bNoDelete=true
    CollisionComponent=CollisionCylinder
}