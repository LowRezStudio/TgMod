class MobileMenuElement extends Object;

var Vector2D VpPos;
var Vector2D VpSize;
var bool bIsVisible;
var bool bIsActive;

function bool OnTouch(Interaction.ETouchType EventType, float TouchX, float TouchY, float DeltaTime)
{
    return false;
    //return ReturnValue;    
}

function RenderElement(MobileMenuObject Owner, Canvas Canvas, float DeltaTime, float Opacity)
{
    //return;    
}

defaultproperties
{
    bIsVisible=true
    bIsActive=true
}