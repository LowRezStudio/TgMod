class TgLobbyCaptureActor extends SceneCapture2DActor
    native(View)
    hidecategories(Navigation);

var(CameraActor) TgSkeletalMeshActor_Lobby m_ViewTarget;

defaultproperties
{
    // Reference: DrawFrustumComponent'TgGame.Default__TgLobbyCaptureActor.DrawFrust0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawFrust0'
    // Archetype: DrawFrustumComponent'Engine.Default__SceneCapture2DActor.DrawFrust0'
    begin object name="DrawFrust0"
        ReplacementPrimitive=none
    end object
    DrawFrustum=DrawFrust0
    // Reference: SceneCapture2DComponent'TgGame.Default__TgLobbyCaptureActor.SceneCapture2DComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCapture2DComponent0'
    // Archetype: SceneCapture2DComponent'Engine.Default__SceneCapture2DActor.SceneCapture2DComponent0'
    begin object name="SceneCapture2DComponent0"
    end object
    SceneCapture=SceneCapture2DComponent0
    Components[0]=SceneCapture2DComponent0
    Components[1]=none
    Components[2]=DrawFrust0
}