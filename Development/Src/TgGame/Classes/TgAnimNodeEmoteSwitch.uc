class TgAnimNodeEmoteSwitch extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

function PlayEmote(TgPawn.EEmote Emote) { }

defaultproperties
{
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
