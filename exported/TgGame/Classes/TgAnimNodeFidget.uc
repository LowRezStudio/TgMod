class TgAnimNodeFidget extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EFidgetType
{
    FT_Timed,                       // 0
    FT_ChanceOnIdleCompletes,       // 1
    FT_MAX                          // 2
};

var transient float m_SelectedIdleTimeBeforeFidgeting;
var transient float m_CurrentIdleTime;
var() float BlendToFidgetDuration;
var() float BlendFromFidgetDuration;
var() TgAnimNodeFidget.EFidgetType FidgetType;
var(TimedFidget) float MinimumIdleTimeBeforeFidgeting;
var(TimedFidget) float MaximumIdleTimeBeforeFidgeting;
var(TimedFidget) bool AllowIdleAnimToComplete;
var(ChanceFidget) float ChanceToFidgetWhenIdleCompletes;

defaultproperties
{
    BlendToFidgetDuration=0.2000000
    BlendFromFidgetDuration=0.2000000
    MinimumIdleTimeBeforeFidgeting=5.0000000
    MaximumIdleTimeBeforeFidgeting=5.0000000
    AllowIdleAnimToComplete=true
    ChanceToFidgetWhenIdleCompletes=1.0000000
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}