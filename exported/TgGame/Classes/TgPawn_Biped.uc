class TgPawn_Biped extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var() name m_nmLeftFootBone;
var() name m_nmRightFootBone;
var() name m_nmLeftFootControlName;
var() name m_nmRightFootControlName;
var float m_fOldLocationZ;
var bool m_bEnableRightFootPlacement;
var bool m_bEnableLeftFootPlacement;
var bool m_bMayDisableFootIKFromAnimNodes;
var bool m_bInitializedFootIKCachedNodeList;
var bool m_bApplyLeftHandWeaponIK;
var bool m_bSetHandIKStrengthFromAnimNodes;
var bool m_bInitializedHandIKCachedNodeList;
var bool c_bPlayingRefire;
var bool c_bRefireIsUpperBody;
var const float m_fZSmoothingRate;
var float m_fMaxFootPlacementDistSquared;
var SkelControlFootPlacement m_LeftLegControl;
var SkelControlFootPlacement m_RightLegControl;
var array<name> m_FootIKZeroStrengthAnimNodeNameList;
var array<AnimNode> m_FootIKZeroStrengthCachedNodeList;
var Vector m_vPreviousRightFootPosition;
var Vector m_vPreviousLeftFootPosition;
var float m_fCachedRightTracedFloor;
var float m_fCachedLeftTracedFloor;
var float m_fCachedRightFloorNormalZ;
var float m_fCachedLeftFloorNormalZ;
var int m_nCachedLeftFootBoneIndex;
var int m_nCachedRightFootBoneIndex;
var name m_SkelControl_LeftHandName;
var SkelControlLimb m_SkelControl_LeftHand;
var SkelControlSingleBone m_SkelControl_LeftHandRotate;
var name m_SkelControl_RightHandName;
var SkelControlLimb m_SkelControl_RightHand;
var SkelControlSingleBone m_SkelControl_RightHandRotate;
var SkelControlSingleBone m_SkelControl_RightToLeftPropSwitch;
var array<name> m_HandIKFullStrengthAnimNodeNameList;
var array<name> m_HandIKZeroStrengthAnimNodeNameList;
var array<AnimNode> m_HandIKFullStengthCachedNodeList;
var array<AnimNode> m_HandIKZeroStrengthCachedNodeList;
var MaterialInstanceConstant m_FadeMaterialControllerBody;
var name c_RefireBeginBlendAnimationName;
var name c_RefireEndBlendAnimationName;
var AnimSet c_RefireAnimSet;
var float c_fRefireDuration;
var float c_fRefireEndDuration;

// Export UTgPawn_Biped::execInitializeLeftHandIKAnimNodes(FFrame&, void* const)
native function bool InitializeLeftHandIKAnimNodes(SkeletalMeshComponent SkelComp);

// Export UTgPawn_Biped::execInitializeFootIKZeroStrengthAnimNodes(FFrame&, void* const)
native function bool InitializeFootIKZeroStrengthAnimNodes(SkeletalMeshComponent SkelComp);

// Export UTgPawn_Biped::execBeginRefire(FFrame&, void* const)
native function BeginRefire();

// Export UTgPawn_Biped::execEndRefire(FFrame&, void* const)
native function EndRefire();

// Export UTgPawn_Biped::execEndRefireTimer(FFrame&, void* const)
native function EndRefireTimer();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    //return;    
}

simulated function CacheMainMeshReferences(TgSkeletalMeshComponent smcomp)
{
    super.CacheMainMeshReferences(smcomp);
    // End:0x1E5
    if(smcomp != none)
    {
        m_LeftLegControl = SkelControlFootPlacement(smcomp.FindSkelControl(m_nmLeftFootControlName));
        m_RightLegControl = SkelControlFootPlacement(smcomp.FindSkelControl(m_nmRightFootControlName));
        m_SkelControl_LeftHand = SkelControlLimb(smcomp.FindSkelControl('IKLimb_LeftHand'));
        m_SkelControl_LeftHandRotate = SkelControlSingleBone(smcomp.FindSkelControl('IKSingleBone_LeftHand'));
        m_SkelControl_RightHand = SkelControlLimb(smcomp.FindSkelControl('IKLimb_RightHand'));
        m_SkelControl_RightHandRotate = SkelControlSingleBone(smcomp.FindSkelControl('IKSingleBone_RightHand'));
        m_SkelControl_RightToLeftPropSwitch = SkelControlSingleBone(smcomp.FindSkelControl('IKPropSwap'));
        InitializeLeftHandIKAnimNodes(smcomp);
        InitializeFootIKZeroStrengthAnimNodes(smcomp);
    }
    //return;    
}

exec function zpivot(float F)
{
    Mesh.SetTranslation(Mesh.Translation + (vect(0.0000000, 0.0000000, 1.0000000) * F));
    //return;    
}

simulated event EnableFootControls(int foot, bool bDisable)
{
    // End:0x55
    if(foot == 0)
    {
        // End:0x3A
        if(bDisable)
        {
            // End:0x37
            if(m_LeftLegControl != none)
            {
                m_bEnableLeftFootPlacement = false;
            }            
        }
        else
        {
            // End:0x55
            if(m_LeftLegControl != none)
            {
                m_bEnableLeftFootPlacement = true;
            }
        }
    }
    // End:0xAA
    if(foot == 1)
    {
        // End:0x8F
        if(bDisable)
        {
            // End:0x8C
            if(m_RightLegControl != none)
            {
                m_bEnableRightFootPlacement = false;
            }            
        }
        else
        {
            // End:0xAA
            if(m_RightLegControl != none)
            {
                m_bEnableRightFootPlacement = true;
            }
        }
    }
    //return;    
}

exec function SetAimTarget(float X, float Y, float Z)
{
    //return;    
}

simulated function bool CanTrackATarget()
{
    return true;
    //return ReturnValue;    
}

event Landed(Vector HitNormal, Actor FloorActor)
{
    super.Landed(HitNormal, FloorActor);
    //return;    
}

defaultproperties
{
    m_nmLeftFootBone="L_Foot"
    m_nmRightFootBone="R_Foot"
    m_nmLeftFootControlName="LeftFootControl"
    m_nmRightFootControlName="RightFootControl"
    m_bEnableRightFootPlacement=true
    m_bEnableLeftFootPlacement=true
    m_bMayDisableFootIKFromAnimNodes=true
    m_bApplyLeftHandWeaponIK=true
    m_bSetHandIKStrengthFromAnimNodes=true
    m_fMaxFootPlacementDistSquared=56250000.0000000
    m_FootIKZeroStrengthAnimNodeNameList[0]="EmoteAnim"
    m_FootIKZeroStrengthAnimNodeNameList[1]="BlendByFall"
    m_nCachedLeftFootBoneIndex=-1
    m_nCachedRightFootBoneIndex=-1
    m_SkelControl_LeftHandName="LeftHandControl"
    m_SkelControl_RightHandName="RightHandControl"
    m_HandIKFullStrengthAnimNodeNameList[0]="IdleRange"
    m_HandIKFullStrengthAnimNodeNameList[1]="MoveRange"
    m_HandIKFullStrengthAnimNodeNameList[2]="Device_Fire_Range"
    m_HandIKFullStrengthAnimNodeNameList[3]="Device_Fire_Range_Crouch"
    m_HandIKFullStrengthAnimNodeNameList[4]="Turn"
    m_HandIKFullStrengthAnimNodeNameList[5]="LowerBodyRunAnims"
    m_HandIKFullStrengthAnimNodeNameList[6]="UpperBodyRunAnims"
    m_HandIKFullStrengthAnimNodeNameList[7]="BlendByFall"
    m_HandIKFullStrengthAnimNodeNameList[8]="Landing"
    m_HandIKZeroStrengthAnimNodeNameList[0]="Device_Retrieve_Range"
    m_HandIKZeroStrengthAnimNodeNameList[1]="Device_Retrieve_Range_Crouch"
    m_HandIKZeroStrengthAnimNodeNameList[2]="Device_PutAway_Range"
    m_HandIKZeroStrengthAnimNodeNameList[3]="Device_PutAway_Range_Crouch"
    m_HandIKZeroStrengthAnimNodeNameList[4]="Device_ModeSwitch_Range"
    m_HandIKZeroStrengthAnimNodeNameList[5]="Device_ModeSwitch_Range_Crouch"
    m_HandIKZeroStrengthAnimNodeNameList[6]="EmoteAnim"
    c_RefireBeginBlendAnimationName="Intro"
    c_RefireEndBlendAnimationName="Exit"
    c_fRefireEndDuration=0.3000000
    m_bAffectedByVortices=true
    s_LoadMeshServerSide=false
    c_bShowTargetedRing=true
    c_nmInHandSocket="CSO_RHand_01"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Biped.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Biped.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Biped.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Biped.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Biped.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    GroundSpeed=289.0000000
    AccelRate=2048.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Biped.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Biped.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    CollisionComponent=CollisionCylinder
}