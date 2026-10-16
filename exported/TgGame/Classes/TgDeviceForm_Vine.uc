class TgDeviceForm_Vine extends TgDeviceForm
    native(ChampGrover);

var bool m_bBeamActive;
var bool m_bVineInterrupted;
var Actor m_BeamTarget;
var Vector m_vBeamTargetLocation;
var array<TgAnimNodeBlendByAbilityVine> m_VineBlendList1P;
var array<TgAnimNodeBlendByAbilityVine> m_VineBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityVine AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_VineBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityVine', AnimNode)
    {
        m_VineBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityVine AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_VineBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityVine', AnimNode)
    {
        m_VineBlendList1P.AddItem(AnimNode);        
    }    
    //return;    
}

function ConnectBeamToTarget(Actor Target, Vector Location)
{
    local int I;

    // End:0x0F
    if(m_bVineInterrupted)
    {
        return;
    }
    // End:0x142
    if(((m_BeamTarget != none) && m_BeamTarget != Target) && m_BeamTarget.IsA('TgProj_Vine'))
    {
        I = 0;
        J0x67:

        // End:0xCF [Loop If]
        if(I < m_VineBlendList1P.Length)
        {
            // End:0xC1
            if(m_VineBlendList1P[I] != none)
            {
                m_VineBlendList1P[I].VinePull();
            }
            I++;
            // [Loop Continue]
            goto J0x67;
        }
        I = 0;
        J0xDA:

        // End:0x142 [Loop If]
        if(I < m_VineBlendList3P.Length)
        {
            // End:0x134
            if(m_VineBlendList3P[I] != none)
            {
                m_VineBlendList3P[I].VinePull();
            }
            I++;
            // [Loop Continue]
            goto J0xDA;
        }
    }
    m_vBeamTargetLocation = Location;
    m_BeamTarget = Target;
    m_bBeamActive = true;
    // End:0x27D
    if(c_Mesh != none)
    {
        // End:0x1B6
        if(c_Mesh.FxActivateGroup('DragChain', 0) == none)
        {
        }
        // End:0x27D
        if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('DragChain', 0);
        }
    }
    //return;    
}

function DisconnectBeam()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x73 [Loop If]
    if(I < m_VineBlendList1P.Length)
    {
        // End:0x65
        if(m_VineBlendList1P[I] != none)
        {
            m_VineBlendList1P[I].VinePost();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x7E:

    // End:0xE6 [Loop If]
    if(I < m_VineBlendList3P.Length)
    {
        // End:0xD8
        if(m_VineBlendList3P[I] != none)
        {
            m_VineBlendList3P[I].VinePost();
        }
        I++;
        // [Loop Continue]
        goto J0x7E;
    }
    m_bBeamActive = false;
    m_BeamTarget = none;
    // End:0x137
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('DragChain', 0);
    }
    // End:0x1FC
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('DragChain', 0);
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local int I;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    I = 0;
    J0x3C:

    // End:0xA4 [Loop If]
    if(I < m_VineBlendList1P.Length)
    {
        // End:0x96
        if(m_VineBlendList1P[I] != none)
        {
            m_VineBlendList1P[I].VineThrow();
        }
        I++;
        // [Loop Continue]
        goto J0x3C;
    }
    I = 0;
    J0xAF:

    // End:0x117 [Loop If]
    if(I < m_VineBlendList3P.Length)
    {
        // End:0x109
        if(m_VineBlendList3P[I] != none)
        {
            m_VineBlendList3P[I].VineThrow();
        }
        I++;
        // [Loop Continue]
        goto J0xAF;
    }
    m_bVineInterrupted = false;
    //return;    
}

event StopFire(int nFireModeNum)
{
    local int I;

    super.StopFire(nFireModeNum);
    I = 0;
    J0x1E:

    // End:0x86 [Loop If]
    if(I < m_VineBlendList1P.Length)
    {
        // End:0x78
        if(m_VineBlendList1P[I] != none)
        {
            m_VineBlendList1P[I].VineInactive();
        }
        I++;
        // [Loop Continue]
        goto J0x1E;
    }
    I = 0;
    J0x91:

    // End:0xF9 [Loop If]
    if(I < m_VineBlendList3P.Length)
    {
        // End:0xEB
        if(m_VineBlendList3P[I] != none)
        {
            m_VineBlendList3P[I].VineInactive();
        }
        I++;
        // [Loop Continue]
        goto J0x91;
    }
    m_bBeamActive = false;
    m_BeamTarget = none;
    // End:0x14A
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('DragChain', 0);
    }
    // End:0x20F
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('DragChain', 0);
    }
    //return;    
}

event Generic1(optional byte byExtraData)
{
    DisconnectBeam();
    m_bVineInterrupted = true;
    //return;    
}
