class TgProj_Seedling extends TgProj_FreeGrenade
    native(ChampFairy)
    hidecategories(Navigation);

var const int m_nSecondaryProjToSpawn;
var int m_nSpawnsRemaining;
var export editinline SkeletalMeshComponent m_CachedSMC;
var TgSkelControlSingleBone m_GrenadeSkelControl;
var TgSkelControlSingleBone m_SpikesSkelControl;
var MaterialInstanceConstant m_fCachedMIC;
var Rotator m_rRotationalVelocity;
var export editinline TgSilhouetteComponent m_Silhouette;
var LinearColor m_LocalSilhouetteColor;
var bool m_bSilhouetteInitialized;
var bool m_bSilhouetteAllowed;
var bool m_bBuildupSoundPlayed;

// Export UTgProj_Seedling::execGetRotatedAim(FFrame&, void* const)
native function Vector GetRotatedAim(Vector initialAim, int Angle);

// Export UTgProj_Seedling::execInitializeSilhouetteComponent(FFrame&, void* const)
native function InitializeSilhouetteComponent();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    m_rRotationalVelocity.Pitch = -600000;
    //return;    
}

simulated event bool CheckTeamPassThrough(Actor Other)
{
    // End:0x26
    if(m_nSpawnsRemaining == 0)
    {
        return super(TgProjectile).CheckTeamPassThrough(Other);        
    }
    else
    {
        // End:0x4E
        if(Other.IsA('TgPawn_Character'))
        {
            return true;            
        }
        else
        {
            return super(TgProjectile).CheckTeamPassThrough(Other);
        }
    }
    //return ReturnValue;    
}

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem)
{
    local int I, RotationAmount;
    local Vector StartLoc, initialAim, AimDir;
    local TgDevice spawningDevice;
    local TgDeviceFire secondaryFiremode;
    local Class<Projectile> projClass;
    local TgProj_Seedling clusterBomb;

    // End:0x3BD
    if((((int(Role) == int(ROLE_Authority)) && m_OwnerFireMode != none) && m_nSpawnsRemaining > 0) && m_nSecondaryProjToSpawn > 0)
    {
        // End:0xFE
        if(m_OwnerFireMode != none)
        {
            spawningDevice = TgDevice(m_OwnerFireMode.m_Owner);
            // End:0xEB
            if((spawningDevice != none) && spawningDevice.m_FireMode.Length > 1)
            {
                secondaryFiremode = spawningDevice.m_FireMode[1];                
            }
            else
            {
                secondaryFiremode = m_OwnerFireMode;
            }
        }
        projClass = secondaryFiremode.GetProjectileClass();
        // End:0x3BD
        if(projClass != none)
        {
            StartLoc = Location;
            initialAim = m_vSpawnVelocity;
            initialAim.Z = 0.0000000;
            initialAim = Normal(initialAim) * 0.8660250;
            initialAim.Z = 0.5000000;
            RotationAmount = 65536 / m_nSecondaryProjToSpawn;
            I = 0;
            J0x1E1:

            // End:0x3BD [Loop If]
            if(I < m_nSecondaryProjToSpawn)
            {
                AimDir = GetRotatedAim(initialAim, I * RotationAmount);
                clusterBomb = TgProj_Seedling(TgRepInfo_Game(WorldInfo.GRI).SpawnSimulatedProjectile(TgGame(WorldInfo.Game).GetNextProjectileInstanceId(), secondaryFiremode.m_nId, Instigator, StartLoc, AimDir));
                // End:0x3AF
                if(clusterBomb != none)
                {
                    clusterBomb.m_OwnerFireMode = secondaryFiremode;
                    clusterBomb.r_vSpawnLocation = clusterBomb.Location;
                    clusterBomb.m_nSpawnsRemaining = m_nSpawnsRemaining - 1;
                    clusterBomb.CompleteInitialization();
                }
                I++;
                // [Loop Continue]
                goto J0x1E1;
            }
        }
    }
    return super(TgProj_Simulated).ApplyHit(Target, HitLocation, HitNormal, HitItem);
    //return ReturnValue;    
}

function float GetPostLandDuration()
{
    local TgDevice spawningDevice;
    local TgDeviceFire FireMode;

    // End:0xFF
    if(m_OwnerFireMode != none)
    {
        spawningDevice = TgDevice(m_OwnerFireMode.m_Owner);
        // End:0xFF
        if(spawningDevice != none)
        {
            // End:0xFF
            if(spawningDevice.m_FireMode.Length > 0)
            {
                FireMode = spawningDevice.m_FireMode[0];
                // End:0xFF
                if(FireMode != none)
                {
                    // End:0xDF
                    if(m_nSpawnsRemaining > 0)
                    {
                        return FireMode.GetCustomValue1();                        
                    }
                    else
                    {
                        return FireMode.GetCustomValue2();
                    }
                }
            }
        }
    }
    return super.GetPostLandDuration();
    //return ReturnValue;    
}

function StartLandExplodeTimer()
{
    super.StartLandExplodeTimer();
    // End:0xF6
    if(!m_bBuildupSoundPlayed)
    {
        m_bBuildupSoundPlayed = true;
        // End:0xF6
        if(c_Mesh != none)
        {
            // End:0x9E
            if(m_nSpawnsRemaining > 0)
            {
                c_Mesh.FxDeactivateGroup('Seedling_Buildup_Primary', 0);
                c_Mesh.FxActivateGroup('Seedling_Buildup_Primary', 0);                
            }
            else
            {
                c_Mesh.FxDeactivateGroup('Seedling_Buildup_Secondary', 0);
                c_Mesh.FxActivateGroup('Seedling_Buildup_Secondary', 0);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_nSecondaryProjToSpawn=4
    m_nSpawnsRemaining=1
    // Reference: TgSilhouetteComponentPaladins'TgGame.Default__TgProj_Seedling.MySilhouette'
    begin object name="MySilhouette" class=TgGame.TgSilhouetteComponentPaladins
    end object
    m_Silhouette=MySilhouette
    m_LocalSilhouetteColor=(R=1.0000000,G=0.7000000,B=0.1875000,A=0.2500000)
    m_bExplodeOnTouch=false
    m_bTrackProjectileForTimelapse=true
    m_fTrackingUpdateRate=0.2000000
    m_fPostLandDuration=1.0000000
    m_fTossZ=0.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Seedling.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Seedling.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Components[2]=MySilhouette
    CollisionComponent=CollisionCylinder
}