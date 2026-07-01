class TgItemShopVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() int TaskforceIndex;

simulated function int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x154
    if(GRI != none)
    {
        // End:0x14A
        if(true)
        {
            // End:0x14A
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x106
                if(TaskforceIndex == 1)
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    return ((int(GRI.r_AttackingTaskForce.r_nTaskForce) == 1) ? 2 : 1);
                }
            }
        }
        return TaskforceIndex;
    }
    //return ReturnValue;    
}