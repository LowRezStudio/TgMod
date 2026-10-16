class TgAnimTurnInPlace_Player extends AnimNodeSequence
    native(Anim)
    hidecategories(Object,Object,Object);

struct native TIP_Transition
{
    var name TransName;
    var() name AnimName;

    structdefaultproperties
    {
        TransName="None"
        AnimName="None"
    }
};

var() array<TIP_Transition> TIP_Transitions;

defaultproperties
{
    TIP_Transitions[0]=(TransName="Rt_90",AnimName="TurnR90")
    TIP_Transitions[1]=(TransName="Rt_180",AnimName="TurnR180")
    TIP_Transitions[2]=(TransName="Lt_90",AnimName="TurnL90")
    TIP_Transitions[3]=(TransName="Lt_180",AnimName="TurnL180")
    RootRotationOption[2]=ERootRotationOption.RRO_Discard
}