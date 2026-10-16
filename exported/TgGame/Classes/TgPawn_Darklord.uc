class TgPawn_Darklord extends TgPawn_Character
    native(ChampDarklord)
    config(Game)
    hidecategories(Navigation);

var bool m_bUseWhirlZoom;

// Export UTgPawn_Darklord::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

simulated function AddJoinForcedView(TgPawn_Character Source, TgPawn_Character Target)
{
    // End:0x71
    if((Source != none) && Target != none)
    {
        Source.AddForcedViewTarget(Target, Class'TgGame.TgDevice_Spite'.default.m_fJoinViewLerpTime, 10.0000000, self, 0.0000000);
    }
    //return;    
}

simulated function RemoveJoinForcedView(TgPawn_Character Source, TgPawn_Character Target)
{
    // End:0x74
    if((Source != none) && Target != none)
    {
        Source.RemoveForcedViewTarget(self);
        Source.AddForcedViewTarget(Target, 0.2000000, 0.2000000, self);
    }
    //return;    
}

function TgPawn.EEmote GetDeviceEmoteType(TgDevice Dev)
{
    // End:0x4A
    if(Dev != none)
    {
        switch(Dev.r_eEquippedAt)
        {
            // End:0x3F
            case 16:
                return 0;
            // End:0x47
            case 18:
                return 13;
            // End:0xFFFF
            default:
                break;
            }
    }
    else
    {
        return super(TgPawn).GetDeviceEmoteType(Dev);
        //return ReturnValue;        
    }
}

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining)
{
    local TgDeviceForm form;

    form = c_EquipForm[nEquipSlot];
    // End:0xAA
    if(form != none)
    {
        switch(nEquipSlot)
        {
            // End:0xA7
            case 1:
                SetRTPCValue('DarklordInhandFireModeIndex', float(nFireMode));
                // End:0xA4
                if(m_WeaponMesh != none)
                {
                    m_WeaponMesh.SetRTPCValue('DarklordInhandFireModeIndex', float(nFireMode));
                }
                // End:0xAA
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        super(TgPawn).OnDeviceFormStartFire(nEquipSlot, FireDuration, nFireMode, nAmmoRemaining);
        //return;        
    }
}

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    super.GetCameraZoomOverride(fZoom, fZoomDuration);
    // End:0x38
    if(m_bUseWhirlZoom)
    {
        fZoomDuration = 0.0500000;
    }
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x57
        case 1:
            return "PC_Darklord_Skin00A.Anims.AS_PC_DarkLord_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    s_bReplicateInhandAmmo=true
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Darklord.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Darklord.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bShouldApplyCCImmuneOverlay=false
    m_sGameplayPackage="Darklord"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Darklord.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Darklord.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Darklord.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Darklord.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Darklord.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Darklord.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Darklord.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}