class ImageReflectionSceneCapture extends ImageReflection
    native(Mesh)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(ImageReflection,ImageBasedReflectionComponent,ImageReflectionSceneCapture);

var() float DepthRange;
var() float ColorRange;

defaultproperties
{
    DepthRange=200.0000000
    ColorRange=4.0000000
    // Reference: ImageBasedReflectionComponent'Engine.Default__ImageReflectionSceneCapture.ReflectionComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ReflectionComponent0'
    // Archetype: ImageBasedReflectionComponent'Engine.Default__ImageReflection.ReflectionComponent0'
    begin object name="ReflectionComponent0"
        ReplacementPrimitive=none
    end object
    ImageReflectionComponent=ReflectionComponent0
    Components[0]=ReflectionComponent0
}