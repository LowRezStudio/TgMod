class TgFogOfWarBarrier extends StaticMeshActor
    native
    hidecategories(Navigation);

var() bool m_bOneDirectional;
var() float m_fBlockMinimumDistance;

defaultproperties
{
    m_fBlockMinimumDistance=480.0000000
    // Reference: StaticMeshComponent'TgGame.Default__TgFogOfWarBarrier.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgFogOfWarBarrier.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgFogOfWarBarrier.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    Components[2]=none
    bWorldGeometry=false
    bBlockActors=false
    CollisionComponent=StaticMeshComponent0
}