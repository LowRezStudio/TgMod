class TgAnimNodeSequenceByBoneRotation extends AnimNodeSequence
    hidecategories(Object,Object,Object);

struct AnimByRotation
{
    var() Rotator DesiredRotation;
    var() name AnimName;

    structdefaultproperties
    {
        DesiredRotation=(Pitch=0,Yaw=0,Roll=0)
        AnimName="None"
    }
};

var() name BoneName;
var() Object.EAxis BoneAxis;
var() array<AnimByRotation> AnimList;

event OnBecomeRelevant()
{
    local Vector BoneDirection;
    local int I;
    local float Diff, BestDiff;
    local name BestAnim;

    // End:0x27
    if(SkelComponent.Owner == none)
    {        
    }
    else
    {
        // End:0x54
        if((int(BoneAxis) == int(0)) || int(BoneAxis) == int(3))
        {            
        }
        else
        {
            BoneDirection = SkelComponent.GetBoneAxis(BoneName, BoneAxis) >> SkelComponent.Owner.Rotation;
            BestDiff = -1.0000000;
            I = 0;
            J0xDF:

            // End:0x19C [Loop If]
            if(I < AnimList.Length)
            {
                Diff = BoneDirection Dot Vector(AnimList[I].DesiredRotation);
                // End:0x18E
                if(Diff > BestDiff)
                {
                    BestAnim = AnimList[I].AnimName;
                    BestDiff = Diff;
                }
                I++;
                // [Loop Continue]
                goto J0xDF;
            }
            SetAnim(BestAnim);
            SetPosition(0.0000000, false);
        }
    }
    //return;    
}

defaultproperties
{
    BoneAxis=EAxis.AXIS_X
}