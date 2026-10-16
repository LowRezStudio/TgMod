class TgDeviceForm_NetherStep extends TgDeviceForm;

var array<AnimNodeBlendList> m_stanceNodes1p;
var array<AnimNodeBlendList> m_stanceNodes3p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local AnimNodeBlendList AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xC1
    foreach SkelComp.AllAnimNodes(Class'Engine.AnimNodeBlendList', AnimNode)
    {
        // End:0xC0
        if(AnimNode.NodeName == 'StanceAttack')
        {
            m_stanceNodes3p.AddItem(AnimNode);
        }        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local AnimNodeBlendList AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xC1
    foreach SkelComp.AllAnimNodes(Class'Engine.AnimNodeBlendList', AnimNode)
    {
        // End:0xC0
        if(AnimNode.NodeName == 'StanceAttack')
        {
            m_stanceNodes1p.AddItem(AnimNode);
        }        
    }    
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x6D
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('NetherStepDash', 0);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x4D
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('NetherStepDash', 0);
    }
    //return;    
}

event CooldownComplete()
{
    local AnimNodeBlendList AnimNode;

    super.CooldownComplete();
    // End:0x47
    foreach m_stanceNodes1p(AnimNode)
    {
        AnimNode.SetActiveChild(0, 0.0000000);        
    }    
    // End:0x85
    foreach m_stanceNodes3p(AnimNode)
    {
        AnimNode.SetActiveChild(0, 0.0000000);        
    }    
    //return;    
}
