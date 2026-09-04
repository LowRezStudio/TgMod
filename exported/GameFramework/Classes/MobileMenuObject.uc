class MobileMenuObject extends Object
    native;

struct native UVCoords
{
    var() bool bCustomCoords;
    var() float U;
    var() float V;
    var() float UL;
    var() float VL;

    structdefaultproperties
    {
        bCustomCoords=false
        U=0.0000000
        V=0.0000000
        UL=0.0000000
        VL=0.0000000
    }
};

var transient bool bHasBeenInitialized;
var bool bRelativeLeft;
var bool bRelativeTop;
var bool bRelativeWidth;
var bool bRelativeHeight;
var bool bApplyGlobalScaleLeft;
var bool bApplyGlobalScaleTop;
var bool bApplyGlobalScaleWidth;
var bool bApplyGlobalScaleHeight;
var bool bHeightRelativeToWidth;
var bool bXOffsetIsActual;
var bool bYOffsetIsActual;
var bool bIsActive;
var bool bIsHidden;
var bool bIsTouched;
var bool bIsHighlighted;
var bool bTellSceneBeforeRendering;
var float Left;
var float Top;
var float Width;
var float Height;
var float InitialLeft;
var float InitialTop;
var float InitialWidth;
var float InitialHeight;
var(Bounds) float AuthoredGlobalScale;
var float TopLeeway;
var float BottomLeeway;
var float LeftLeeway;
var float RightLeeway;
var float XOffset;
var float YOffset;
var string Tag;
var MobilePlayerInput InputOwner;
var float Opacity;
var MobileMenuScene OwnerScene;
var string RelativeToTag;
var MobileMenuObject RelativeTo;

event bool OnTouch(Interaction.ETouchType EventType, float TouchX, float TouchY, MobileMenuObject ObjectOver, float DeltaTime)
{
    return false;
    //return ReturnValue;    
}

event GetRealPosition(out float PosX, out float PosY)
{
    // End:0x78
    if(RelativeTo == none)
    {
        PosX = OwnerScene.Left + Left;
        PosY = OwnerScene.Top + Top;        
    }
    else
    {
        RelativeTo.GetRealPosition(PosX, PosY);
        PosX += Left;
        PosY += Top;
    }
    //return;    
}

function InitMenuObject(MobilePlayerInput PlayerInput, MobileMenuScene Scene, int ScreenWidth, int ScreenHeight, bool bIsFirstInitialization)
{
    local int X, Y, W, H, oX, oY,
	    RelativeIdx;

    InputOwner = PlayerInput;
    OwnerScene = Scene;
    // End:0xFA
    if(Len(RelativeToTag) > 0)
    {
        RelativeIdx = int(RelativeToTag);
        // End:0x9A
        if(string(RelativeIdx) != RelativeToTag)
        {
            RelativeTo = Scene.FindMenuObject(RelativeToTag);            
        }
        else
        {
            RelativeIdx += Scene.MenuObjects.Find(self);
            RelativeTo = Scene.MenuObjects[RelativeIdx];
        }
    }
    // End:0x647
    if(!bHasBeenInitialized || !bIsFirstInitialization)
    {
        // End:0x176
        if(bIsFirstInitialization)
        {
            InitialTop = Top;
            InitialLeft = Left;
            InitialWidth = Width;
            InitialHeight = Height;            
        }
        else
        {
            Top = InitialTop;
            Left = InitialLeft;
            Width = InitialWidth;
            Height = InitialHeight;
        }
        X = int(((bRelativeLeft) ? Scene.Width * Left : Left));
        Y = int(((bRelativeTop) ? Scene.Height * Top : Top));
        W = int(((bRelativeWidth) ? Scene.Width * Width : Width));
        // End:0x2DB
        if(bHeightRelativeToWidth)
        {
            H = int(float(W) * Height);            
        }
        else
        {
            H = int(((bRelativeHeight) ? Scene.Height * Height : Height));
        }
        // End:0x36A
        if(bApplyGlobalScaleLeft)
        {
            X *= (Scene.GetGlobalScaleX() / AuthoredGlobalScale);
        }
        // End:0x3AC
        if(bApplyGlobalScaleTop)
        {
            Y *= (Scene.GetGlobalScaleY() / AuthoredGlobalScale);
        }
        // End:0x3EE
        if(bApplyGlobalScaleWidth)
        {
            W *= (Scene.GetGlobalScaleX() / AuthoredGlobalScale);
        }
        // End:0x430
        if(bApplyGlobalScaleHeight)
        {
            H *= (Scene.GetGlobalScaleY() / AuthoredGlobalScale);
        }
        // End:0x557
        if(RelativeTo == none)
        {
            // End:0x485
            if(X < 0)
            {
                X = int(Scene.Width + float(X));
            }
            // End:0x4CB
            if(Y < 0)
            {
                Y = int(Scene.Height + float(Y));
            }
            // End:0x511
            if(W < 0)
            {
                W = int(Scene.Width + float(W));
            }
            // End:0x557
            if(H < 0)
            {
                H = int(Scene.Height + float(H));
            }
        }
        Left = float(X);
        Top = float(Y);
        Width = float(W);
        Height = float(H);
        oX = int(((bXOffsetIsActual) ? XOffset : Width * XOffset));
        oY = int(((bYOffsetIsActual) ? YOffset : Height * YOffset));
        Left -= float(oX);
        Top -= float(oY);
    }
    bHasBeenInitialized = true;
    //return;    
}

function SetCanvasPos(Canvas Canvas, optional float OffsetX = 0.0000000, optional float OffsetY = 0.0000000)
{
    local float PosX, PosY;

    GetRealPosition(PosX, PosY);
    Canvas.SetPos(PosX + OffsetX, PosY + OffsetY);
    //return;    
}

function RenderObject(Canvas Canvas, float DeltaTime)
{
    //return;    
}

defaultproperties
{
    AuthoredGlobalScale=2.0000000
    Opacity=1.0000000
}