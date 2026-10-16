class TgDeviceForm_Drag extends TgDeviceForm
    native(ChampMakoa);

enum EDragState
{
    DRAG_Inactive,                  // 0
    DRAG_Throw,                     // 1
    DRAG_Hit,                       // 2
    DRAG_Pull,                      // 3
    DRAG_EndPull,                   // 4
    DRAG_MissThrow,                 // 5
    DRAG_MissInvalid,               // 6
    DRAG_MissThrowEnd,              // 7
    DRAG_MissInvalidEnd,            // 8
    DRAG_CloseRangeEnd,             // 9
    DRAG_MAX                        // 10
};

var Actor m_BeamTarget;
var bool m_bIsPawnTarget;
var int m_nPostureID;
var Vector m_vReleaseLocation;
var float m_fReleaseTime;
var const float m_fMissNoHitEndDistance;
var const float m_fMissNoHitEndTime;
var const float m_fMissInvalidEndDistance;
var const float m_fMissInvalidEndTime;
var const float m_fCloseRangeEndDistance;
var float m_fTruePostfireTime;
var export editinline TgSkeletalMeshComponent m_ChainMesh;
var const int m_nChainMeshID;
var TgSkelCon_HookChain c_ChainSkelCon;
var const name m_ChainSocket;
var array<TgAnimNodeBlendByAbilityDrag> m_DragBlendList1P;
var array<TgAnimNodeBlendByAbilityDrag> m_DragBlendList3P;
var array<TgAnimNodeBlendByAbilityDragChain> m_ChainBlendList;
var TgDeviceForm_Drag.EDragState m_DragState;

// Export UTgDeviceForm_Drag::execHandleMissConditions(FFrame&, void* const)
native function HandleMissConditions();

// Export UTgDeviceForm_Drag::execUpdateChainEffects(FFrame&, void* const)
native function UpdateChainEffects(Vector vEndPoint);

// Export UTgDeviceForm_Drag::execGetChainSocketLocation(FFrame&, void* const)
native function Vector GetChainSocketLocation();

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityDrag AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_DragBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityDrag', AnimNode)
    {
        m_DragBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityDrag AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_DragBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityDrag', AnimNode)
    {
        m_DragBlendList1P.AddItem(AnimNode);        
    }    
    //return;    
}

function CacheChainAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityDragChain AnimNode;

    m_ChainBlendList.Length = 0;
    // End:0x43
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0x8E
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityDragChain', AnimNode)
    {
        m_ChainBlendList.AddItem(AnimNode);        
    }    
    //return;    
}

function ConnectBeamToTarget(Actor Target)
{
    local TgPawn PawnTarget;

    // End:0x56
    if((((m_BeamTarget != none) && m_bIsPawnTarget) && Target != none) && Target.IsA('TgProjectile'))
    {
        return;
    }
    // End:0xF0
    if((m_BeamTarget != none) && m_bIsPawnTarget)
    {
        PawnTarget = TgPawn(m_BeamTarget);
        // End:0xE5
        if(m_nPostureID >= 0)
        {
            // End:0xE5
            if(PawnTarget != none)
            {
                PawnTarget.PopPosture(m_nPostureID);
                m_nPostureID = -1;
            }
        }
        PawnTarget = none;
    }
    m_BeamTarget = Target;
    // End:0x162
    if(m_BeamTarget != none)
    {
        m_vReleaseLocation = m_BeamTarget.Location;
        UpdateChainEffects(m_BeamTarget.Location);
    }
    PawnTarget = TgPawn(m_BeamTarget);
    // End:0x19C
    if(PawnTarget != none)
    {
        m_bIsPawnTarget = true;        
    }
    else
    {
        m_bIsPawnTarget = false;
    }
    // End:0x1E0
    if(m_bIsPawnTarget)
    {
        m_nPostureID = PawnTarget.PushPosture(19);
    }
    //return;    
}

event Generic1(optional byte byExtraData)
{
    local int I;

    // End:0x11D
    if((int(m_DragState) == int(1)) || int(m_DragState) == int(2))
    {
        m_DragState = 3;
        I = 0;
        J0x42:

        // End:0xAA [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0x9C
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookPull();
            }
            I++;
            // [Loop Continue]
            goto J0x42;
        }
        I = 0;
        J0xB5:

        // End:0x11D [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0x10F
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookPull();
            }
            I++;
            // [Loop Continue]
            goto J0xB5;
        }
    }
    //return;    
}

event Generic2(optional byte byExtraData)
{
    local int I;

    // End:0x290
    if((int(m_DragState) == int(1)) || int(m_DragState) == int(2))
    {
        // End:0x62
        if(m_BeamTarget != none)
        {
            m_vReleaseLocation = m_BeamTarget.Location;
        }
        m_fReleaseTime = PawnOwner.WorldInfo.TimeSeconds;
        ConnectBeamToTarget(none);
        m_DragState = 5;
        // End:0x137
        if((PawnOwner != none) && m_ChainMesh != none)
        {
            m_ChainMesh.FxActivateIndependant('Generic1', 0, m_vReleaseLocation, Normal(PawnOwner.Location - m_vReleaseLocation));
        }
        I = 0;
        J0x142:

        // End:0x1AA [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0x19C
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookMissNotHit();
            }
            I++;
            // [Loop Continue]
            goto J0x142;
        }
        I = 0;
        J0x1B5:

        // End:0x21D [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0x20F
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookMissNotHit();
            }
            I++;
            // [Loop Continue]
            goto J0x1B5;
        }
        I = 0;
        J0x228:

        // End:0x290 [Loop If]
        if(I < m_ChainBlendList.Length)
        {
            // End:0x282
            if(m_ChainBlendList[I] != none)
            {
                m_ChainBlendList[I].ChainMiss();
            }
            I++;
            // [Loop Continue]
            goto J0x228;
        }
    }
    //return;    
}

event Generic3(optional byte byExtraData)
{
    local PhysicalMaterial TracedMaterial;
    local Vector HitLocation, chainDirection;
    local float TraceLength;
    local name TracedMaterialType;
    local int I;

    // End:0x51A
    if(((int(m_DragState) == int(1)) || int(m_DragState) == int(2)) || int(m_DragState) == int(3))
    {
        // End:0x78
        if(m_BeamTarget != none)
        {
            m_vReleaseLocation = m_BeamTarget.Location;
        }
        m_fReleaseTime = PawnOwner.WorldInfo.TimeSeconds;
        ConnectBeamToTarget(none);
        // End:0x291
        if((PawnOwner != none) && m_ChainMesh != none)
        {
            chainDirection = Normal(m_vReleaseLocation - PawnOwner.Location);
            TraceLength = 10.0000000;
            TracedMaterial = PawnOwner.TraceWorldPhysicalGeometry(m_vReleaseLocation - (chainDirection * TraceLength), m_vReleaseLocation + (chainDirection * TraceLength), HitLocation);
            TracedMaterialType = 'Default';
            // End:0x21F
            if((!IsZero(HitLocation) && TracedMaterial != none) && TracedMaterial.MaterialTypeName != 'None')
            {
                TracedMaterialType = TracedMaterial.MaterialTypeName;
            }
            PawnOwner.SetSwitch('MaterialType', TracedMaterialType);
            m_ChainMesh.FxActivateIndependant('Generic2', 0, m_vReleaseLocation, -chainDirection);
        }
        // End:0x3B5
        if(VSize(m_vReleaseLocation - (GetChainSocketLocation())) <= m_fCloseRangeEndDistance)
        {
            I = 0;
            J0x2C1:

            // End:0x329 [Loop If]
            if(I < m_DragBlendList1P.Length)
            {
                // End:0x31B
                if(m_DragBlendList1P[I] != none)
                {
                    m_DragBlendList1P[I].HookCloseRangeEnd();
                }
                I++;
                // [Loop Continue]
                goto J0x2C1;
            }
            I = 0;
            J0x334:

            // End:0x39C [Loop If]
            if(I < m_DragBlendList3P.Length)
            {
                // End:0x38E
                if(m_DragBlendList3P[I] != none)
                {
                    m_DragBlendList3P[I].HookCloseRangeEnd();
                }
                I++;
                // [Loop Continue]
                goto J0x334;
            }
            HideChain();
            m_DragState = 9;            
        }
        else
        {
            I = 0;
            J0x3C0:

            // End:0x428 [Loop If]
            if(I < m_DragBlendList1P.Length)
            {
                // End:0x41A
                if(m_DragBlendList1P[I] != none)
                {
                    m_DragBlendList1P[I].HookMissInvalid();
                }
                I++;
                // [Loop Continue]
                goto J0x3C0;
            }
            I = 0;
            J0x433:

            // End:0x49B [Loop If]
            if(I < m_DragBlendList3P.Length)
            {
                // End:0x48D
                if(m_DragBlendList3P[I] != none)
                {
                    m_DragBlendList3P[I].HookMissInvalid();
                }
                I++;
                // [Loop Continue]
                goto J0x433;
            }
            I = 0;
            J0x4A6:

            // End:0x50E [Loop If]
            if(I < m_ChainBlendList.Length)
            {
                // End:0x500
                if(m_ChainBlendList[I] != none)
                {
                    m_ChainBlendList[I].ChainInvalid();
                }
                I++;
                // [Loop Continue]
                goto J0x4A6;
            }
            m_DragState = 6;
        }
    }
    //return;    
}

event Generic4(optional byte byExtraData)
{
    local int I;

    // End:0x13D
    if(((int(m_DragState) == int(1)) || int(m_DragState) == int(2)) || int(m_DragState) == int(3))
    {
        m_DragState = 4;
        I = 0;
        J0x58:

        // End:0xC0 [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0xB2
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookEnd();
            }
            I++;
            // [Loop Continue]
            goto J0x58;
        }
        I = 0;
        J0xCB:

        // End:0x133 [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0x125
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookEnd();
            }
            I++;
            // [Loop Continue]
            goto J0xCB;
        }
        HideChain();
    }
    //return;    
}

simulated event StartMissNoHitEnd()
{
    local int I;

    // End:0x110
    if(int(m_DragState) == int(5))
    {
        I = 0;
        J0x1F:

        // End:0x87 [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0x79
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookEndMissNoHit();
            }
            I++;
            // [Loop Continue]
            goto J0x1F;
        }
        I = 0;
        J0x92:

        // End:0xFA [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0xEC
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookEndMissNoHit();
            }
            I++;
            // [Loop Continue]
            goto J0x92;
        }
        HideChain();
        m_DragState = 7;
    }
    //return;    
}

simulated event StartMissInvalidEnd()
{
    local int I;

    // End:0x110
    if(int(m_DragState) == int(6))
    {
        I = 0;
        J0x1F:

        // End:0x87 [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0x79
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookEndMissInvalid();
            }
            I++;
            // [Loop Continue]
            goto J0x1F;
        }
        I = 0;
        J0x92:

        // End:0xFA [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0xEC
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookEndMissInvalid();
            }
            I++;
            // [Loop Continue]
            goto J0x92;
        }
        HideChain();
        m_DragState = 8;
    }
    //return;    
}

simulated function HideChain()
{
    StopChainEffects();
    ConnectBeamToTarget(none);
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local int I;

    PlayChainEffects();
    m_bIsPawnTarget = false;
    m_DragState = 1;
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    I = 0;
    J0x5E:

    // End:0xC6 [Loop If]
    if(I < m_DragBlendList1P.Length)
    {
        // End:0xB8
        if(m_DragBlendList1P[I] != none)
        {
            m_DragBlendList1P[I].ThrowHook();
        }
        I++;
        // [Loop Continue]
        goto J0x5E;
    }
    I = 0;
    J0xD1:

    // End:0x139 [Loop If]
    if(I < m_DragBlendList3P.Length)
    {
        // End:0x12B
        if(m_DragBlendList3P[I] != none)
        {
            m_DragBlendList3P[I].ThrowHook();
        }
        I++;
        // [Loop Continue]
        goto J0xD1;
    }
    I = 0;
    J0x144:

    // End:0x1AC [Loop If]
    if(I < m_ChainBlendList.Length)
    {
        // End:0x19E
        if(m_ChainBlendList[I] != none)
        {
            m_ChainBlendList[I].ChainThrow();
        }
        I++;
        // [Loop Continue]
        goto J0x144;
    }
    //return;    
}

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    local int I;

    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    // End:0x1CC
    if(int(m_DragState) == int(1))
    {
        ConnectBeamToTarget(Target);
        m_DragState = 2;
        I = 0;
        J0x7E:

        // End:0xE6 [Loop If]
        if(I < m_DragBlendList1P.Length)
        {
            // End:0xD8
            if(m_DragBlendList1P[I] != none)
            {
                m_DragBlendList1P[I].HookHit();
            }
            I++;
            // [Loop Continue]
            goto J0x7E;
        }
        I = 0;
        J0xF1:

        // End:0x159 [Loop If]
        if(I < m_DragBlendList3P.Length)
        {
            // End:0x14B
            if(m_DragBlendList3P[I] != none)
            {
                m_DragBlendList3P[I].HookHit();
            }
            I++;
            // [Loop Continue]
            goto J0xF1;
        }
        I = 0;
        J0x164:

        // End:0x1CC [Loop If]
        if(I < m_ChainBlendList.Length)
        {
            // End:0x1BE
            if(m_ChainBlendList[I] != none)
            {
                m_ChainBlendList[I].ChainHit();
            }
            I++;
            // [Loop Continue]
            goto J0x164;
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    switch(m_DragState)
    {
        // End:0x18
        case 1:
        // End:0x1D
        case 2:
        // End:0x30
        case 3:
            Generic4();
            // End:0x5A
            break;
        // End:0x42
        case 5:
            StartMissNoHitEnd();
            // End:0x5A
            break;
        // End:0x54
        case 6:
            StartMissInvalidEnd();
            // End:0x5A
            break;
        // End:0xFFFF
        default:
            // End:0x5A
            break;
            break;
    }
    m_DragState = 0;
    super.StopFire(nFireModeNum);
    //return;    
}

simulated function PlayChainEffects()
{
    // End:0x11
    if(PawnOwner == none)
    {
        return;
    }
    // End:0x279
    if(((m_ChainMesh == none) && m_nChainMeshID > 0) && PawnOwner.Mesh != none)
    {
        m_ChainMesh = TgSkeletalMeshComponent(PawnOwner.CreateMeshComponent(m_nChainMeshID));
        // End:0x279
        if(m_ChainMesh != none)
        {
            PawnOwner.AttachComponent(m_ChainMesh);
            m_ChainMesh.SetLightEnvironment(PawnOwner.Mesh.LightEnvironment);
            m_ChainMesh.SetShadowParent(PawnOwner.Mesh);
            m_ChainMesh.SetTranslation(PawnOwner.Mesh.Translation);
            PawnOwner.InitializeSilhouetteComponent(m_ChainMesh);
            c_ChainSkelCon = TgSkelCon_HookChain(m_ChainMesh.FindSkelControl('ChainScale'));
            // End:0x266
            if(c_ChainSkelCon != none)
            {
                c_ChainSkelCon.m_DragDeviceForm = self;
                c_ChainSkelCon.m_ChainComponent = m_ChainMesh;
            }
            CacheChainAnimNodes(m_ChainMesh);
        }
    }
    // End:0x375
    if(m_ChainMesh != none)
    {
        // End:0x2FE
        if(PawnOwner.Mesh != none)
        {
            m_ChainMesh.SetTranslation(PawnOwner.Mesh.Translation);
        }
        // End:0x355
        if(c_ChainSkelCon != none)
        {
            c_ChainSkelCon.m_DragDeviceForm = self;
            c_ChainSkelCon.m_ChainComponent = m_ChainMesh;
        }
        m_ChainMesh.SetHidden(false);
    }
    //return;    
}

simulated function StopChainEffects()
{
    // End:0xB4
    if(m_ChainMesh != none)
    {
        m_ChainMesh.SetHidden(true);
        // End:0xB4
        if(PawnOwner != none)
        {
            // End:0xB4
            if(PawnOwner.Mesh != none)
            {
                m_ChainMesh.SetTranslation(PawnOwner.Mesh.Translation);
            }
        }
    }
    //return;    
}

simulated event SetChainLocation(Vector vLocalChainLocation, Vector vLocalSocketLocation)
{
    local Rotator chainRotation;

    // End:0x7F
    if(m_ChainMesh != none)
    {
        m_ChainMesh.SetTranslation(vLocalChainLocation);
        chainRotation = Rotator(vLocalChainLocation - vLocalSocketLocation);
        m_ChainMesh.SetRotation(chainRotation);
    }
    //return;    
}

defaultproperties
{
    m_fMissNoHitEndDistance=80.0000000
    m_fMissNoHitEndTime=0.1000000
    m_fMissInvalidEndDistance=80.0000000
    m_fMissInvalidEndTime=0.1000000
    m_fCloseRangeEndDistance=200.0000000
    m_fTruePostfireTime=0.3000000
    m_nChainMeshID=5925
    m_ChainSocket="WSO_FX_01"
}