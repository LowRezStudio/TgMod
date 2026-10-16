class SplineLoftActorMovable extends SplineLoftActor
    native(Spline)
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__SplineLoftActorMovable.MyMeshLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyMeshLightEnvironment'
    begin object name="MyMeshLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
    end object
    MeshLightEnvironment=MyMeshLightEnvironment
    Components[0]=none
    Components[1]=MyMeshLightEnvironment
    Physics=EPhysics.PHYS_Interpolating
    bStatic=false
    bNoDelete=true
    bMovable=true
}