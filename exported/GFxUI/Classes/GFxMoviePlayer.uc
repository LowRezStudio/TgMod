class GFxMoviePlayer extends Object
    native
    config(UI);

enum GFxTimingMode
{
    TM_Game,                        // 0
    TM_Real,                        // 1
    TM_MAX                          // 2
};

enum GFxRenderTextureMode
{
    RTM_Opaque,                     // 0
    RTM_Alpha,                      // 1
    RTM_AlphaComposite,             // 2
    RTM_MAX                         // 3
};

enum ASType
{
    AS_Undefined,                   // 0
    AS_Null,                        // 1
    AS_Number,                      // 2
    AS_Int,                         // 3
    AS_String,                      // 4
    AS_Boolean,                     // 5
    AS_MAX                          // 6
};

enum GFxScaleMode
{
    SM_NoScale,                     // 0
    SM_ShowAll,                     // 1
    SM_ExactFit,                    // 2
    SM_NoBorder,                    // 3
    SM_MAX                          // 4
};

enum GFxAlign
{
    Align_Center,                   // 0
    Align_TopCenter,                // 1
    Align_BottomCenter,             // 2
    Align_CenterLeft,               // 3
    Align_CenterRight,              // 4
    Align_TopLeft,                  // 5
    Align_TopRight,                 // 6
    Align_BottomLeft,               // 7
    Align_BottomRight,              // 8
    Align_MAX                       // 9
};

struct native ExternalTexture
{
    var() string Resource;
    var() Texture Texture;

    structdefaultproperties
    {
        Resource=""
        Texture=none
    }
};

struct native SoundThemeBinding
{
    var() name ThemeName;
    var() UISoundTheme Theme;
    var() string ThemeClassName;

    structdefaultproperties
    {
        ThemeName="None"
        Theme=none
        ThemeClassName=""
    }
};

struct native GFxWidgetBinding
{
    var() name WidgetName;
    var() Class<GFxObject> WidgetClass;

    structdefaultproperties
    {
        WidgetName="None"
        WidgetClass=none
    }
};

struct native GFxStoredViewportParams
{
    var int X;
    var int Y;
    var int Width;
    var int Height;
    var bool bInitialized;

    structdefaultproperties
    {
        X=0
        Y=0
        Width=0
        Height=0
        bInitialized=false
    }
};

struct native ASValue
{
    var() GFxMoviePlayer.ASType Type;
    var() bool B;
    var() float N;
    var() int I;
    var() init string S;

    structdefaultproperties
    {
        Type=ASType.AS_Undefined
        B=false
        N=0.0000000
        I=0
        S=""
    }
};

var native const transient Pointer pMovie;
var native const transient Pointer pCaptureKeys;
var native const transient Pointer pFocusIgnoreKeys;
var private native const transient map{VOID,VOID} ASUClasses;
var private native const transient map{VOID,VOID} ASUObjects;
var private const transient int NextASUObject;
var SwfMovie MovieInfo;
var const bool bMovieIsOpen;
var bool bDisplayWithHudOff;
var bool bEnableGammaCorrection;
var const transient bool bWidgetsInitializedThisFrame;
var bool bLogUnhandedWidgetInitializations;
var bool bAllowInput;
var bool bAllowFocus;
var bool bAutoPlay;
var bool bPauseGameWhileActive;
var bool bDisableWorldRendering;
var bool bCaptureWorldRendering;
var bool bCloseOnLevelChange;
var bool bOnlyOwnerFocusable;
var bool bForceFullViewport;
var bool bDiscardNonOwnerInput;
var bool bCaptureInput;
var bool bCaptureMouseInput;
var bool bIgnoreMouseInput;
var transient bool bIsSplitscreenLayoutModified;
var bool bShowHardwareMouseCursor;
var bool bBlurLesserMovies;
var bool bHideLesserMovies;
var bool bIsPriorityBlurred;
var bool bIsPriorityHidden;
var bool bIgnoreVisibilityEffect;
var bool bIgnoreBlurEffect;
var() TextureRenderTarget2D RenderTexture;
var transient int LocalPlayerOwnerIndex;
var Object ExternalInterface;
var array<name> CaptureKeys;
var array<name> FocusIgnoreKeys;
var array<ExternalTexture> ExternalTextures;
var() array<SoundThemeBinding> SoundThemes;
var private GFxMoviePlayer.GFxTimingMode TimingMode;
var GFxMoviePlayer.GFxRenderTextureMode RenderTextureMode;
var private byte Priority;
var array<GFxWidgetBinding> WidgetBindings;
var native const map{VOID,VOID} WidgetPathBindings;
var transient GFxObject SplitscreenLayoutObject;
var config int SplitscreenLayoutYAdjust;
var GFxStoredViewportParams m_StoredViewportParams;
//var delegate<OnPostAdvance> __OnPostAdvance__Delegate;

// Export UGFxMoviePlayer::execStart(FFrame&, void* const)
native event bool Start(optional bool StartPaused = false);

// Export UGFxMoviePlayer::execAdvance(FFrame&, void* const)
native final function Advance(float Time);

// Export UGFxMoviePlayer::execPostAdvance(FFrame&, void* const)
native function PostAdvance(float DeltaTime);

delegate OnPostAdvance(float DeltaTime)
{
    //return;    
}

// Export UGFxMoviePlayer::execSetPause(FFrame&, void* const)
native function SetPause(optional bool bPausePlayback = true);

// Export UGFxMoviePlayer::execClose(FFrame&, void* const)
native final function Close(optional bool Unload = true);

event OnClose()
{
    //return;    
}

event OnCleanup()
{
    //return;    
}

final event ConditionalClearPause()
{
    local LocalPlayer LP;

    // End:0x8C
    if(bPauseGameWhileActive)
    {
        LP = GetLP();
        // End:0x8C
        if((LP != none) && LP.Actor != none)
        {
            LP.Actor.SetPause(false);
        }
    }
    //return;    
}

function SetMovieInfo(SwfMovie Data)
{
    MovieInfo = Data;
    //return;    
}

// Export UGFxMoviePlayer::execSetTimingMode(FFrame&, void* const)
native function SetTimingMode(GFxMoviePlayer.GFxTimingMode Mode);

function SetExternalInterface(Object H)
{
    ExternalInterface = H;
    //return;    
}

// Export UGFxMoviePlayer::execSetExternalTexture(FFrame&, void* const)
native function bool SetExternalTexture(string Resource, Texture Texture);

// Export UGFxMoviePlayer::execSetPriority(FFrame&, void* const)
native function SetPriority(byte NewPriority);

// Export UGFxMoviePlayer::execGetGameViewportClient(FFrame&, void* const)
native final function GameViewportClient GetGameViewportClient();

// Export UGFxMoviePlayer::execSetViewport(FFrame&, void* const)
native final function SetViewport(int X, int Y, int Width, int Height);

// Export UGFxMoviePlayer::execGetViewport(FFrame&, void* const)
native final function GetViewport(out int X, out int Y, out int Width, out int Height);

// Export UGFxMoviePlayer::execScreenToViewport(FFrame&, void* const)
native final function ScreenToViewport(int X, int Y, out int xOut, out int yOut);

// Export UGFxMoviePlayer::execViewportToScreen(FFrame&, void* const)
native final function ViewportToScreen(int X, int Y, out int xOut, out int yOut);

// Export UGFxMoviePlayer::execSetViewScaleMode(FFrame&, void* const)
native final function SetViewScaleMode(GFxMoviePlayer.GFxScaleMode SM);

// Export UGFxMoviePlayer::execSetAlignment(FFrame&, void* const)
native final function SetAlignment(GFxMoviePlayer.GFxAlign A);

// Export UGFxMoviePlayer::execGetVisibleFrameRect(FFrame&, void* const)
native final function GetVisibleFrameRect(out float x0, out float y0, out float X1, out float Y1);

// Export UGFxMoviePlayer::execSetView3D(FFrame&, void* const)
native final function SetView3D(const out Matrix matView);

// Export UGFxMoviePlayer::execSetPerspective3D(FFrame&, void* const)
native final function SetPerspective3D(const out Matrix matPersp);

// Export UGFxMoviePlayer::execSetMovieCanReceiveFocus(FFrame&, void* const)
native final function SetMovieCanReceiveFocus(bool bCanReceiveFocus);

// Export UGFxMoviePlayer::execSetMovieCanReceiveInput(FFrame&, void* const)
native final function SetMovieCanReceiveInput(bool bCanReceiveInput);

// Export UGFxMoviePlayer::execAddCaptureKey(FFrame&, void* const)
native final function AddCaptureKey(name Key);

// Export UGFxMoviePlayer::execClearCaptureKeys(FFrame&, void* const)
native final function ClearCaptureKeys();

// Export UGFxMoviePlayer::execAddFocusIgnoreKey(FFrame&, void* const)
native final function AddFocusIgnoreKey(name Key);

// Export UGFxMoviePlayer::execClearFocusIgnoreKeys(FFrame&, void* const)
native final function ClearFocusIgnoreKeys();

// Export UGFxMoviePlayer::execFlushPlayerInput(FFrame&, void* const)
native final function FlushPlayerInput(bool capturekeysonly);

event bool FilterButtonInput(int ControllerId, name ButtonName, Object.EInputEvent InputEvent)
{
    //return ReturnValue;    
}

event bool ShouldBlockKey(int ControllerId, name ButtonName, Object.EInputEvent InputEvent)
{
    //return ReturnValue;    
}

// Export UGFxMoviePlayer::execGetAVMVersion(FFrame&, void* const)
native function int GetAVMVersion();

// Export UGFxMoviePlayer::execGetVariable(FFrame&, void* const)
native function ASValue GetVariable(string Path);

// Export UGFxMoviePlayer::execGetVariableBool(FFrame&, void* const)
native function bool GetVariableBool(string Path);

// Export UGFxMoviePlayer::execGetVariableNumber(FFrame&, void* const)
native function float GetVariableNumber(string Path);

// Export UGFxMoviePlayer::execGetVariableInt(FFrame&, void* const)
native function int GetVariableInt(string Path);

// Export UGFxMoviePlayer::execGetVariableString(FFrame&, void* const)
native function string GetVariableString(string Path);

// Export UGFxMoviePlayer::execGetVariableObject(FFrame&, void* const)
native function GFxObject GetVariableObject(string Path, optional Class<GFxObject> Type);

// Export UGFxMoviePlayer::execSetVariable(FFrame&, void* const)
native function SetVariable(string Path, ASValue Arg);

// Export UGFxMoviePlayer::execSetVariableBool(FFrame&, void* const)
native function SetVariableBool(string Path, bool B);

// Export UGFxMoviePlayer::execSetVariableNumber(FFrame&, void* const)
native function SetVariableNumber(string Path, float F);

// Export UGFxMoviePlayer::execSetVariableInt(FFrame&, void* const)
native function SetVariableInt(string Path, int I);

// Export UGFxMoviePlayer::execSetVariableString(FFrame&, void* const)
native function SetVariableString(string Path, string S);

// Export UGFxMoviePlayer::execSetVariableObject(FFrame&, void* const)
native function SetVariableObject(string Path, GFxObject Object);

// Export UGFxMoviePlayer::execGetVariableArray(FFrame&, void* const)
native function bool GetVariableArray(string Path, int Index, out array<ASValue> Arg);

// Export UGFxMoviePlayer::execGetVariableIntArray(FFrame&, void* const)
native function bool GetVariableIntArray(string Path, int Index, out array<int> Arg);

// Export UGFxMoviePlayer::execGetVariableFloatArray(FFrame&, void* const)
native function bool GetVariableFloatArray(string Path, int Index, out array<float> Arg);

// Export UGFxMoviePlayer::execGetVariableStringArray(FFrame&, void* const)
native function bool GetVariableStringArray(string Path, int Index, out array<string> Arg);

// Export UGFxMoviePlayer::execSetVariableArray(FFrame&, void* const)
native function bool SetVariableArray(string Path, int Index, array<ASValue> Arg);

// Export UGFxMoviePlayer::execSetVariableIntArray(FFrame&, void* const)
native function bool SetVariableIntArray(string Path, int Index, array<int> Arg);

// Export UGFxMoviePlayer::execSetVariableFloatArray(FFrame&, void* const)
native function bool SetVariableFloatArray(string Path, int Index, array<float> Arg);

// Export UGFxMoviePlayer::execSetVariableStringArray(FFrame&, void* const)
native function bool SetVariableStringArray(string Path, int Index, array<string> Arg);

// Export UGFxMoviePlayer::execCreateObject(FFrame&, void* const)
native function GFxObject CreateObject(string ASClass, optional Class<GFxObject> Type, optional array<ASValue> args);

// Export UGFxMoviePlayer::execCreateArray(FFrame&, void* const)
native function GFxObject CreateArray();

// Export UGFxMoviePlayer::execActionScriptSetFunction(FFrame&, void* const)
protected native final function ActionScriptSetFunction(GFxObject Object, string Member);

// Export UGFxMoviePlayer::execInvoke(FFrame&, void* const)
native function ASValue Invoke(string method, array<ASValue> args);

// Export UGFxMoviePlayer::execActionScriptVoid(FFrame&, void* const)
protected native final function ActionScriptVoid(string Path);

// Export UGFxMoviePlayer::execActionScriptInt(FFrame&, void* const)
protected native final function int ActionScriptInt(string Path);

// Export UGFxMoviePlayer::execActionScriptFloat(FFrame&, void* const)
protected native final function float ActionScriptFloat(string Path);

// Export UGFxMoviePlayer::execActionScriptString(FFrame&, void* const)
protected native final function string ActionScriptString(string Path);

// Export UGFxMoviePlayer::execActionScriptObject(FFrame&, void* const)
protected native final function GFxObject ActionScriptObject(string Path);

// Export UGFxMoviePlayer::execActionScriptConstructor(FFrame&, void* const)
protected native final function GFxObject ActionScriptConstructor(string ClassName);

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
    //return ReturnValue;    
}

event bool WidgetUnloaded(name WidgetName, name WidgetPath, GFxObject Widget)
{
    //return ReturnValue;    
}

event PostWidgetInit()
{
    //return;    
}

// Export UGFxMoviePlayer::execSetWidgetPathBinding(FFrame&, void* const)
native final function SetWidgetPathBinding(GFxObject WidgetToBind, name Path);

event Init(optional LocalPlayer LocPlay)
{
    LocalPlayerOwnerIndex = Class'Engine.Engine'.static.GetEngine().GamePlayers.Find(LocPlay);
    // End:0x6A
    if(LocalPlayerOwnerIndex == -1)
    {
        LocalPlayerOwnerIndex = 0;
    }
    // End:0xA0
    if(MovieInfo != none)
    {
        // End:0xA0
        if(bAutoPlay)
        {
            Start();
            Advance(0.0000000);
        }
    }
    //return;    
}

event LocalPlayer GetLP()
{
    local Engine Eng;

    Eng = Class'Engine.Engine'.static.GetEngine();
    // End:0x46
    if(LocalPlayerOwnerIndex < 0)
    {
        LocalPlayerOwnerIndex = 0;        
    }
    else
    {
        // End:0x75
        if(LocalPlayerOwnerIndex >= Eng.GamePlayers.Length)
        {
            return none;
        }
    }
    return Eng.GamePlayers[LocalPlayerOwnerIndex];
    //return ReturnValue;    
}

event PlayerController GetPC()
{
    local LocalPlayer LocalPlayerOwner;

    LocalPlayerOwner = GetLP();
    // End:0x25
    if(LocalPlayerOwner == none)
    {
        return none;
    }
    return LocalPlayerOwner.Actor;
    //return ReturnValue;    
}

function ConsoleCommand(string Command)
{
    local PlayerController PC;

    PC = GetPC();
    // End:0x55
    if(PC != none)
    {        
        PC.ConsoleCommand(Command);
    }
    //return;    
}

event OnFocusGained(int LocalPlayerIndex)
{
    //return;    
}

event OnFocusLost(int LocalPlayerIndex)
{
    //return;    
}

function PlaySoundFromTheme(name EventName, optional name SoundThemeName = 'Default')
{
    local int ThemeIndex;
    local UISoundTheme Theme;

    ThemeIndex = SoundThemes.Find('ThemeName', SoundThemeName);
    // End:0xC0
    if(ThemeIndex != -1)
    {
        Theme = SoundThemes[ThemeIndex].Theme;
        // End:0xBD
        if(Theme != none)
        {
            Theme.ProcessSoundEvent(EventName, GetPC());            
        }        
    }
    //return;    
}

event ApplyPriorityEffect(bool bRequestedBlurState, bool bRequestedHiddenState)
{
    // End:0x66
    if((bRequestedHiddenState != bIsPriorityHidden) && !bRequestedHiddenState || !bIgnoreVisibilityEffect)
    {
        ApplyPriorityVisibilityEffect(!bRequestedHiddenState);
        bIsPriorityHidden = bRequestedHiddenState;
    }
    // End:0xCC
    if((bRequestedBlurState != bIsPriorityBlurred) && !bRequestedBlurState || !bIgnoreBlurEffect)
    {
        ApplyPriorityBlurEffect(!bRequestedBlurState);
        bIsPriorityBlurred = bRequestedBlurState;
    }
    //return;    
}

function ApplyPriorityBlurEffect(bool bRemoveEffect)
{
    //return;    
}

function ApplyPriorityVisibilityEffect(bool bRemoveEffect)
{
    //return;    
}

// Export UGFxMoviePlayer::execUpdateSplitscreenLayout(FFrame&, void* const)
native function UpdateSplitscreenLayout();

defaultproperties
{
    bDisplayWithHudOff=true
    bAllowInput=true
    bAllowFocus=true
    bCloseOnLevelChange=true
    Priority=1
    SplitscreenLayoutYAdjust=-27
}