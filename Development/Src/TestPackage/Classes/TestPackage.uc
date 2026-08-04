class TestPackage extends Object;

struct SpectatorBookmark {
    var transient Actor ViewTarget;
    var TPOV POV;
    structdefaultproperties {}
};

state RoundEnded {
    event BeginState(name PreviousStateName) { }
    stop;
}
