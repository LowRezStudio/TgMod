class TgPawn_Princess extends TgPawn_Character
    config(Game)
    hidecategories(Navigation);

var TgDevice_Enlightenment m_CachedEnlightenment;
var TgDevice_EnlightenmentGun m_CachedEnlightenmentGun;
var TgCombatActor r_GraceTargets[15];

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_GraceTargets':
            ManageGraceTracers();
            // End:0x42
            break;
        // End:0xFFFF
        default:
            super.ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

simulated event ManageGraceTracers()
{
    local TgWeaponMeshActor_LianInhand InhandWeaponMesh;

    InhandWeaponMesh = TgWeaponMeshActor_LianInhand(m_WeaponMesh);
    // End:0x4A
    if(InhandWeaponMesh != none)
    {
        InhandWeaponMesh.ManageGraceTracers();
    }
    //return;    
}

function bool HasCachedEnlightenment()
{
    // End:0x2E
    if(m_CachedEnlightenment == none)
    {
        m_CachedEnlightenment = TgDevice_Enlightenment(GetDeviceByEqPoint(2));
    }
    return m_CachedEnlightenment != none;
    //return ReturnValue;    
}

function bool HasCachedEnlightenmentGun()
{
    // End:0x2E
    if(m_CachedEnlightenmentGun == none)
    {
        m_CachedEnlightenmentGun = TgDevice_EnlightenmentGun(GetDeviceByEqPoint(12));
    }
    return m_CachedEnlightenmentGun != none;
    //return ReturnValue;    
}

function ToggleEnlightenmentGun(bool bEnabled)
{
    local TgDevice newFiringDevice;
    local WeaponMeshSwapStrategy SwapStrategy;
    local int nEnlightenmentStartingAmmo;

    // End:0x175
    if(HasCachedEnlightenmentGun())
    {
        // End:0x10E
        if(bEnabled)
        {
            newFiringDevice = m_CachedEnlightenmentGun;
            // End:0x10B
            if(m_CachedEnlightenmentGun != none)
            {
                nEnlightenmentStartingAmmo = 1;
                // End:0xAD
                if(m_CachedEnlightenmentGun.GetCurrentFire() != none)
                {
                    nEnlightenmentStartingAmmo = int(m_CachedEnlightenmentGun.GetCurrentFire().GetCustomValue1());
                }
                m_CachedEnlightenmentGun.SetAmmo(((nEnlightenmentStartingAmmo > 0) ? nEnlightenmentStartingAmmo : 1));
                m_CachedEnlightenmentGun.m_bAutoFireAfterPostHitDelay = true;
            }            
        }
        else
        {
            newFiringDevice = GetDeviceByEqPoint(1);
        }
        // End:0x175
        if(newFiringDevice != none)
        {
            // End:0x175
            if(IsLocallyControlled() && PlayerController(Controller) != none)
            {
                SetTargetingDevice(newFiringDevice, SwapStrategy);
            }
        }
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x57
        case 1:
            return "PC_Princess_Skin00a.Anims.AS_PC_Princess_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Princess.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Princess.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bUsesRecoil=true
    m_sGameplayPackage="Princess"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Princess.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Princess.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Princess.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Princess.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Princess.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fRecoilSmoothRate=0.0600000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Princess.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Princess.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}