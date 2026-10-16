class TgAnimNodeEmoteSwitch extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

function PlayEmote(TgPawn.EEmote Emote)
{
    // End:0x81
    if(bRelevant)
    {
        // End:0x81
        if((int(Emote) < Children.Length) && Children[int(Emote)].Anim != none)
        {
            SetActiveChild(int(Emote), GetBlendTime(int(Emote)));
        }
    }
    //return;    
}

defaultproperties
{
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}