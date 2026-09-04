class TgGameViewportClient extends PComGameViewportClient within Engine
    transient
    native
    config(Engine);

var array<TgObjectReferencer> m_DeferredManifests;
var bool m_dragging;
var bool m_wasMaximized;
var transient bool bReadLeftStickAxis;
var transient bool bReadRightStickAxis;
var transient float fRawLeftStickAxis;
var transient float fRawRightStickAxis;

function DrawTransition(Canvas Canvas) { }

native function NativeGameSessionEnded();  // Export UTgGameViewportClient::execNativeGameSessionEnded(FFrame&, void* const)

native function bool IsGfxMovieCapturingMouseInput();  // Export UTgGameViewportClient::execIsGfxMovieCapturingMouseInput(FFrame&, void* const)

native function InitTgGameViewportClient();  // Export UTgGameViewportClient::execInitTgGameViewportClient(FFrame&, void* const)

event GameSessionEnded() { }

event PostRender(Canvas Canvas) { }

event GetSubtitleRegion(out vector2D MinPos, out vector2D MaxPos) { }

event LayoutPlayers() { }

event bool Init(out string OutError) { }
