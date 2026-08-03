class TgPawn_Blades extends TgPawn_Character
    native(ChampBlades)
    config(Game)
    hidecategories(Navigation);

const DJ_BLADES_HEAD_SKIN_ID = 19277;
const DJ_BLADES_HEAD_SKIN_LOBBY_ID = 8021;
const MAX_DJ_BLADES_FACES = 8;
const MAX_DJ_BLADES_FACE_PRIORITIES = 3;

enum GemEmissiveAnim
{
    eGEA_None,                      // 0
    eGEA_Idle,                      // 1
    eGEA_Pounce,                    // 2
    eGEA_Prowl,                     // 3
    eGEA_AirJump,                   // 4
    eGEA_NineLives,                 // 5
    eGEA_Midnight,                  // 6
    eGEA_MAX                        // 7
};

enum DjBladesFace
{
    eDBF_Base,                      // 0
    eDBF_VGS_Positive,              // 1
    eDBF_VGS_Negative,              // 2
    eDBF_VGS_Silly,                 // 3
    eDBF_Ability_1,                 // 4
    eDBF_Ability_2,                 // 5
    eDBF_CrowdControl,              // 6
    eDBF_Death,                     // 7
    eDBF_MAX                        // 8
};

enum DjBladesFacePriority
{
    eDBFP_Ability,                  // 0
    eDBFP_VGS,                      // 1
    eDBFP_Status,                   // 2
    eDBFP_MAX                       // 3
};

struct native DjBladesFaceConfig
{
    var float fShiftX;
    var float fShiftY;

    structdefaultproperties
    {
        fShiftX=0.0000000
        fShiftY=0.0000000
    }
};

var float m_fGravityFalloffDuration;
var float m_fGravityFalloffTimer;
var float m_fAirControlReductionDuration;
var float m_fAirControlReductionTimer;
var float m_fAirControlReductionPercent;
var repnotify bool r_bProwlActive;
var float r_fProwlAccelMultiplier;
var float r_fProwlGroundSpeedMultiplier;
var float r_fProwlJumpHeightMultiplier;
var float r_fProwlAirControlMultiplier;
var repnotify float r_fProwlFadeOutDuration;
var float m_fProwlFadeOutTimer;
var float r_fFeatherliteGravityMultiplier;
var repnotify TgPawn_Blades.GemEmissiveAnim r_eGemEmissiveAnim;
var repnotify TgPawn_Blades.GemEmissiveAnim r_eGemEmissiveEndAnim;
var TgPawn_Blades.DjBladesFace c_eCurrentDjBladesFace;
var TgPawn_Blades.DjBladesFace c_eDjBladesFace[3];
var MaterialInstanceConstant c_pGemEmissiveMIC;
var string m_sGemEmissiveParamName;
var float m_fGemEmissiveBaseValue;
var float m_fGemEmissiveBaseAnimSpeed;
var float c_fGemEmissiveCurrentValue;
var array<TgPawn_Blades.GemEmissiveAnim> c_eGemEmissiveAnimType;
var array<float> c_fGemEmissiveTargetValue;
var array<float> c_fGemEmissiveAnimSpeed;
var array<float> c_fGemEmissiveHoldTimer;
var float m_fGemEmissive1PBaseValue;
var float m_fGemEmissive1PAnimSpeedMult;
var float m_fGemEmissive1PValueMult;
var float m_fGemEmissiveGlobalScalar;
var float c_fDjBladesFaceTimeout[3];
var DjBladesFaceConfig c_DjBladesFaceConfig[8];
var string c_sDjBladesFaceXParamName;
var string c_sDjBladesFaceYParamName;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bProwlActive, r_fFeatherliteGravityMultiplier, 
        r_fProwlAccelMultiplier, r_fProwlAirControlMultiplier, 
        r_fProwlFadeOutDuration, r_fProwlGroundSpeedMultiplier, 
        r_fProwlJumpHeightMultiplier;

    // Pos:0x020
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && (!bNetOwner || bDemoRecording) || bNetTimelapse)
        r_eGemEmissiveAnim, r_eGemEmissiveEndAnim;
}

// Export UTgPawn_Blades::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn_Blades::execGravityFallOff(FFrame&, void* const)
native function GravityFallOff(float fDuration);

// Export UTgPawn_Blades::execAirControlReduction(FFrame&, void* const)
native function AirControlReduction(float fDuration, float fPercentReduction);

// Export UTgPawn_Blades::execQueueBounceCustom(FFrame&, void* const)
native function QueueBounceCustom(const out Vector vBounceVelocity, float fDuration, float fPctAirControlReduction);

// Export UTgPawn_Blades::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_Blades::execGetProwlAccelMultiplier(FFrame&, void* const)
native function float GetProwlAccelMultiplier();

// Export UTgPawn_Blades::execGetProwlGroundSpeedMultiplier(FFrame&, void* const)
native function float GetProwlGroundSpeedMultiplier();

// Export UTgPawn_Blades::execGetProwlJumpHeightMultiplier(FFrame&, void* const)
native function float GetProwlJumpHeightMultiplier();

// Export UTgPawn_Blades::execGetProwlAirControlMultiplier(FFrame&, void* const)
native function float GetProwlAirControlMultiplier();

// Export UTgPawn_Blades::execResetGemEmissiveParam(FFrame&, void* const)
native simulated function ResetGemEmissiveParam();

// Export UTgPawn_Blades::execClearGemEmissiveParam(FFrame&, void* const)
native simulated function ClearGemEmissiveParam(TgPawn_Blades.GemEmissiveAnim eAnim);

// Export UTgPawn_Blades::execAnimateGemEmissiveParam(FFrame&, void* const)
native simulated function AnimateGemEmissiveParam(TgPawn_Blades.GemEmissiveAnim eAnim, float fTargetValue, float fAnimSpeed, float fHoldTime);

// Export UTgPawn_Blades::execPawnOnKilled(FFrame&, void* const)
native function PawnOnKilled(Actor pVictim);

// Export UTgPawn_Blades::execPawnOnAssisted(FFrame&, void* const)
native function PawnOnAssisted(Actor pVictim);

simulated function SetGemEmissiveAnim(TgPawn_Blades.GemEmissiveAnim eAnim)
{
    // End:0x46
    if(int(Role) == int(ROLE_Authority))
    {
        r_eGemEmissiveAnim = eAnim;
        bNetDirty = true;
        SetTimer(0.3300000, false, 'ClearGemEmissiveAnim');
    }
    ApplyGemEmissveAnim(eAnim);
    //return;    
}

function ClearGemEmissiveAnim()
{
    r_eGemEmissiveAnim = 0;
    bNetDirty = true;
    //return;    
}

simulated function SetGemEmissiveEndAnim(TgPawn_Blades.GemEmissiveAnim eEndAnim)
{
    // End:0x46
    if(int(Role) == int(ROLE_Authority))
    {
        r_eGemEmissiveEndAnim = eEndAnim;
        bNetDirty = true;
        SetTimer(0.3300000, false, 'ClearGemEmissiveEndAnim');
    }
    ClearGemEmissiveParam(eEndAnim);
    //return;    
}

function ClearGemEmissiveEndAnim()
{
    r_eGemEmissiveEndAnim = 0;
    bNetDirty = true;
    //return;    
}

simulated function ApplyGemEmissveAnim(TgPawn_Blades.GemEmissiveAnim eAnim)
{
    switch(eAnim)
    {
        // End:0x25
        case 1:
            ResetGemEmissiveParam();
            // End:0xFA
            break;
        // End:0x4F
        case 2:
            AnimateGemEmissiveParam(eAnim, 28.0000000, 112.0000000, 1.0000000);
            // End:0xFA
            break;
        // End:0x79
        case 3:
            AnimateGemEmissiveParam(eAnim, 14.0000000, 28.0000000, 20.0000000);
            // End:0xFA
            break;
        // End:0xA3
        case 4:
            AnimateGemEmissiveParam(eAnim, 20.0000000, 112.0000000, 0.2500000);
            // End:0xFA
            break;
        // End:0xCD
        case 5:
            AnimateGemEmissiveParam(eAnim, 24.0000000, 112.0000000, 0.2500000);
            // End:0xFA
            break;
        // End:0xF7
        case 6:
            AnimateGemEmissiveParam(eAnim, 16.0000000, 28.0000000, 8.0000000);
            // End:0xFA
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event float Get1PGemEmissiveMultiplier(TgPawn_Blades.GemEmissiveAnim eAnim)
{
    // End:0x25
    if(int(eAnim) == int(3))
    {
        return m_fGemEmissive1PValueMult * 0.5000000;
    }
    // End:0x3F
    if(int(eAnim) == int(4))
    {
        return 0.0000000;
    }
    return m_fGemEmissive1PValueMult;
    //return ReturnValue;    
}

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x35
        case 'r_eGemEmissiveAnim':
            ApplyGemEmissveAnim(r_eGemEmissiveAnim);
            // End:0xB5
            break;
        // End:0x57
        case 'r_eGemEmissiveEndAnim':
            ClearGemEmissiveParam(r_eGemEmissiveEndAnim);
            // End:0xB5
            break;
        // End:0x63
        case 'r_bProwlActive':
        // End:0xB2
        case 'r_fProwlFadeOutDuration':
            // End:0xAF
            if((int(Role) == int(ROLE_SimulatedProxy)) && r_fProwlFadeOutDuration > m_fProwlFadeOutTimer)
            {
                m_fProwlFadeOutTimer = r_fProwlFadeOutDuration;
            }
            // End:0xB5
            break;
        // End:0xFFFF
        default:
            break;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    switch(MountType)
    {
        // End:0x53
        case 1:
            return "PC_Blades_Skin00A.Anims.AS_PC_Blades_Skin00A_Mount_Horse";
        // End:0xFFFF
        default:
            return "";
            break;
    }
    //return ReturnValue;    
}

function bool CannotJumpNow()
{
    local TgDevice_Pounce pounce;

    pounce = TgDevice_Pounce(self.GetDeviceByEqPoint(16));
    // End:0x61
    if((pounce != none) && pounce.IsPostHitLockOutActive())
    {
        return true;
    }
    return super.CannotJumpNow();
    //return ReturnValue;    
}

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local bool bJumped;

    bJumped = super.DoJump(bUpdating, JumpZSpeed);
    // End:0x59
    if(bJumped && m_bAttemptingAirJump)
    {
        SetGemEmissiveAnim(4);
    }
    return bJumped;
    //return ReturnValue;    
}

simulated function float GetJumpHeightMultiplier()
{
    local float fHeightIncrease;

    fHeightIncrease = super(TgPawn).GetJumpHeightMultiplier();
    fHeightIncrease *= (GetProwlJumpHeightMultiplier());
    return fHeightIncrease;
    //return ReturnValue;    
}

simulated event int GetNumAirJumps()
{
    return 1;
    //return ReturnValue;    
}

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote)
{
    switch(Emote)
    {
        // End:0x1D
        case 13:
            return false;
            // End:0x2D
            break;
        // End:0x27
        case 31:
            return false;
            // End:0x2D
            break;
        // End:0xFFFF
        default:
            // End:0x2D
            break;
            break;
    }
    return super(TgPawn).RespectsEmoteGlobalCooldown(Emote);
    //return ReturnValue;    
}

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote)
{
    local float fChance;

    fChance = super(TgPawn).GetAbilityEmoteChance(Emote);
    // End:0x41
    if(int(Emote) == int(13))
    {
        fChance *= 1.2500000;
    }
    return fChance;
    //return ReturnValue;    
}

simulated event float GetEmoteChance(TgPawn.EEmote Emote)
{
    local float fChance;

    fChance = super(TgPawn).GetEmoteChance(Emote);
    // End:0x41
    if(int(Emote) == int(31))
    {
        fChance *= 2.5000000;
    }
    return fChance;
    //return ReturnValue;    
}

simulated event OnVGSSoundPlayed(int nVgsId)
{
    // End:0x1E
    if(int(c_eCurrentAudioEmotePlaying) != int(0))
    {
        OnEmoteSoundFinished();
    }
    // End:0x37
    if(c_nCurrentVGSPlaying != 0)
    {
        OnVGSSoundFinished();
    }
    super(TgPawn).OnVGSSoundPlayed(nVgsId);
    // End:0x143
    if(c_nCurrentVGSPlaying != 0)
    {
        // End:0xBD
        if((((c_nCurrentVGSPlaying == 310) || c_nCurrentVGSPlaying == 299) || c_nCurrentVGSPlaying == 296) || c_nCurrentVGSPlaying == 307)
        {
            SetDjBladesFace(1, 1);            
        }
        else
        {
            // End:0x10C
            if(((c_nCurrentVGSPlaying == 312) || c_nCurrentVGSPlaying == 302) || c_nCurrentVGSPlaying == 313)
            {
                SetDjBladesFace(2, 1);                
            }
            else
            {
                // End:0x143
                if((c_nCurrentVGSPlaying == 308) || c_nCurrentVGSPlaying == 300)
                {
                    SetDjBladesFace(3, 1);
                }
            }
        }
    }
    //return;    
}

simulated event OnVGSSoundFinished()
{
    // End:0x1E
    if(c_nCurrentVGSPlaying != 0)
    {
        SetDjBladesFace(0, 1);
    }
    super(TgPawn).OnVGSSoundFinished();
    //return;    
}

simulated event OnEmoteSoundPlayed(TgPawn.EEmote Emote)
{
    // End:0x1E
    if(int(c_eCurrentAudioEmotePlaying) != int(0))
    {
        OnEmoteSoundFinished();
    }
    // End:0x37
    if(c_nCurrentVGSPlaying != 0)
    {
        OnVGSSoundFinished();
    }
    super(TgPawn).OnEmoteSoundPlayed(Emote);
    // End:0x99
    if(((int(c_eCurrentAudioEmotePlaying) == int(1)) || int(c_eCurrentAudioEmotePlaying) == int(2)) || int(c_eCurrentAudioEmotePlaying) == int(3))
    {
        SetDjBladesFace(3, 1);
    }
    //return;    
}

simulated event OnEmoteSoundFinished()
{
    // End:0x23
    if(int(c_eCurrentAudioEmotePlaying) != int(0))
    {
        SetDjBladesFace(0, 1);
    }
    super(TgPawn).OnEmoteSoundFinished();
    //return;    
}

simulated event SetDjBladesFace(TgPawn_Blades.DjBladesFace eFace, TgPawn_Blades.DjBladesFacePriority ePriority, optional float fTimeout = 0.0000000)
{
    local int nIndex;

    // End:0x1E
    if(r_nHeadSkinId != 19277)
    {
        return;
    }
    nIndex = Clamp(int(ePriority), 0, 3 - 1);
    // End:0xA4
    if(int(c_eDjBladesFace[nIndex]) != int(eFace))
    {
        c_eDjBladesFace[nIndex] = eFace;
        c_fDjBladesFaceTimeout[nIndex] = fTimeout;
        UpdateDjBladesFace();
    }
    //return;    
}

simulated function UpdateDjBladesFace()
{
    local int I;
    local TgPawn_Blades.DjBladesFace eFace;

    // End:0x15
    if(r_nHeadSkinId != 19277)
    {
        return;
    }
    eFace = 0;
    I = 3 - 1;
    J0x30:

    // End:0x88 [Loop If]
    if(I >= 0)
    {
        // End:0x7A
        if(int(c_eDjBladesFace[I]) != int(0))
        {
            eFace = c_eDjBladesFace[I];
        }
        I--;
        // [Loop Continue]
        goto J0x30;
    }
    // End:0xB6
    if(int(c_eCurrentDjBladesFace) != int(eFace))
    {
        ApplyDjBladesFace(eFace);
    }
    //return;    
}

// Export UTgPawn_Blades::execApplyDjBladesFace(FFrame&, void* const)
native simulated function ApplyDjBladesFace(TgPawn_Blades.DjBladesFace eFace);

defaultproperties
{
    r_fProwlAccelMultiplier=1.0000000
    r_fFeatherliteGravityMultiplier=1.0000000
    c_eCurrentDjBladesFace=DjBladesFace.eDBF_Death
    c_eDjBladesFace[2]=DjBladesFace.eDBF_Death
    m_sGemEmissiveParamName="FX_GlowRamp"
    m_fGemEmissiveBaseValue=4.0000000
    m_fGemEmissiveBaseAnimSpeed=20.0000000
    m_fGemEmissive1PBaseValue=-1.0000000
    m_fGemEmissive1PAnimSpeedMult=1.3500000
    m_fGemEmissive1PValueMult=0.1153000
    m_fGemEmissiveGlobalScalar=1.3000000
    c_DjBladesFaceConfig[1]=(fShiftX=0.0000000,fShiftY=0.5000000)
    c_DjBladesFaceConfig[2]=(fShiftX=0.0000000,fShiftY=0.7500000)
    c_DjBladesFaceConfig[3]=(fShiftX=0.5000000,fShiftY=0.0000000)
    c_DjBladesFaceConfig[4]=(fShiftX=0.5000000,fShiftY=0.2500000)
    c_DjBladesFaceConfig[5]=(fShiftX=0.5000000,fShiftY=0.5000000)
    c_DjBladesFaceConfig[6]=(fShiftX=0.5000000,fShiftY=0.7500000)
    c_DjBladesFaceConfig[7]=(fShiftX=0.0000000,fShiftY=0.2500000)
    c_sDjBladesFaceXParamName="Shift X"
    c_sDjBladesFaceYParamName="Shift Y"
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Blades.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Blades.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_bCanChargeInAir=true
    m_bAirAccuracyPenalty=false
    m_sGameplayPackage="Maeve"
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Blades.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    c_fFxScaleSize=0.9500000
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Blades.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Blades.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Blades.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Blades.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    JumpZ=460.0000000
    BaseEyeHeight=27.0000000
    EyeHeight=27.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Blades.CollisionCylinder'
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
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Blades.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}