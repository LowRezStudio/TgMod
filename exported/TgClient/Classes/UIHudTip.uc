class UIHudTip extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

var int m_nHudTipId;
var int m_nHudSpecialTipId;
var int m_nWorldTipId;
var float m_fPromptAnimTimer;
var GFxObject m_mcHudTip;
var GFxObject m_mcHudTipIcon;
var GFxObject m_mcHudTipName;
var GFxObject m_mcHudTipDesc;
var GFxObject m_mcHudSpecialTip;
var GFxObject m_mcHudSpecialTipText;
var GFxObject m_mcHudSpecialTipAnimA;
var GFxObject m_mcHudSpecialTipAnimB;
var GFxObject m_mcHudSpecialTipFrame;
var GFxObject m_mcHudSpecialTipPrompt;
var GFxObject m_mcWorldTip;
var GFxObject m_mcWorldTipIcon;
var GFxObject m_mcWorldTipName;
var GFxObject m_mcWorldTipDesc;

event bool GetScreenCoordinates(Canvas pCanvas, Vector CameraLocation, Vector CameraRotation, Vector ObjectLocation, out Vector ScreenLocation)
{
    local bool bBehind;
    local float fClipX, fClipY, fLimitX, fLimitY, fBase, fLineSlope,
	    fLineConstant;

    local Vector ScreenDirection;

    fBase = 0.0000000;
    fClipX = pCanvas.ClipX;
    fClipY = pCanvas.ClipY;
    fLimitX = fClipX - fBase;
    fLimitY = fClipY - fBase;
    ScreenLocation = pCanvas.Project(ObjectLocation);
    bBehind = (CameraRotation Dot (ObjectLocation - CameraLocation)) <= 0.0000000;
    // End:0x1B9
    if(((((ScreenLocation.X > fBase) && ScreenLocation.X < fLimitX) && ScreenLocation.Y > float(0)) && ScreenLocation.Y < fLimitY) && !bBehind)
    {
        return false;
    }
    ScreenDirection = pCanvas.Project(CameraLocation + Normal(ObjectLocation - CameraLocation));
    // End:0x25A
    if(((fClipX / 2.0000000) - ScreenDirection.X) == float(0))
    {
        ScreenDirection.X -= float(1);
    }
    fLineSlope = ((fClipY / 2.0000000) - ScreenDirection.Y) / ((fClipX / 2.0000000) - ScreenDirection.X);
    fLineConstant = ScreenDirection.Y - (fLineSlope * ScreenDirection.X);
    // End:0x36B
    if(ScreenDirection.Y > (fClipY / 2.0000000))
    {
        ScreenLocation.Y = fLimitY;        
    }
    else
    {
        ScreenLocation.Y = fBase;
    }
    // End:0x3F4
    if(fLineSlope != float(0))
    {
        ScreenLocation.X = (ScreenLocation.Y - fLineConstant) / fLineSlope;        
    }
    else
    {
        ScreenLocation.X = fClipX / 2.0000000;
    }
    // End:0x4C3
    if(ScreenLocation.X > fLimitX)
    {
        ScreenLocation.X = fLimitX;
        ScreenLocation.Y = (fLineSlope * ScreenLocation.X) + fLineConstant;        
    }
    else
    {
        // End:0x562
        if(ScreenLocation.X < fBase)
        {
            ScreenLocation.X = fBase;
            ScreenLocation.Y = (fLineSlope * ScreenLocation.X) + fLineConstant;
        }
    }
    // End:0x5F7
    if(bBehind)
    {
        ScreenLocation.X = fClipX - ScreenLocation.X;
        ScreenLocation.Y = fClipY - ScreenLocation.Y;
    }
    // End:0x643
    if(ScreenLocation.Y <= fBase)
    {
        ScreenLocation.Y = 0.0000000;
    }
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_bCanShake=true
    m_Name="UIHudTip"
}