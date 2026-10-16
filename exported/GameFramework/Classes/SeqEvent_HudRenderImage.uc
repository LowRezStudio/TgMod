class SeqEvent_HudRenderImage extends SeqEvent_HudRender
    hidecategories(Object);

var(HUD) LinearColor DisplayColor;
var(HUD) Vector DisplayLocation;
var(HUD) Texture2D DisplayTexture;
var(HUD) float XL;
var(HUD) float YL;
var(HUD) float U;
var(HUD) float V;
var(HUD) float UL;
var(HUD) float VL;

function Render(Canvas TargetCanvas, HUD TargetHud)
{
    local float UsedX, UsedY, UsedXL, UsedYL, GlobalScaleX, GlobalScaleY;

    // End:0x305
    if(bIsActive)
    {
        PublishLinkedVariableValues();
        GlobalScaleX = Class'GameFramework.MobileMenuScene'.static.GetGlobalScaleX() / AuthoredGlobalScale;
        GlobalScaleY = Class'GameFramework.MobileMenuScene'.static.GetGlobalScaleY() / AuthoredGlobalScale;
        UsedX = ((DisplayLocation.X < 1.0000000) ? DisplayLocation.X * float(TargetCanvas.SizeX) : DisplayLocation.X * GlobalScaleX);
        UsedY = ((DisplayLocation.Y < 1.0000000) ? DisplayLocation.Y * float(TargetCanvas.SizeY) : DisplayLocation.Y * GlobalScaleY);
        UsedXL = ((XL <= 1.0000000) ? XL * float(TargetCanvas.SizeX) : XL * GlobalScaleX);
        UsedYL = ((YL <= 1.0000000) ? YL * float(TargetCanvas.SizeX) : YL * GlobalScaleY);
        TargetCanvas.SetPos(UsedX, UsedY);
        TargetCanvas.DrawTile(DisplayTexture, UsedXL, UsedYL, U, V, UL, VL, DisplayColor);
    }
    //return;    
}

defaultproperties
{
    DisplayColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Active",LinkVar="None",PropertyName="bIsActive",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Display Location",LinkVar="None",PropertyName="DisplayLocation",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Draw Image"
}