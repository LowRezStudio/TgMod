class PComVideoPlayer extends Actor
    native
    notplaceable
    hidecategories(Navigation);

var() string VideoURL;
var() int Width;
var() int Height;
var() bool bConstrainAspectRatio;
var() bool bDebugRender;
var transient bool bVideoFinished;
var transient bool bOnVideoFinishedIssued;
var() float ConstrainedAspectRatio;
var native transient Pointer Resource;
var transient TextureRenderTarget2D RenderTargetToUse;
//var delegate<OnVideoFinished> __OnVideoFinished__Delegate;

delegate OnVideoFinished()
{
    //return;    
}

// Export UPComVideoPlayer::execNativePostRenderFor(FFrame&, void* const)
native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir);

static function TestVideoPlayer(Actor SpawningActor, optional string InURL = "http://sceerd.dl.playstation.net/sceerd/sceavplayer/streaming02.mp4")
{
    local PComVideoPlayer PComVideoPlayer;

    PComVideoPlayer = SpawningActor.Spawn(Class'PlatformCommon.PComVideoPlayer');
    PComVideoPlayer.VideoURL = InURL;
    PComVideoPlayer.bDebugRender = true;
    PComVideoPlayer.Width = 1280;
    PComVideoPlayer.Height = 720;
    PComVideoPlayer.__OnVideoFinished__Delegate = PComVideoPlayer.DestroyMe;
    //return;    
}

function DestroyMe()
{
    Destroy();
    //return;    
}

defaultproperties
{
    Width=1920
    Height=1080
    bConstrainAspectRatio=true
    ConstrainedAspectRatio=1.7777800
    // Reference: TextureRenderTarget2D'PlatformCommon.Default__PComVideoPlayer.MyRenderTarget'
    begin object name="MyRenderTarget" class=Engine.TextureRenderTarget2D
        ClearColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        bNeedsTwoCopies=false
        SRGB=false
    end object
    RenderTargetToUse=MyRenderTarget
}