class TgAnimNodeBlendByCombatWariness extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() float CombatWarinessDuration;
var() bool AllowIdleAnimToComplete;
var() bool AllowWaryAnimToComplete;
var transient bool IsWary;
var transient float WaryTime;

// Export UTgAnimNodeBlendByCombatWariness::execBecomeWary(FFrame&, void* const)
native function BecomeWary();

defaultproperties
{
    CombatWarinessDuration=5.0000000
    AllowWaryAnimToComplete=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}