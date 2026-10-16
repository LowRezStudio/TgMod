class TgAnimNodeBlendBySlowFall extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

simulated event SetActiveAnimationIndex(int ChildIndex)
{
    // End:0x6C
    if(((ChildIndex != -1) && ChildIndex != ActiveChildIndex) && ChildIndex < Children.Length)
    {
        SetActiveChild(ChildIndex, GetBlendTime(ChildIndex));
    }
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}