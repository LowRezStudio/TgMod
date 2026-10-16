class TgSplineLoftActorSpawnable extends SplineLoftActorMovable
    native
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSplineLoftActorSpawnable.MyMeshLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyMeshLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SplineLoftActorMovable.MyMeshLightEnvironment'
    begin object name="MyMeshLightEnvironment"
    end object
    MeshLightEnvironment=MyMeshLightEnvironment
    Components[0]=none
    Components[1]=MyMeshLightEnvironment
    bNoDelete=false
}