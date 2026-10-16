class TgPawn_BarrierTank extends TgPawn_Character
    native(ChampBarrierTank)
    config(Game)
    hidecategories(Navigation);

const IMPASSE_TOTAL_WALL_SEGMENTS = 5;

struct native WallPlacementInfo
{
    var bool bIsValidLocation;
    var Vector vSpawnLocation;

    structdefaultproperties
    {
        bIsValidLocation=false
        vSpawnLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var WallPlacementInfo m_WallPlacementInfos[5];
var const Vector m_vSegmentExtent;
var const Vector m_vOpenSpotExtent;
var const float m_fWallTraceDownDistance;
var const float m_fWallOpenSpotTolerance;
var const float m_fInitialWallScaleZ;
var bool r_bInGaeBolg;
var bool m_bUseGaeBolgRetrieve;
var float m_fGaeBolgJumpZModifier;
var int r_nInhandAmmoRemaining;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && !bNetOwner || bDemoRecording)
        r_bInGaeBolg;

    // Pos:0x031
    if(int(Role) == int(ROLE_Authority))
        r_nInhandAmmoRemaining;
}

// Export UTgPawn_BarrierTank::execUpdateWallPlacementInfos(FFrame&, void* const)
native function UpdateWallPlacementInfos(Vector OriginLocation, Rotator originRotation);

function StartGaeBolg(float fJumpZMultiplier)
{
    r_bInGaeBolg = true;
    m_fGaeBolgJumpZModifier = fJumpZMultiplier;
    bNetDirty = true;
    //return;    
}

singular function EndGaeBolg()
{
    r_bInGaeBolg = false;
    bNetDirty = true;
    //return;    
}

simulated function float GetJumpSpeedMultiplier()
{
    // End:0x1A
    if(r_bInGaeBolg)
    {
        return m_fGaeBolgJumpZModifier;        
    }
    else
    {
        return 1.0000000;
    }
    //return ReturnValue;    
}

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local Vector AccelDir, HorizontalVelocity;

    // End:0x187
    if((r_bInGaeBolg && bJumpCapable) && CheckPhysicsStateForJumping())
    {
        // End:0x161
        if(!IsZero(Acceleration))
        {
            AccelDir = Normal2D(Acceleration);
            HorizontalVelocity = Velocity;
            HorizontalVelocity.Z = 0.0000000;
            HorizontalVelocity += (AccelDir * GroundSpeed);
            // End:0xEF
            if(VSize2D(HorizontalVelocity) > GroundSpeed)
            {
                HorizontalVelocity = Normal2D(HorizontalVelocity) * GroundSpeed;
            }
            Velocity.X = HorizontalVelocity.X;
            Velocity.Y = HorizontalVelocity.Y;
        }
        // End:0x187
        if(JumpZSpeed == 0.0000000)
        {
            JumpZSpeed = JumpZ;
        }
    }
    return super.DoJump(bUpdating, JumpZSpeed);
    //return ReturnValue;    
}

simulated function OnStartTimelapseNewDeviceState()
{
    local int I;

    super.OnStartTimelapseNewDeviceState();
    I = 1;
    J0x15:

    // End:0xD0 [Loop If]
    if(I < 33)
    {
        // End:0xC2
        if(c_EquipForm[I] != none)
        {
            // End:0xC2
            if(c_EquipForm[I].IsA('TgDeviceForm_GaeBolg'))
            {
                // End:0x98
                if(int(r_ReplicatedDeviceState[I]) == int(1))
                {
                    m_bUseGaeBolgRetrieve = true;                    
                }
                else
                {
                    // End:0xC2
                    if(int(r_ReplicatedDeviceState[I]) == int(0))
                    {
                        m_bUseGaeBolgRetrieve = false;
                    }
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    //return;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    local TgDevice_GeometryBarrierTank impasseDevice;

    // End:0x2B
    if(c_CurrentTargetingDevice != none)
    {
        impasseDevice = TgDevice_GeometryBarrierTank(c_CurrentTargetingDevice);
    }
    super(TgPawn).SetTargetingDevice(Dev, SwapStrategy);
    // End:0xB5
    if(((impasseDevice != none) && impasseDevice != c_CurrentTargetingDevice) && impasseDevice.IsInState('DeviceBuildup'))
    {
        impasseDevice.InterruptFiring();
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x5D
        case 1:
            return "PC_BarrierTank_Skin00A.Anims.AS_PC_BarrierTank_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_vSegmentExtent=(X=64.0000000,Y=102.0000000,Z=224.0000000)
    m_vOpenSpotExtent=(X=25.0000000,Y=25.0000000,Z=35.0000000)
    m_fWallTraceDownDistance=60.0000000
    m_fWallOpenSpotTolerance=0.4000000
    m_fInitialWallScaleZ=0.0100000
    m_fMountZoomOverride=1.3000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_BarrierTank.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_BarrierTank.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_sGameplayPackage="Inara"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_BarrierTank.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_BarrierTank.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_BarrierTank.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_BarrierTank.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_BarrierTank.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=55.0000000
    EyeHeight=55.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_BarrierTank.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_BarrierTank.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}