class PComVideoPlayer extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var () string VideoURL;
var () int Width;
var () int Height;
var () bool bConstrainAspectRatio;
var () bool bDebugRender;
var transient bool bVideoFinished;
var transient bool bOnVideoFinishedIssued;
var () float ConstrainedAspectRatio;
var native transient Pointer Resource;
var transient TextureRenderTarget2D RenderTargetToUse;

delegate OnVideoFinished();

native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir);  // Export UPComVideoPlayer::execNativePostRenderFor(FFrame&, void* const)

function TestVideoPlayer(Actor SpawningActor, optional string InURL="http://sceerd.dl.playstation.net/sceerd/sceavplayer/streaming02.mp4") { }

function DestroyMe() { }

defaultproperties
{}
