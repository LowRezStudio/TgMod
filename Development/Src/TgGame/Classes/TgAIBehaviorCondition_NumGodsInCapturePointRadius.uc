class TgAIBehaviorCondition_NumGodsInCapturePointRadius extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine);

var () bool bGodsMustBeEnemy;
var () int GodThreshold;

defaultproperties
{
    TitleName="NumGodsInCapturePointRadius"
    NodeToken=412
}
