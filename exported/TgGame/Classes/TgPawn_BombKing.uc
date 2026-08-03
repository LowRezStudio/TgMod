class TgPawn_BombKing extends TgPawn_Character
    native(ChampBombKing)
    config(Game)
    hidecategories(Navigation);

enum EWeaponMeshState
{
    WMS_Inhand,                     // 0
    WMS_Grumpy,                     // 1
    WMS_Poppy,                      // 2
    WMS_MAX                         // 3
};

var(BouncyBomb) float m_fBounceDampingVertMin;
var(BouncyBomb) float m_fBounceDampingVertMax;
var(BouncyBomb) float m_fBounceDampingHorizMin;
var(BouncyBomb) float m_fBounceDampingHorizMax;
var bool c_bRenderKingBombMesh;
var bool m_bForced3PDuringKingBomb;
var int c_nKingBombMeshID;
var() Vector m_fKingBombCameraOffset;
var repnotify TgPawn_BombKing.EWeaponMeshState r_weaponMeshState;
var int m_nInhandID;
var int m_nGrumpyBombID;
var int m_nPoppyBombID;
var float r_fJoltKnockback;
var Class<TgDevice> m_InhandClass;
var Class<TgDevice> m_GrumpyBombClass;
var Class<TgDevice> m_PoppyBombClass;

replication
{
    // Pos:0x000
    if((bNetDirty && !bNetInitial) && !bNetOwner || bDemoRecording)
        r_weaponMeshState;

    // Pos:0x03B
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_fJoltKnockback;
}

// Export UTgPawn_BombKing::execReloadMeshAssemblies(FFrame&, void* const)
native function ReloadMeshAssemblies();

// Export UTgPawn_BombKing::execShouldBeFirstPersonThisTick(FFrame&, void* const)
native function bool ShouldBeFirstPersonThisTick();

// Export UTgPawn_BombKing::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_BombKing::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

simulated function OnRespawn()
{
    super.OnRespawn();
    c_bRenderKingBombMesh = false;
    m_bForced3PDuringKingBomb = false;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x183
    if(VarName == 'r_weaponMeshState')
    {
        switch(r_weaponMeshState)
        {
            // End:0x9C
            case 0:
                // End:0x99
                if(m_WeaponMesh != none)
                {
                    SwapStrategy.RetrieveStrategy = 1;
                    m_WeaponMesh.SetActiveWeapon(1, m_nInhandID, m_InhandClass, SwapStrategy);
                }
                // End:0x183
                break;
            // End:0x10E
            case 1:
                // End:0x10B
                if(m_WeaponMesh != none)
                {
                    SwapStrategy.RetrieveStrategy = 1;
                    m_WeaponMesh.SetActiveWeapon(3, m_nGrumpyBombID, m_GrumpyBombClass, SwapStrategy);
                }
                // End:0x183
                break;
            // End:0x180
            case 2:
                // End:0x17D
                if(m_WeaponMesh != none)
                {
                    SwapStrategy.RetrieveStrategy = 1;
                    m_WeaponMesh.SetActiveWeapon(4, m_nPoppyBombID, m_PoppyBombClass, SwapStrategy);
                }
                // End:0x183
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        super.ReplicatedEvent(VarName);
        //return;        
    }
}

simulated function SwapToKingBombMesh()
{
    // End:0x2F
    if(!c_bRenderKingBombMesh)
    {
        c_bRenderKingBombMesh = true;
        ReloadMeshAssemblies();
        SwapToLiveMesh();
    }
    //return;    
}

simulated function SwapFromKingBombMesh()
{
    // End:0x2D
    if(c_bRenderKingBombMesh)
    {
        c_bRenderKingBombMesh = false;
        ReloadMeshAssemblies();
        SwapToLiveMesh();
    }
    //return;    
}

reliable server function SwitchToStickyBomb()
{
    r_weaponMeshState = 0;
    bNetDirty = true;
    //return;    
}

reliable server function SwitchToGrumpyBomb()
{
    r_weaponMeshState = 1;
    bNetDirty = true;
    //return;    
}

reliable server function SwitchToPoppyBomb()
{
    r_weaponMeshState = 2;
    bNetDirty = true;
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    local TgObject.TG_EQUIP_POINT eqp;

    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    // End:0x99
    if(int(Role) == int(ROLE_AutonomousProxy))
    {
        eqp = GetEquipSlotOfDevice(Dev);
        switch(eqp)
        {
            // End:0x72
            case 1:
                SwitchToStickyBomb();
                // End:0x99
                break;
            // End:0x84
            case 3:
                SwitchToGrumpyBomb();
                // End:0x99
                break;
            // End:0x96
            case 4:
                SwitchToPoppyBomb();
                // End:0x99
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        //return;        
    }
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x4A
        case 1:
            return "PC_BombKing.Anims.AS_PC_BombKing_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function Vector GetCameraOffsetOverride(Vector originalOffset)
{
    // End:0x17
    if(m_bForced3PDuringKingBomb)
    {
        return m_fKingBombCameraOffset;
    }
    return super(TgPawn).GetCameraOffsetOverride(originalOffset);
    //return ReturnValue;    
}

simulated function PlayDyingEffects()
{
    SwapFromKingBombMesh();
    super(TgPawn).PlayDyingEffects();
    //return;    
}

simulated event PreTimeLapse(bool bPlayOfTheGame)
{
    ReloadMeshAssemblies();
    super.PreTimeLapse(bPlayOfTheGame);
    //return;    
}

simulated event PostTimeLapse(bool bPlayOfTheGame)
{
    ReloadMeshAssemblies();
    super(TgPawn).PostTimeLapse(bPlayOfTheGame);
    //return;    
}

simulated function SpecialHideStickyBomb(int projID, int deployID)
{
    local TgRepInfo_Game GRI;
    local int I;
    local TgProj_BombKingStickyBomb Proj;
    local TgDevice_BombKingInhand inhandDev;

    // End:0x11
    if(projID <= 0)
    {
        return;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x1B0
    if(GRI != none)
    {
        inhandDev = TgDevice_BombKingInhand(GetDeviceByEqPoint(1));
        I = 0;
        J0x7A:

        // End:0x1B0 [Loop If]
        if(I < GRI.m_Projectiles.Length)
        {
            Proj = TgProj_BombKingStickyBomb(GRI.m_Projectiles[I]);
            // End:0x1A2
            if((Proj != none) && Proj.m_nClientFireRequestId == projID)
            {
                // End:0x15F
                if(inhandDev != none)
                {
                    inhandDev.RemovePendingConversion(Proj, deployID);
                }
                // End:0x1A2
                if(Proj.c_Mesh != none)
                {
                    Proj.SpecialHideProjectile();
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x7A;
        }
    }
    //return;    
}

defaultproperties
{
    m_fBounceDampingVertMin=0.5000000
    m_fBounceDampingVertMax=1.0000000
    m_fBounceDampingHorizMin=0.4000000
    m_fBounceDampingHorizMax=0.7500000
    c_nKingBombMeshID=5861
    m_fKingBombCameraOffset=(X=-160.0000000,Y=0.0000000,Z=15.0000000)
    m_nInhandID=14308
    m_nGrumpyBombID=13412
    m_nPoppyBombID=13407
    m_InhandClass=Class'TgGame.TgDevice_BombKingInhand'
    m_GrumpyBombClass=Class'TgGame.TgDevice_GrumpyBomb'
    m_PoppyBombClass=Class'TgGame.TgDevice_PoppyBomb'
    m_fMountZoomOverride=1.3000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_BombKing.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_BombKing.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="BombKing"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_BombKing.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_BombKing.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_BombKing.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_BombKing.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_BombKing.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fMountScaleOverride=0.9000000
    BaseEyeHeight=35.0000000
    EyeHeight=35.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_BombKing.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_BombKing.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}