class TgDeviceForm_MountNoHorse extends TgDeviceForm_Mount;

var int c_SparkleFXID;
var TgSpecialFx c_SparkleFX;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x101
    if(PawnOwner != none)
    {
        // End:0x101
        if(c_SparkleFX == none)
        {
            c_SparkleFX = PawnOwner.GetSpecialFx(c_SparkleFXID);
            // End:0x101
            if(c_SparkleFX != none)
            {
                c_SparkleFX.c_nmSocket = 'CSO_FX_Origin_01';
                c_SparkleFX.AttachToOwner(PawnOwner);
                c_SparkleFX.c_bSelfManage = false;
            }
        }
    }
    // End:0x131
    if(c_SparkleFX != none)
    {
        c_SparkleFX.Activate();
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x42
    if(c_SparkleFX != none)
    {
        c_SparkleFX.Deactivate(true);
    }
    //return;    
}

simulated event string GetAnimSetStringForBot(int PlayerBotId)
{
    return "";
    //return ReturnValue;    
}

defaultproperties
{
    c_SparkleFXID=7197
}