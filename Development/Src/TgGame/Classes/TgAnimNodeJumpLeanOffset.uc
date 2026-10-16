class TgAnimNodeJumpLeanOffset extends AnimNodeAimOffset
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () float JumpLeanStrength;
var () float MaxLeanChangeSpeed;
var () bool bMultiplyByZVelocity;
var AnimNodeAimOffset CachedAimNode;
var name OldAimProfileName;
var Vector2D PreBlendAim;
var float LeanWeight;
var float LeanWeightTarget;
var float BlendTimeToGo;

native function SetLeanWeight(float WeightTarget, float BlendTime);  // Export UTgAnimNodeJumpLeanOffset::execSetLeanWeight(FFrame&, void* const)

defaultproperties
{
    LeanWeight=1.0000000
    LeanWeightTarget=1.0000000
}
