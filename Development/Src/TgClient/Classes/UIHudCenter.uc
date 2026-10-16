class UIHudCenter extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIAMMOCOUNT_ICE = 10;

const UIAMMOCOUNT_CELL = 1;

const UIAMMOCOUNT_DART = 25;

const UIAMMOCOUNT_SHELL = 8;

const UIAMMOCOUNT_ROCKET = 6;

const UIAMMOCOUNT_ARROW = 20;

const UIAMMOCOUNT_LARGE = 90;

const UIAMMOCOUNT_SMALL = 20;

const UIAMMOCOUNT_FLAME = 1;

const UIAMMOCOUNT_POTION = 10;

const UIAMMOCOUNT_BULLETS = 36;

const UIRETICLES_PROJECTILES = 10;

const UIHITMARKER_TICKS = 4;

const UIDAMAGEINSTIGATOR_MAX = 5;

const UIRETICLES_DAMAGE_LIGHT = 20;

const UIRETICLES_DAMAGE_MEDIUM = 15;

const UIRETICLES_DAMAGE_HEAVY = 10;

const UIHITMARKER_ERRORTOLERANCE = 48.0;

enum UIDamageSeverity {
    UIDAMAGE_LIGHT,  // 0
    UIDAMAGE_MEDIUM,  // 1
    UIDAMAGE_HEAVY,  // 2
};

enum UIAmmoType {
    UIAMMO_BULLET,  // 0
    UIAMMO_ICE,  // 1
    UIAMMO_CELL,  // 2
    UIAMMO_DART,  // 3
    UIAMMO_ARROW,  // 4
    UIAMMO_LARGE,  // 5
    UIAMMO_SMALL,  // 6
    UIAMMO_FLAME,  // 7
    UIAMMO_POTION,  // 8
    UIAMMO_SHELL,  // 9
    UIAMMO_ROCKET,  // 10
};

enum ECombatInfoType {
    ECIT_All,  // 0
    ECIT_Damage,  // 1
    ECIT_Status,  // 2
};

struct MessageClip {
    var int nIcon;
    var int nType;
    var int nValue;
    var float fTimer;
    var float fDuration;
    var GFxObject pMovie;
    var GFxObject pTimer;
    var GFxObject pTimerBar;
    structdefaultproperties {}
};

struct HudMarker {
    var float fValue;
    var float fTime;
    var float fAngle;
    var bool bActive;
    var Vector vHitLoc;
    var Vector vPawnLoc;
    var GFxObject pObj;
    var GFxObject pTop;
    var GFxObject pBot;
    structdefaultproperties {}
};

struct HudProjectile {
    var int nId;
    var bool bIsActive;
    var bool bInRange;
    var Vector vProjLoc;
    var float fScaleMult;
    var GFxObject pObj;
    var GFxObject pPointer;
    var GFxObject pIconTinted;
    var GFxObject pIcon;
    var GFxObject pArrow;
    structdefaultproperties {}
};

struct CastingInfo {
    var int nWidth;
    var bool bActive;
    var float fPercent;
    var GFxObject pObj;
    var GFxObject pText;
    var GFxObject pAnim;
    structdefaultproperties {}
};

struct HitMarkerInfo {
    var bool bPlayed;
    var float DamageAmount;
    var float fMaxDamageAmount;
    var array<string> HitActors;
    var bool bIsShieldHit;
    var ExtraDamageInfo ExtraInfo;
    var float fAccumulatedDamage;
    structdefaultproperties {}
};

struct DamageInstance {
    var float fDamage;
    var float fTimestamp;
    structdefaultproperties {}
};

var int m_nReticle;
var int m_nAccuracy;
var int m_nStuckCount;
var int m_nDmgAreaIndex;
var int m_nAmmoCurrent;
var int m_nAmmoClipSize;
var int m_nReticleColor;
var bool m_bChangeReticleOverEnemy;
var bool m_bChargeAmmo;
var bool m_bReticleBloom;
var bool m_bReticleVisible;
var bool m_bReticleAccessoryVisible;
var bool m_bDisableCombatLog;
var bool m_bRecharging;
var bool m_bOnEnemy;
var bool m_bOnFriendly;
var bool m_bWasMounted;
var bool m_bCanPurchase;
var bool m_bWasReloading;
var bool m_bShowFuel;
var float m_fRechargeTime;
var float m_fRechargeTimer;
var float m_fDmgFadeTime;
var float m_fReloadTime;
var float m_fReloadTimer;
var AkBaseSoundObject m_scHitMarker[5];
var GFxObject m_mcReticle;
var GFxObject m_mcShaLinReticleDraw;
var GFxObject m_mcShaLinImpalerReticle;
var GFxObject m_mcMaevePounceLIRecticle;
var GFxObject m_mcMaevePounceLORecticle;
var GFxObject m_mcMaevePounceRIRecticle;
var GFxObject m_mcMaevePounceRORecticle;
var GFxObject m_mcReticleType;
var GFxObject m_mcReticleAnim;
var GFxObject m_mcTargeter;
var GFxObject m_mcHitMarker;
var GFxObject m_mcHitMarkerTicks[4];
var GFxObject m_mcAccuracy;
var GFxObject m_mcRecharge;
var GFxObject m_mcRechargeCD;
var GFxObject m_mcClip;
var GFxObject m_mcBeacon;
var GFxObject m_mcBeaconTF;
var GFxObject m_mcBeaconButton;
var GFxObject m_mcBeaconBG;
var GFxObject m_mcStuck;
var GFxObject m_mcAmmoNew;
var GFxObject m_mcAmmoNewCharge;
var GFxObject m_mcAmmoNewCurrent;
var GFxObject m_mcAmmoNewClipSize;
var GFxObject m_mcAmmoNewChargeMask;
var GFxObject m_mcColorBack[4];
var GFxObject m_mcColorFront[4];
var GFxObject m_mcMakoaSmash;
var GFxObject m_mcMakoaSmashObj[3];
var Vector2D m_vMakoaSmashStart[3];
var Vector2D m_vMakoaSmashEnd[3];
var TgRepInfo_Player m_pTargetPRI;
var int m_eCombatInfoType;
var float m_fGlobalChatTimer;
var GFxObject m_Reward;
var GFxObject m_RewardName;
var GFxObject m_RewardAmount;
var GFxObject m_mcGlobalChat;
var GFxObject m_mcGlobalChatTF;
var GFxObject m_mcKillingBlow;
var GFxObject m_mcDamage;
var GFxObject m_Projectiles;
var HudProjectile m_ProjectilePointers[10];
var array<HudMarker> m_DamageMarkersLight;
var array<int> m_DamageMarkerFreelistLight;
var array<HudMarker> m_DamageMarkersMedium;
var array<int> m_DamageMarkerFreelistMedium;
var array<HudMarker> m_DamageMarkersHeavy;
var array<int> m_DamageMarkerFreelistHeavy;
var GFxObject m_mcFuel;
var GFxObject m_mcFuelBar;
var GFxObject m_mcFuelMask;
var GFxObject m_mcReload;
var GFxObject m_mcReloadTF;
var GFxObject m_mcReloadAnim;
var UIComponent_TorvaldShieldBar m_TorvaldShieldBar;
var UIComponent_DemonTeleportTimer m_DemonTeleportTimer;
var array<MessageClip> m_Messages;
var HitMarkerInfo m_HitMarker;
var float m_fMaxDamageTimestamp;
var float m_fDamageDealtRTPCSustainDuration;
var float m_fChampionHitTimestamp;
var float m_fChampionCountRTPCSustainDuration;
var array<DamageInstance> m_AccumulatedDamageInstances;
var float m_fDamageAccumulationWindow;
var TgGameplayCurves m_GameplayCurves;

simulated event TriggerPounceReticleAnim(bool bPounceReady) { }

defaultproperties
{
    m_bReticleVisible=true
    m_bReticleAccessoryVisible=true
    m_fDmgFadeTime=2.0000000
    m_scHitMarker[0]=AkEvent'UI_HitMarker_Small_1P_Play'
    m_scHitMarker[1]=AkEvent'UI_HitMarker_DoT_1P_Play'
    m_scHitMarker[2]=AkEvent'UI_HitMarker_Shield_1P_Play'
    m_scHitMarker[3]=AkEvent'UI_HitMarker_HeadShot_Play'
    m_scHitMarker[4]=AkEvent'UI_HitMarker_Crit_Play'
    m_vMakoaSmashStart[0]=(X=0.0000000,Y=-22.2000000)
    m_vMakoaSmashStart[1]=(X=19.4500000,Y=11.3500000)
    m_vMakoaSmashStart[2]=(X=-19.3500000,Y=11.4500000)
    m_vMakoaSmashEnd[0]=(X=0.0000000,Y=-61.0000000)
    m_vMakoaSmashEnd[1]=(X=53.0500000,Y=30.7500000)
    m_vMakoaSmashEnd[2]=(X=-52.9500000,Y=30.8500000)
    m_fDamageDealtRTPCSustainDuration=0.7500000
    m_fChampionCountRTPCSustainDuration=0.7500000
    m_fDamageAccumulationWindow=0.5000000
    m_GameplayCurves=TgGameplayCurves'HudCenterCurves'
    m_UISceneClass=Class'UIScene_UIHudCenter'
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudCenter"
}
