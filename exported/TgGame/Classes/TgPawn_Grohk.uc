class TgPawn_Grohk extends TgPawn_Character
    native(ChampGrohk)
    config(Game)
    hidecategories(Navigation);

const TGPAWN_GROHK_TEMPEST_OVERLY_FX_ID = 6870;

var Actor r_InhandTarget;
var Vector r_InhandHitOffset;
var bool c_bIsInTempest;
var float c_fTempestOverlayStrength;
var const float c_fTempestRampUpRate;
var const float c_fTempsetRampDownRate;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_InhandHitOffset, r_InhandTarget;
}

// Export UTgPawn_Grohk::execGetOverlayMaterial(FFrame&, void* const)
native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x46
        case 1:
            return "PC_Shaman.Anims.AS_PC_Shaman_3p_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining)
{
    super(TgPawn).OnDeviceFormStartFire(nEquipSlot, FireDuration, nFireMode, nAmmoRemaining);
    switch(nEquipSlot)
    {
        // End:0x56
        case 2:
            c_bIsInTempest = true;
            // End:0x59
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function OnDeviceFormStopFire(int nEquipSlot)
{
    super(TgPawn).OnDeviceFormStopFire(nEquipSlot);
    switch(nEquipSlot)
    {
        // End:0x3A
        case 2:
            c_bIsInTempest = false;
            // End:0x3D
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    c_fTempestRampUpRate=3.3300000
    c_fTempsetRampDownRate=3.3300000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Grohk.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
        m_CompositeTextures[0]=(CompTexture=none,TextureParamName="Diffuse")
        m_CompositeTextures[1]=(CompTexture=none,TextureParamName="Normal")
        m_CompositeTextures[2]=(CompTexture=none,TextureParamName="Specular")
        m_CompositeTextures[3]=(CompTexture=none,TextureParamName="Mask")
        m_nCompositeTextureSizeX=2048
        m_nCompositeTextureSizeY=2048
        m_CompositeParts[0]=(MeshAsmId=5470,DestOffsetX=0,DestOffsetY=0,RegionSizeX=1024,RegionSizeY=2048)
        m_CompositeParts[1]=(MeshAsmId=5471,DestOffsetX=1024,DestOffsetY=0,RegionSizeX=1024,RegionSizeY=1024)
        m_CompositeParts[2]=(MeshAsmId=5477,DestOffsetX=1024,DestOffsetY=1024,RegionSizeX=512,RegionSizeY=1024)
        m_CompositeParts[3]=(MeshAsmId=5475,DestOffsetX=1536,DestOffsetY=1024,RegionSizeX=512,RegionSizeY=512)
        m_CompositeParts[4]=(MeshAsmId=5473,DestOffsetX=1536,DestOffsetY=1536,RegionSizeX=512,RegionSizeY=512)
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Grohk.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bShouldApplyCCImmuneOverlay=false
    m_sGameplayPackage="Grohk"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Grohk.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=1.4000000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Grohk.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Grohk.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Grohk.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Grohk.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    BaseEyeHeight=50.0000000
    EyeHeight=50.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Grohk.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Grohk.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}