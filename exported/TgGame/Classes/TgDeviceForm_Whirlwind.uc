class TgDeviceForm_Whirlwind extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x6D
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('Grover_Whirlwind', 0);
    }
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    // End:0x44
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Grover_Whirlwind', 0);
    }
    //return;    
}

event Generic1(optional byte byExtraData)
{
    super.Generic1(byExtraData);
    // End:0x4E
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Grover_Whirlwind', 0);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x4D
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Grover_Whirlwind', 0);
    }
    //return;    
}
