class RadialBlurActor extends Actor
    placeable
    hidecategories(Navigation);

var() export editinline RadialBlurComponent RadialBlur;

defaultproperties
{
    // Reference: RadialBlurComponent'Engine.Default__RadialBlurActor.RadialBlurComp'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RadialBlurComp'
    begin object name="RadialBlurComp" class=Engine.RadialBlurComponent
    end object
    RadialBlur=RadialBlurComp
    Components[0]=RadialBlurComp
    Components[1]=none
}