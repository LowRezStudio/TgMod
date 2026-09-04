class AISwitchablePylon extends Pylon
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force,Lighting,LightColor,Force);

var() bool bOpen;

function PostBeginPlay()
{
    super.PostBeginPlay();
    SetEnabled(bOpen);
    //return;    
}

event SetEnabled(bool bEnabled)
{
    bOpen = bEnabled;
    bForceObstacleMeshCollision = !bOpen;
    //return;    
}

event bool IsEnabled()
{
    return bOpen;
    //return ReturnValue;    
}

defaultproperties
{
    bNeedsCostCheck=true
    // Reference: CylinderComponent'Engine.Default__AISwitchablePylon.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Pylon.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    Components[5]=none
    Components[6]=none
    Components[7]=none
    CollisionComponent=CollisionCylinder
}