class SeqAct_FeatureTest extends SeqAct_Log
    native(Sequence)
    hidecategories(Object);

var() string FreezeAtParameters;
var() float ScreenShotDelay;
var() string ScreenShotName;
var float RemainingScreenShotDelay;

defaultproperties
{
    ScreenShotDelay=1.0000000
    bLatentExecution=true
    bAutoActivateOutputLinks=false
    ObjName="Feature Test"
}