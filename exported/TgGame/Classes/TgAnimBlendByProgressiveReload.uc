class TgAnimBlendByProgressiveReload extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

function SetReloadType(int ReloadType)
{
    switch(ReloadType)
    {
        // End:0x30
        case 0:
            SetActiveChild(0, GetBlendTime(0));
            // End:0x70
            break;
        // End:0x4D
        case 1:
            SetActiveChild(1, GetBlendTime(1));
            // End:0x70
            break;
        // End:0x6D
        case 2:
            SetActiveChild(2, GetBlendTime(2));
            // End:0x70
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    DefaultBlendTime=0.1000000
    Children=/* Array type was not detected. */
}