class MobileMenuScene extends Object
    native;

var(UI) string MenuName;
var(UI) export editinline array<export editinline MobileMenuObject> MenuObjects;
var(UI) Font SceneCaptionFont;
var(UI) MobilePlayerInput InputOwner;
var(UI) bool bSceneDoesNotRequireInput;
var(Options) bool bRelativeLeft;
var(Options) bool bRelativeTop;
var(Options) bool bRelativeWidth;
var(Options) bool bRelativeHeight;
var(Options) bool bApplyGlobalScaleLeft;
var(Options) bool bApplyGlobalScaleTop;
var(Options) bool bApplyGlobalScaleWidth;
var(Options) bool bApplyGlobalScaleHeight;
var(UI) byte TouchpadIndex;
var(Positions) float Left;
var(Positions) float Top;
var(Positions) float Width;
var(Positions) float Height;
var float InitialLeft;
var float InitialTop;
var float InitialWidth;
var float InitialHeight;
var(Options) float AuthoredGlobalScale;
var(Options) float Opacity;
var(Sounds) SoundCue UITouchSound;
var(Sounds) SoundCue UIUnTouchSound;

// Export UMobileMenuScene::execGetGlobalScaleX(FFrame&, void* const)
native static final function float GetGlobalScaleX();

// Export UMobileMenuScene::execGetGlobalScaleY(FFrame&, void* const)
native static final function float GetGlobalScaleY();

event InitMenuScene(MobilePlayerInput PlayerInput, int ScreenWidth, int ScreenHeight, bool bIsFirstInitialization)
{
    local int I, X, Y, W, H;

    SceneCaptionFont = GetSceneFont();
    InputOwner = PlayerInput;
    // End:0x83
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
    X = int(((bRelativeLeft) ? float(ScreenWidth) * Left : Left));
    Y = int(((bRelativeTop) ? float(ScreenHeight) * Top : Top));
    W = int(((bRelativeWidth) ? float(ScreenWidth) * Width : Width));
    H = int(((bRelativeHeight) ? float(ScreenHeight) * Height : Height));
    // End:0x1E4
    if(bApplyGlobalScaleLeft)
    {
        X *= (GetGlobalScaleX() / AuthoredGlobalScale);
    }
    // End:0x211
    if(bApplyGlobalScaleTop)
    {
        Y *= (GetGlobalScaleY() / AuthoredGlobalScale);
    }
    // End:0x23E
    if(bApplyGlobalScaleWidth)
    {
        W *= (GetGlobalScaleX() / AuthoredGlobalScale);
    }
    // End:0x26B
    if(bApplyGlobalScaleHeight)
    {
        H *= (GetGlobalScaleY() / AuthoredGlobalScale);
    }
    Left = float(((X >= 0) ? X : X + ScreenWidth));
    Top = float(((Y >= 0) ? Y : Y + ScreenHeight));
    Width = float(((W >= 0) ? W : W + ScreenWidth));
    Height = float(((H >= 0) ? H : H + ScreenHeight));
    I = 0;
    J0x35E:

    // End:0x3D3 [Loop If]
    if(I < MenuObjects.Length)
    {
        MenuObjects[I].InitMenuObject(InputOwner, self, ScreenWidth, ScreenHeight, bIsFirstInitialization);
        I++;
        // [Loop Continue]
        goto J0x35E;
    }
    //return;    
}

function Font GetSceneFont()
{
    return Class'Engine.Engine'.static.GetSmallFont();
    //return ReturnValue;    
}

function RenderScene(Canvas Canvas, float RenderDelta)
{
    local MobileMenuObject MenuObject;

    // End:0xB4
    foreach MenuObjects(MenuObject)
    {
        // End:0x5E
        if(MenuObject.bTellSceneBeforeRendering)
        {
            PreRenderMenuObject(MenuObject, Canvas, RenderDelta);
        }
        // End:0xB3
        if(!MenuObject.bIsHidden)
        {
            MenuObject.RenderObject(Canvas, RenderDelta);
        }        
    }    
    //return;    
}

function PreRenderMenuObject(MobileMenuObject MenuObject, Canvas Canvas, float RenderDelta)
{
    //return;    
}

event OnTouch(MobileMenuObject Sender, Interaction.ETouchType EventType, float TouchX, float TouchY)
{
    //return;    
}

event bool OnSceneTouch(Interaction.ETouchType EventType, float TouchX, float TouchY, bool bInside)
{
    return false;
    //return ReturnValue;    
}

function Opened(string Mode)
{
    //return;    
}

function MadeTopMenu()
{
    //return;    
}

function bool Closing()
{
    return true;
    //return ReturnValue;    
}

function Closed()
{
    CleanUpScene();
    //return;    
}

// Export UMobileMenuScene::execCleanUpScene(FFrame&, void* const)
native function CleanUpScene();

function MobileMenuObject FindMenuObject(string Tag)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x7F [Loop If]
    if(Idx < MenuObjects.Length)
    {
        // End:0x71
        if(Caps(MenuObjects[Idx].Tag) == Caps(Tag))
        {
            return MenuObjects[Idx];
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    return none;
    //return ReturnValue;    
}

function bool MobileMenuCommand(string Command)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    AuthoredGlobalScale=2.0000000
    Opacity=1.0000000
}