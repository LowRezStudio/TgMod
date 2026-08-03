class GFxAction_OpenMovie extends SequenceAction
    native(UISequence)
    forcescriptorder(true)
    hidecategories(Object);

var() SwfMovie Movie;
var() Class<GFxMoviePlayer> MoviePlayerClass;
var GFxMoviePlayer MoviePlayer;
var() bool bTakeFocus;
var() bool bCaptureInput;
var() bool bStartPaused;
var bool bEnableGammaCorrection;
var() bool bDisplayWithHudOff;
var() GFxMoviePlayer.GFxRenderTextureMode RenderTextureMode;
var() TextureRenderTarget2D RenderTexture;
var() array<name> CaptureKeys;
var() array<name> FocusIgnoreKeys;

event bool IsValidLevelSequenceObject()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    MoviePlayerClass=Class'GFxUI.GFxMoviePlayer'
    bDisplayWithHudOff=true
    OutputLinks[0]=(Links=none,LinkDesc="Success",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Failed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="External Interface",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Player Owner",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Movie Player",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Open GFx Movie"
}