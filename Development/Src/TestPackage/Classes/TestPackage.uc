class TestPackage extends Object;

enum EZoomState {
    ZOOM_None,  // 0
    ZOOM_In,  // 1
    ZOOM_Out  // 2
};

struct SpectatorBookmark {
    var transient Actor ViewTarget;
    var TPOV POV;
    structdefaultproperties {}
};

function ChangeZoomState(EZoomState NewZoomState) { }

state RoundEnded {
    event BeginState(name PreviousStateName) { }
    stop;
}
