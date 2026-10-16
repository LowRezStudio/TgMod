class SceneCapture2DActor extends SceneCaptureActor
    native
    placeable
    hidecategories(Navigation);

var const export editinline DrawFrustumComponent DrawFrustum;

defaultproperties
{
    // Reference: DrawFrustumComponent'Engine.Default__SceneCapture2DActor.DrawFrust0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawFrust0'
    begin object name="DrawFrust0" class=Engine.DrawFrustumComponent
        FrustumColor=(R=255,G=255,B=255,A=255)
        ReplacementPrimitive=none
    end object
    DrawFrustum=DrawFrust0
    // Reference: SceneCapture2DComponent'Engine.Default__SceneCapture2DActor.SceneCapture2DComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCapture2DComponent0'
    begin object name="SceneCapture2DComponent0" class=Engine.SceneCapture2DComponent
    end object
    SceneCapture=SceneCapture2DComponent0
    Components[0]=SceneCapture2DComponent0
    Components[1]=none
    Components[2]=DrawFrust0
}