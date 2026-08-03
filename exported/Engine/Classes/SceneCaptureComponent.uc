class SceneCaptureComponent extends ActorComponent
    abstract
    native
    hidecategories(Object);

enum ESceneCaptureViewMode
{
    SceneCapView_Lit,               // 0
    SceneCapView_Unlit,             // 1
    SceneCapView_LitNoShadows,      // 2
    SceneCapView_Wire,              // 3
    SceneCapView_MAX                // 4
};

var(Capture) bool bEnabled;
var(Capture) bool bEnablePostProcess;
var(Capture) bool bEnableFog;
var(Capture) bool bUseMainScenePostProcessSettings;
var(Capture) bool bSkipUpdateIfTextureUsersOccluded;
var(Capture) bool bSkipUpdateIfOwnerOccluded;
var(Capture) bool bSkipRenderingDepthPrepass;
var(Capture) Color ClearColor;
var(Capture) SceneCaptureComponent.ESceneCaptureViewMode ViewMode;
var(Capture) int SceneLOD;
var(Capture) const float FrameRate;
var(Capture) PostProcessChain PostProcess;
var(Capture) float MaxUpdateDist;
var(Capture) float MaxViewDistanceOverride;
var(Capture) float MaxStreamingUpdateDist;
var private native const transient Pointer CaptureInfo;
var private native const transient Pointer ViewState;
var noimport duplicatetransient native const transient array<Pointer> PostProcessProxies;

// Export USceneCaptureComponent::execSetFrameRate(FFrame&, void* const)
native final function SetFrameRate(float NewFrameRate);

// Export USceneCaptureComponent::execSetEnabled(FFrame&, void* const)
native final simulated function SetEnabled(bool bEnable);

defaultproperties
{
    bEnabled=true
    bSkipRenderingDepthPrepass=true
    ClearColor=(R=0,G=0,B=0,A=255)
    ViewMode=ESceneCaptureViewMode.SceneCapView_LitNoShadows
    FrameRate=30.0000000
}