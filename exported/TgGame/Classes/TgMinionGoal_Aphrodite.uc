class TgMinionGoal_Aphrodite extends TgMinionGoal
    native(AI)
    hidecategories(Navigation,Lighting,LightColor,Force);

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgMinionGoal_Aphrodite.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgMinionGoal.CollisionCylinder'
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
    bStatic=false
    bNoDelete=false
    CollisionComponent=CollisionCylinder
}