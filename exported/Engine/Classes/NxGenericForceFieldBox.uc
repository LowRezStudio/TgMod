class NxGenericForceFieldBox extends NxGenericForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var export editinline DrawBoxComponent RenderComponent;
var() interp Vector BoxExtent;

// Export UNxGenericForceFieldBox::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    // Reference: DrawBoxComponent'Engine.Default__NxGenericForceFieldBox.DrawBox0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawBox0'
    begin object name="DrawBox0" class=Engine.DrawBoxComponent
        BoxColor=(R=64,G=70,B=255,A=255)
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawBox0
    BoxExtent=(X=200.0000000,Y=200.0000000,Z=200.0000000)
    Components[0]=DrawBox0
    Components[1]=none
}