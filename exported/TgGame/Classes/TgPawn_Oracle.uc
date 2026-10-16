class TgPawn_Oracle extends TgPawn_Character
    native(ChampOracle)
    config(Game)
    hidecategories(Navigation);

const ORACLE_MAX_STACKS_PER_TARGET = 4;
const ORACLE_MAX_STACK_TARGETS = 10;
const ORACLE_STACK_FX_GROUP_ID = 57644;
const ORACLE_STACK_1P_FX_ID = 7739;
const ORACLE_STACK_3P_FX_ID = 7740;

var Actor r_RestoreSoulTarget;
var Vector r_RestoreSoulHitOffset;
var bool r_bRestoreSoulActive;
var bool r_bHasAgonyTalent;
var int r_SoulStackTargetPawnId[10];
var repnotify int r_SoulStackTargetCount[10];
var int c_CachedSoulStackTargetCount[10];
var Vector c_InterpRestoreSoulHitOffset;
var float c_fRestoreSoulHitOffsetInterpSpeed;
var() float m_fFrictionMultiplier;
var int m_nStackAddedVictimFxId;
var int m_nStackAddedSourceFxId;
var int m_nMaxStacksVictimFxId;
var int m_nMaxStacksSourceFxId;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_RestoreSoulHitOffset, r_RestoreSoulTarget, 
        r_SoulStackTargetCount, r_SoulStackTargetPawnId, 
        r_bHasAgonyTalent, r_bRestoreSoulActive;
}

simulated event ReplicatedEvent(name VarName)
{
    local TgDeviceForm_OracleInhand inhandDeviceForm;

    switch(VarName)
    {
        // End:0x2C
        case 'r_SoulStackTargetCount':
            OnSoulStacksReplicated();
            // End:0xC6
            break;
        // End:0xC3
        case 'r_bRestoreSoulActive':
            inhandDeviceForm = TgDeviceForm_OracleInhand(c_EquipForm[1]);
            // End:0xC0
            if(inhandDeviceForm != none)
            {
                inhandDeviceForm.UpdateAmmoCountFx(inhandDeviceForm.m_fPreviousAmmoPerc, inhandDeviceForm.m_fCurrentAmmoPerc);
            }
            // End:0xC6
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0xC2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x77
        if((r_RestoreSoulTarget != none) && r_RestoreSoulTarget != r_TargetActor)
        {
            c_InterpRestoreSoulHitOffset = r_RestoreSoulHitOffset;
        }
        c_InterpRestoreSoulHitOffset = VInterpTo(c_InterpRestoreSoulHitOffset, r_RestoreSoulHitOffset, DeltaSeconds, c_fRestoreSoulHitOffsetInterpSpeed);
        r_TargetActor = r_RestoreSoulTarget;
    }
    // End:0xF5
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        UpdateSoulStacks();
    }
    //return;    
}

// Export UTgPawn_Oracle::execUpdateSoulStacks(FFrame&, void* const)
native function UpdateSoulStacks();

// Export UTgPawn_Oracle::execOnSoulStacksReplicated(FFrame&, void* const)
native function OnSoulStacksReplicated();

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x53
        case 1:
            return "PC_Oracle_Skin00A.Anims.AS_PC_Oracle_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

defaultproperties
{
    m_fFrictionMultiplier=0.2500000
    m_nStackAddedVictimFxId=7884
    m_nStackAddedSourceFxId=7883
    m_nMaxStacksVictimFxId=7849
    m_nMaxStacksSourceFxId=7850
    s_bReplicateInhandAmmo=true
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Oracle.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Oracle.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bShouldApplyCCImmuneOverlay=false
    m_sGameplayPackage="Seris"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Oracle.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Oracle.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Oracle.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Oracle.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Oracle.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Oracle.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Oracle.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}