class SceneCapturePortalActor extends SceneCaptureReflectActor
    native
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__SceneCapturePortalActor.StaticMeshComponent2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent2'
    begin object name="StaticMeshComponent2" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        HiddenGame=true
        CastShadow=false
        CollideActors=false
        AlwaysLoadOnClient=false
        AlwaysLoadOnServer=false
    end object
    StaticMesh=StaticMeshComponent2
    // Reference: SceneCapturePortalComponent'Engine.Default__SceneCapturePortalActor.SceneCapturePortalComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCapturePortalComponent0'
    begin object name="SceneCapturePortalComponent0" class=Engine.SceneCapturePortalComponent
    end object
    SceneCapture=SceneCapturePortalComponent0
    Components[0]=SceneCapturePortalComponent0
    Components[1]=none
    Components[2]=StaticMeshComponent2
    Rotation=(Pitch=0,Yaw=0,Roll=0)
}