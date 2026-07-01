class TgDeviceVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() byte s_nTaskForce;

event int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x15D
    if(GRI != none)
    {
        // End:0x151
        if(true)
        {
            // End:0x151
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x10B
                if(int(s_nTaskForce) == 1)
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    // End:0x14F
                    if(int(GRI.r_AttackingTaskForce.r_nTaskForce) == 1)
                    {
                        return 2;                        
                    }
                    else
                    {
                        return 1;
                    }
                }
            }
        }
        return int(s_nTaskForce);
    }
    //return ReturnValue;    
}