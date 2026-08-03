class SpeedTreeActor extends Actor
    native(SpeedTree)
    placeable
    hidecategories(Navigation);

var() const editconst export editinline SpeedTreeComponent SpeedTreeComponent;

defaultproperties
{
    // Reference: SpeedTreeComponent'Engine.Default__SpeedTreeActor.SpeedTreeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SpeedTreeComponent0'
    begin object name="SpeedTreeComponent0" class=Engine.SpeedTreeComponent
        ReplacementPrimitive=none
        bAllowApproximateOcclusion=true
        bForceDirectLightMap=true
    end object
    SpeedTreeComponent=SpeedTreeComponent0
    Components[0]=SpeedTreeComponent0
    bStatic=true
    bNoDelete=true
    bWorldGeometry=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    CollisionComponent=SpeedTreeComponent0
}