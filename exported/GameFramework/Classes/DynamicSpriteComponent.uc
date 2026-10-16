class DynamicSpriteComponent extends SpriteComponent
    native
    editinlinenew
    hidecategories(Object);

var() InterpCurveFloat AnimatedScale;
var() InterpCurveLinearColor AnimatedColor;
var() InterpCurveVector2D AnimatedPosition;
var() Vector LocationOffset;
var() int LoopCount;

defaultproperties
{
    LoopCount=-1
    ReplacementPrimitive=none
}