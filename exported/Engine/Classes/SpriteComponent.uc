class SpriteComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() Texture2D Sprite;
var() bool bIsScreenSizeScaled;
var() float ScreenSize;
var() float U;
var() float UL;
var() float V;
var() float VL;

// Export USpriteComponent::execSetSprite(FFrame&, void* const)
native simulated function SetSprite(Texture2D NewSprite);

// Export USpriteComponent::execSetUV(FFrame&, void* const)
native simulated function SetUV(int NewU, int NewUL, int NewV, int NewVL);

// Export USpriteComponent::execSetSpriteAndUV(FFrame&, void* const)
native simulated function SetSpriteAndUV(Texture2D NewSprite, int NewU, int NewUL, int NewV, int NewVL);

defaultproperties
{
    ScreenSize=0.1000000
    ReplacementPrimitive=none
}