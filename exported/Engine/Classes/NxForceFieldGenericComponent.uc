class NxForceFieldGenericComponent extends NxForceFieldComponent
    native(ForceField)
    editinlinenew
    collapsecategories
    hidecategories(Collision,Lighting,Physics,Rendering,Object);

var() float RoughExtentX;
var() float RoughExtentY;
var() float RoughExtentZ;
var() NxForceFieldGeneric.FFG_ForceFieldCoordinates Coordinates;
var() Vector Constant;
var() Vector PositionMultiplierX;
var() Vector PositionMultiplierY;
var() Vector PositionMultiplierZ;
var() Vector PositionTarget;
var() Vector VelocityMultiplierX;
var() Vector VelocityMultiplierY;
var() Vector VelocityMultiplierZ;
var() Vector VelocityTarget;
var() Vector Noise;
var() Vector FalloffLinear;
var() Vector FalloffQuadratic;
var() float TorusRadius;
var native const transient Pointer Kernel;

defaultproperties
{
    RoughExtentX=200.0000000
    RoughExtentY=200.0000000
    RoughExtentZ=200.0000000
    TorusRadius=1.0000000
    // Reference: ForceFieldShapeBox'Engine.Default__NxForceFieldGenericComponent.Shape0'
    begin object name="Shape0" class=Engine.ForceFieldShapeBox
        // Reference: DrawBoxComponent'Engine.Default__NxForceFieldGenericComponent.Shape0.DrawBox0'
        // TemplateOwnerClass: none
        // TemplateOwnerName: 'DrawBox0'
        // Archetype: DrawBoxComponent'Engine.Default__ForceFieldShapeBox.DrawBox0'
        begin object name="DrawBox0"
            ReplacementPrimitive=none
        end object
        Shape=DrawBox0
    end object
    Shape=Shape0
    ReplacementPrimitive=none
}