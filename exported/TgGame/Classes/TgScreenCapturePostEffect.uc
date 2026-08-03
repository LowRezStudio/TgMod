class TgScreenCapturePostEffect extends MaterialEffect
    native
    hidecategories(Object);

var transient TextureRenderTarget2D ScreenCapture;
var transient bool bIsScreenCaptureReady;

// Export UTgScreenCapturePostEffect::execInitializeRenderTarget(FFrame&, void* const)
native function InitializeRenderTarget(PlayerController PlayerController);

// Export UTgScreenCapturePostEffect::execCleanupRenderTarget(FFrame&, void* const)
native function CleanupRenderTarget();

function Cleanup(PostProcessChain InPostProcessChain)
{
    InPostProcessChain.Effects.RemoveItem(self);
    CleanupRenderTarget();
    //return;    
}
