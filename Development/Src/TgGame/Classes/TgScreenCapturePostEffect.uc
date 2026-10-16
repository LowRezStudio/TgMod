class TgScreenCapturePostEffect extends MaterialEffect
    native
    hidecategories(Object)
    config(Engine);

var transient TextureRenderTarget2D ScreenCapture;
var transient bool bIsScreenCaptureReady;

native function InitializeRenderTarget(PlayerController PlayerController);  // Export UTgScreenCapturePostEffect::execInitializeRenderTarget(FFrame&, void* const)

native function CleanupRenderTarget();  // Export UTgScreenCapturePostEffect::execCleanupRenderTarget(FFrame&, void* const)

function Cleanup(PostProcessChain InPostProcessChain) { }
