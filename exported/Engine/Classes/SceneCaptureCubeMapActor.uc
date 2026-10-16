class SceneCaptureCubeMapActor extends SceneCaptureActor
    native
    placeable
    hidecategories(Navigation);

var const export editinline StaticMeshComponent StaticMesh;
var transient MaterialInstanceConstant CubeMaterialInst;

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__SceneCaptureCubeMapActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    begin object name="StaticMeshComponent0" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        HiddenGame=true
        CastShadow=false
        bAcceptsLights=false
        CollideActors=false
        Scale3D=(X=0.6000000,Y=0.6000000,Z=0.6000000)
    end object
    StaticMesh=StaticMeshComponent0
    // Reference: SceneCaptureCubeMapComponent'Engine.Default__SceneCaptureCubeMapActor.SceneCaptureCubeMapComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCaptureCubeMapComponent0'
    begin object name="SceneCaptureCubeMapComponent0" class=Engine.SceneCaptureCubeMapComponent
    end object
    SceneCapture=SceneCaptureCubeMapComponent0
    Components[0]=SceneCaptureCubeMapComponent0
    Components[1]=StaticMeshComponent0
}