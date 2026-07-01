class PComVideoPlayer extends Actor
    native
    notplaceable
    hidecategories(Navigation);

enum EPComVideoPlayerError
{
    PVPE_NoError,
    PVPE_CannotOpenVideo,
    PVPE_StreamingProblem,
    PVPE_Unknown
};

var() string VideoURL;
var() int Width;
var() int Height;
var() float Volume;
var() bool bAutoResize;
var() bool bConstrainAspectRatio;
var() bool bDebugRender;
var transient bool bVideoFinished;
var transient bool bOnVideoFinishedIssued;
var transient bool bHasMinorStreamingProblem;
var() float ConstrainedAspectRatio;
var native transient Pointer Resource;
var transient TextureRenderTarget2D RenderTargetToUse;
var transient TextureRenderTarget2D TextureCopyForStreamingProblem;
var transient float TimeSinceMinorStreamingProblem;
var transient Material StreamingProblemMaterial;
var transient PComVideoPlayer.EPComVideoPlayerError CurrentErrorState;
var transient PComVideoPlayer.EPComVideoPlayerError RenderThreadErrorState;
var transient Texture2D BlackTexture;
//var delegate<OnVideoFinished> __OnVideoFinished__Delegate;
//var delegate<OnVideoError> __OnVideoError__Delegate;

delegate OnVideoFinished()
{
    //return;    
}

delegate OnVideoError(PComVideoPlayer VideoPlayer, PComVideoPlayer.EPComVideoPlayerError ErrorCode)
{
    //return;    
}

// Export UPComVideoPlayer::execNativePostRenderFor(FFrame&, void* const)
native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir);

// Export UPComVideoPlayer::execInitialize(FFrame&, void* const)
native simulated function Initialize();

// Export UPComVideoPlayer::execStopVideoSession(FFrame&, void* const)
native simulated function StopVideoSession();

static function TestVideoPlayer(Actor SpawningActor, optional string InURL = "http://sceerd.dl.playstation.net/sceerd/sceavplayer/streaming02.mp4")
{
    //return;    
}

function TestOnVideoError(PComVideoPlayer VideoPlayer, PComVideoPlayer.EPComVideoPlayerError ErrorCode)
{
    //return;    
}

function DestroyMe()
{
    //return;    
}

defaultproperties
{
    Width=1920
    Height=1080
    Volume=1.0000000
    bAutoResize=true
    bConstrainAspectRatio=true
    ConstrainedAspectRatio=1.7777800
    begin object name=MyRenderTarget class=TextureRenderTarget2D
        ClearColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        bNeedsTwoCopies=false
        SRGB=false
    end object
    // Reference: TextureRenderTarget2D'Default__PComVideoPlayer.MyRenderTarget'
    RenderTargetToUse=MyRenderTarget
    begin object name=MyRenderTargetCopy class=TextureRenderTarget2D
        ClearColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        bNeedsTwoCopies=false
        SRGB=false
    end object
    // Reference: TextureRenderTarget2D'Default__PComVideoPlayer.MyRenderTargetCopy'
    TextureCopyForStreamingProblem=MyRenderTargetCopy
    StreamingProblemMaterial=Material'EngineResources.M_StreamingPause'
    BlackTexture=Texture2D'EngineResources.Black'
}