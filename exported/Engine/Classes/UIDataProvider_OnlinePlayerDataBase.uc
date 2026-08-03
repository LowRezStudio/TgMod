class UIDataProvider_OnlinePlayerDataBase extends UIDataProvider
    abstract
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

var int PlayerControllerId;

event OnRegister(LocalPlayer InPlayer)
{
    // End:0x37
    if(InPlayer != none)
    {
        PlayerControllerId = InPlayer.ControllerId;
    }
    //return;    
}

event OnUnregister()
{
    PlayerControllerId = -1;
    //return;    
}

defaultproperties
{
    PlayerControllerId=-1
}