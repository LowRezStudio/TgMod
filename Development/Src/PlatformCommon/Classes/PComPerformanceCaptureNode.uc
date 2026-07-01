class PComPerformanceCaptureNode extends Actor
    native
    placeable
    hidecategories(Navigation);

var(PerformanceNode) string ExecCommand;
var(PerformanceNode) float DelayBeforeCapture;

defaultproperties
{
    DelayBeforeCapture=2.0000000
    Components(0)=none
    Components(1)=none
}