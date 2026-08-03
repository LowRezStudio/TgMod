class SceneCaptureReflectActor extends SceneCaptureActor
    native
    placeable
    hidecategories(Navigation);

var() const export editinline StaticMeshComponent StaticMesh;
var transient MaterialInstanceConstant ReflectMaterialInst;

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__SceneCaptureReflectActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    begin object name="StaticMeshComponent0" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        HiddenGame=true
        CastShadow=false
        bAcceptsLights=false
        CollideActors=false
        Scale3D=(X=4.0000000,Y=4.0000000,Z=4.0000000)
    end object
    StaticMesh=StaticMeshComponent0
    // Reference: SceneCaptureReflectComponent'Engine.Default__SceneCaptureReflectActor.SceneCaptureReflectComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCaptureReflectComponent0'
    begin object name="SceneCaptureReflectComponent0" class=Engine.SceneCaptureReflectComponent
        bSkipUpdateIfTextureUsersOccluded=true
    end object
    SceneCapture=SceneCaptureReflectComponent0
    Components[0]=none
    Components[1]=SceneCaptureReflectComponent0
    Components[2]=StaticMeshComponent0
    Rotation=(Pitch=16384,Yaw=0,Roll=0)
}