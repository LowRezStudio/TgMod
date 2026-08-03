class AnimNodeBlendBySpeed extends AnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var float Speed;
var int LastChannel;
var() float BlendUpTime;
var() float BlendDownTime;
var() float BlendDownPerc;
var() array<float> Constraints;
var() bool bUseAcceleration;
var() float BlendUpDelay;
var() float BlendDownDelay;
var transient float BlendDelayRemaining;

defaultproperties
{
    BlendUpTime=0.1000000
    BlendDownTime=0.1000000
    BlendDownPerc=0.2000000
    Constraints[0]=0.0000000
    Constraints[1]=180.0000000
    Constraints[2]=350.0000000
    Constraints[3]=900.0000000
}