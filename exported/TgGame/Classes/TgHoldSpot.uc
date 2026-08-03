class TgHoldSpot extends TgDefensePoint
    hidecategories(Navigation,Lighting,LightColor,Force);

var Vehicle HoldVehicle;

function Actor GetMoveTarget()
{
    // End:0x3E
    if(HoldVehicle != none)
    {
        // End:0x3E
        if(HoldVehicle.Health <= 0)
        {
            HoldVehicle = none;
        }
    }
    return self;
    //return ReturnValue;    
}

function FreePoint()
{
    Destroy();
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgHoldSpot.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgDefensePoint.CollisionCylinder'
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
    bNoDelete=false
    bCollideWhenPlacing=false
    CollisionComponent=CollisionCylinder
}