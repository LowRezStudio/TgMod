class AnimNodePlayCustomAnim extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var bool bIsPlayingCustomAnim;
var float CustomPendingBlendOutTime;

// Export UAnimNodePlayCustomAnim::execPlayCustomAnim(FFrame&, void* const)
native final function float PlayCustomAnim(name AnimName, float Rate, optional float BlendInTime, optional float BlendOutTime, optional bool bLooping, optional bool bOverride);

// Export UAnimNodePlayCustomAnim::execPlayCustomAnimByDuration(FFrame&, void* const)
native final function PlayCustomAnimByDuration(name AnimName, float Duration, optional float BlendInTime, optional float BlendOutTime, optional bool bLooping, optional bool bOverride);

// Export UAnimNodePlayCustomAnim::execStopCustomAnim(FFrame&, void* const)
native final function StopCustomAnim(float BlendOutTime);

final function SetCustomAnim(name AnimName)
{
    local AnimNodeSequence SeqNode;

    SeqNode = AnimNodeSequence(Children[1].Anim);
    // End:0x68
    if(SeqNode != none)
    {
        SeqNode.SetAnim(AnimName);
    }
    //return;    
}

final function SetActorAnimEndNotification(bool bNewStatus)
{
    local AnimNodeSequence SeqNode;

    SeqNode = AnimNodeSequence(Children[1].Anim);
    // End:0x6A
    if(SeqNode != none)
    {
        SeqNode.bCauseActorAnimEnd = bNewStatus;
    }
    //return;    
}

final function AnimNodeSequence GetCustomAnimNodeSeq()
{
    return AnimNodeSequence(Children[1].Anim);
    //return ReturnValue;    
}

final function SetRootBoneAxisOption(optional AnimNodeSequence.ERootBoneAxis AxisX = 0, optional AnimNodeSequence.ERootBoneAxis AxisY = 0, optional AnimNodeSequence.ERootBoneAxis AxisZ = 0)
{
    local AnimNodeSequence AnimSeq;

    AnimSeq = GetCustomAnimNodeSeq();
    // End:0x72
    if(AnimSeq != none)
    {
        AnimSeq.super(AnimNodePlayCustomAnim).SetRootBoneAxisOption(AxisX, AxisY, AxisZ);        
    }
    //return;    
}

function SetPlayRate(float fPlayRate)
{
    local AnimNodeSequence SeqNode;

    SeqNode = AnimNodeSequence(Children[1].Anim);
    // End:0x68
    if(SeqNode != none)
    {
        SeqNode.Rate = fPlayRate;
    }
    //return;    
}

defaultproperties
{
    Children[0]=(Name="Normal",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Custom",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    NodeName="CustomAnim"
}