class VolumePathNode extends PathNode
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

var() float StartingRadius;
var() float StartingHeight;

defaultproperties
{
    StartingRadius=2000.0000000
    StartingHeight=2000.0000000
    bNoAutoConnect=true
    bNotBased=true
    bFlyingPreferred=true
    bVehicleDestination=true
    bBuildLongPaths=false
    // Reference: CylinderComponent'Engine.Default__VolumePathNode.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PathNode.CollisionCylinder'
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