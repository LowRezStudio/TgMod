class TgAnimNodeBlendByCombatWariness extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () float CombatWarinessDuration;
var () bool AllowIdleAnimToComplete;
var () bool AllowWaryAnimToComplete;
var transient bool IsWary;
var transient float WaryTime;

native function BecomeWary();  // Export UTgAnimNodeBlendByCombatWariness::execBecomeWary(FFrame&, void* const)

defaultproperties
{
    CombatWarinessDuration=5.0000000
    AllowWaryAnimToComplete=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
