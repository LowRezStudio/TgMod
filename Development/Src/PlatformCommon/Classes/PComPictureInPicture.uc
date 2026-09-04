class PComPictureInPicture extends Object
    native
    config(Engine);

const PICTURE_IN_PICTURE_BASE_WIDTH = 1920.0f;

const PICTURE_IN_PICTURE_BASE_HEIGHT = 1080.0f;

struct PComPipViewDesc {
    var name ViewName;
    var Vector ViewLocation;
    var Rotator ViewRotation;
    var Box Viewport;
    var PostProcessChain PostProcessChain;
    var PostProcessSettings PostProcessSettings;
    var float FOV;
    var Color ClearColor;
    var bool bDebugRenderTranslucent;
    var bool bAlwaysRender;
    var Double RequestRenderTime;
    var Double LastRenderedTime;
    var int NumFramesSinceRender;
    structdefaultproperties {}
};

var PComPictureInPictureScene Scene;
var TextureRenderTarget2D RenderTargetToUse;
var init native array<init PComPipViewDesc> ViewDescs;
var bool bEnableDebugRendering;
var Vector2D CurrentOffset;
var Vector2D CurrentScaling;

native function InitializeRenderTarget();  // Export UPComPictureInPicture::execInitializeRenderTarget(FFrame&, void* const)

native function Tick();  // Export UPComPictureInPicture::execTick(FFrame&, void* const)

native function AddView(const out PComPipViewDesc InViewDesc);  // Export UPComPictureInPicture::execAddView(FFrame&, void* const)

native function RemoveView(name ViewName);  // Export UPComPictureInPicture::execRemoveView(FFrame&, void* const)

native function RequestRender(name ViewName);  // Export UPComPictureInPicture::execRequestRender(FFrame&, void* const)

native function bool IsViewReady(name ViewName);  // Export UPComPictureInPicture::execIsViewReady(FFrame&, void* const)

native function bool IsViewDescReady(const out PComPipViewDesc ViewDesc);  // Export UPComPictureInPicture::execIsViewDescReady(FFrame&, void* const)

native function DebugRender(Canvas Canvas);  // Export UPComPictureInPicture::execDebugRender(FFrame&, void* const)

function TestPictureInPicture() { }
