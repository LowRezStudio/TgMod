class TgDeviceForm_DragonSlam extends TgDeviceForm;

var bool m_bStartFireInAir;
var array<TgAnimNodeBlendByAbilityDragonSlam> m_DragonSlamBlendList1P;
var array<TgAnimNodeBlendByAbilityDragonSlam> m_DragonSlamBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityDragonSlam AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_DragonSlamBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityDragonSlam', AnimNode)
    {
        m_DragonSlamBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityDragonSlam AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_DragonSlamBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityDragonSlam', AnimNode)
    {
        m_DragonSlamBlendList1P.AddItem(AnimNode);        
    }    
    //return;    
}

event BuildUp(int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional float fBuildupTime = 0.0000000)
{
    // End:0x87
    if(((PawnOwner != none) && int(PawnOwner.Physics) == int(4)) || int(PawnOwner.Physics) == int(2))
    {
        m_bStartFireInAir = true;        
    }
    else
    {
        m_bStartFireInAir = false;
    }
    super.BuildUp(nFireMode, nEquipSlot, nSocketIndex, fBuildupTime);
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local int I;
    local TgPawn_Drogoz drogozPawn;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x172
    if(PawnOwner != none)
    {
        drogozPawn = TgPawn_Drogoz(PawnOwner);
        // End:0x172
        if(drogozPawn != none)
        {
            drogozPawn.m_bDragonSlamIsBlocking = true;
            drogozPawn.m_bUseDragonSlamRetrieve = true;
            drogozPawn.m_bDragonSlamHasHit = false;
            // End:0x172
            if(drogozPawn.Mesh != none)
            {
                drogozPawn.Mesh.FxActivateIndependant('UltimateActivated', 0, drogozPawn.Location, Vector(drogozPawn.Rotation));
            }
        }
    }
    I = 0;
    J0x17D:

    // End:0x21E [Loop If]
    if(I < m_DragonSlamBlendList1P.Length)
    {
        // End:0x210
        if(m_DragonSlamBlendList1P[I] != none)
        {
            // End:0x1E7
            if(m_bStartFireInAir)
            {
                m_DragonSlamBlendList1P[I].ReadyFlightFromAir();                
            }
            else
            {
                m_DragonSlamBlendList1P[I].ReadyFlightFromGround();
            }
        }
        I++;
        // [Loop Continue]
        goto J0x17D;
    }
    I = 0;
    J0x229:

    // End:0x2CA [Loop If]
    if(I < m_DragonSlamBlendList3P.Length)
    {
        // End:0x2BC
        if(m_DragonSlamBlendList3P[I] != none)
        {
            // End:0x293
            if(m_bStartFireInAir)
            {
                m_DragonSlamBlendList3P[I].ReadyFlightFromAir();                
            }
            else
            {
                m_DragonSlamBlendList3P[I].ReadyFlightFromGround();
            }
        }
        I++;
        // [Loop Continue]
        goto J0x229;
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local int I;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    I = 0;
    J0x5C:

    // End:0xC4 [Loop If]
    if(I < m_DragonSlamBlendList1P.Length)
    {
        // End:0xB6
        if(m_DragonSlamBlendList1P[I] != none)
        {
            m_DragonSlamBlendList1P[I].Fly();
        }
        I++;
        // [Loop Continue]
        goto J0x5C;
    }
    I = 0;
    J0xCF:

    // End:0x137 [Loop If]
    if(I < m_DragonSlamBlendList3P.Length)
    {
        // End:0x129
        if(m_DragonSlamBlendList3P[I] != none)
        {
            m_DragonSlamBlendList3P[I].Fly();
        }
        I++;
        // [Loop Continue]
        goto J0xCF;
    }
    // End:0x173
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('Drogoz_Ult', 0);
    }
    //return;    
}

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    local int I;
    local TgPawn_Drogoz drogozPawn;

    // End:0x7F
    if(PawnOwner != none)
    {
        drogozPawn = TgPawn_Drogoz(PawnOwner);
        // End:0x7F
        if(drogozPawn != none)
        {
            drogozPawn.m_fZoomDurationOverride = 0.0100000;
            drogozPawn.m_bDragonSlamHasHit = true;
        }
    }
    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    I = 0;
    J0xCA:

    // End:0x132 [Loop If]
    if(I < m_DragonSlamBlendList1P.Length)
    {
        // End:0x124
        if(m_DragonSlamBlendList1P[I] != none)
        {
            m_DragonSlamBlendList1P[I].HitTarget();
        }
        I++;
        // [Loop Continue]
        goto J0xCA;
    }
    I = 0;
    J0x13D:

    // End:0x1A5 [Loop If]
    if(I < m_DragonSlamBlendList3P.Length)
    {
        // End:0x197
        if(m_DragonSlamBlendList3P[I] != none)
        {
            m_DragonSlamBlendList3P[I].HitTarget();
        }
        I++;
        // [Loop Continue]
        goto J0x13D;
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    Cleanup();
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    Cleanup();
    //return;    
}

function Cleanup()
{
    local int I;
    local TgPawn_Drogoz drogozPawn;
    local TgPlayerController OwnerPC;

    // End:0x11F
    if(PawnOwner != none)
    {
        drogozPawn = TgPawn_Drogoz(PawnOwner);
        // End:0x11F
        if(drogozPawn != none)
        {
            drogozPawn.m_bDragonSlamIsBlocking = false;
            // End:0x11F
            if(!drogozPawn.m_bDragonSlamHasHit)
            {
                drogozPawn.m_fZoomDurationOverride = 0.0100000;
                OwnerPC = TgPlayerController(drogozPawn.Controller);
                // End:0x11F
                if(OwnerPC != none)
                {
                    // End:0x11F
                    if(drogozPawn != none)
                    {
                        drogozPawn.FxReactivateGroupSelf('Drogoz_UltMiss', 0);
                    }
                }
            }
        }
    }
    I = 0;
    J0x12A:

    // End:0x192 [Loop If]
    if(I < m_DragonSlamBlendList1P.Length)
    {
        // End:0x184
        if(m_DragonSlamBlendList1P[I] != none)
        {
            m_DragonSlamBlendList1P[I].EndFlying();
        }
        I++;
        // [Loop Continue]
        goto J0x12A;
    }
    I = 0;
    J0x19D:

    // End:0x205 [Loop If]
    if(I < m_DragonSlamBlendList3P.Length)
    {
        // End:0x1F7
        if(m_DragonSlamBlendList3P[I] != none)
        {
            m_DragonSlamBlendList3P[I].EndFlying();
        }
        I++;
        // [Loop Continue]
        goto J0x19D;
    }
    // End:0x23F
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Drogoz_Ult', 0);
    }
    //return;    
}
