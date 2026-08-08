class TgDeploy_HealthNugget extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const HEALTH_NUGGET_DOUBLE_ID = 10339;

const HEALTH_NUGGET_HEAL_ALLIES_ID = 10364;

const HEAL_ALLIES_DEPLOYABLE_ID = 685;

const EXIT_STRATEGY_ID = 10698;

var bool m_bRenderAsActive;
var bool m_bIsActiveRendered;
var bool m_bCountTowardsHealingStats;
var TgHelpTipActor c_HelpTipActor;
var float m_fHealOverride;
var float m_fHoTOverride;
var array<Actor> m_PendingTouches;

native function DeployAllyHealAOE(TgPawn_Character TgP);  // Export UTgDeploy_HealthNugget::execDeployAllyHealAOE(FFrame&, void* const)

native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);  // Export UTgDeploy_HealthNugget::execAdjustHeal(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated function Destroyed() { }

defaultproperties
{}
