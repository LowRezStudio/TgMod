class SeqEvent_HudRenderText extends SeqEvent_HudRender
    hidecategories(Object);

enum ETextDrawMethod
{
    DRAW_CenterText,                // 0
    DRAW_WrapText,                  // 1
    DRAW_MAX                        // 2
};

var(HUD) Font DisplayFont;
var(HUD) Color DisplayColor;
var(HUD) Vector DisplayLocation;
var(HUD) string DisplayText;
var(HUD) SeqEvent_HudRenderText.ETextDrawMethod TextDrawMethod;

function Render(Canvas TargetCanvas, HUD TargetHud)
{
    local float XL, YL, UsedX, UsedY, UsedScaleX, UsedScaleY,
	    GlobalScaleX, GlobalScaleY;

    // End:0x39C
    if(bIsActive)
    {
        PublishLinkedVariableValues();
        // End:0x4E
        if(DisplayFont != none)
        {
            TargetCanvas.Font = DisplayFont;
        }
        GlobalScaleX = Class'GameFramework.MobileMenuScene'.static.GetGlobalScaleX() / AuthoredGlobalScale;
        GlobalScaleY = Class'GameFramework.MobileMenuScene'.static.GetGlobalScaleY() / AuthoredGlobalScale;
        UsedX = ((DisplayLocation.X < 1.0000000) ? DisplayLocation.X * float(TargetCanvas.SizeX) : DisplayLocation.X * GlobalScaleX);
        UsedY = ((DisplayLocation.Y < 1.0000000) ? DisplayLocation.Y * float(TargetCanvas.SizeY) : DisplayLocation.Y * GlobalScaleY);
        UsedScaleX = GlobalScaleX;
        UsedScaleY = GlobalScaleY;
        TargetCanvas.DrawColor = DisplayColor;
        // End:0x2B8
        if(int(TextDrawMethod) == int(1))
        {
            TargetCanvas.SetPos(UsedX, UsedY);
            TargetCanvas.DrawText(DisplayText,, UsedScaleX, UsedScaleY);            
        }
        else
        {
            // End:0x39C
            if(int(TextDrawMethod) == int(0))
            {
                TargetCanvas.TextSize(DisplayText, XL, YL);
                XL *= UsedScaleX;
                TargetCanvas.SetPos(UsedX - (XL / float(2)), UsedY);
                TargetCanvas.DrawText(DisplayText,, UsedScaleX, UsedScaleY);
            }
        }
    }
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    DisplayColor=(R=255,G=255,B=255,A=255)
    TextDrawMethod=ETextDrawMethod.DRAW_WrapText
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Bool',LinkedVariables=none,LinkDesc="Active",LinkVar="None",PropertyName="bIsActive",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Display Location",LinkVar="None",PropertyName="DisplayLocation",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[3]=(ExpectedType=Class'Engine.SeqVar_String',LinkedVariables=none,LinkDesc="Display Text",LinkVar="None",PropertyName="DisplayText",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Draw Text"
}