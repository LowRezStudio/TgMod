class PostProcessChain extends Object
    native;

var array<PostProcessEffect> Effects;

final function PostProcessEffect FindPostProcessEffect(name EffectName)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x96 [Loop If]
    if(Idx < Effects.Length)
    {
        // End:0x88
        if((Effects[Idx] != none) && Effects[Idx].EffectName == EffectName)
        {
            return Effects[Idx];
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    return none;
    //return ReturnValue;    
}
