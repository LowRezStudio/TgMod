class TgDeploy_HealthNugget extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation);

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

// Export UTgDeploy_HealthNugget::execDeployAllyHealAOE(FFrame&, void* const)
native function DeployAllyHealAOE(TgPawn_Character TgP);

// Export UTgDeploy_HealthNugget::execAdjustHeal(FFrame&, void* const)
native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);

simulated event PostBeginPlay()
{
    local TgPlayerController TgPC;

    super.PostBeginPlay();
    // End:0x85
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x85
        if((TgPC != none) && TgPC.c_GameTipManager != none)
        {
        }
    }
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local ImpactInfo HealImpact;
    local TgPawn_Character TgP;
    local TgDevice Dev;
    local int I;
    local TgGame_Paladins ChaosGame;
    local int bonusScore;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    bonusScore = 0;
    TgP = TgPawn_Character(Other);
    // End:0x457
    if(((int(Role) == int(ROLE_Authority)) && m_FireMode != none) && TgP != none)
    {
        // End:0xB3
        if(TgP.IsA('TgPawn_Illusion'))
        {
            return;            
        }
        else
        {
            // End:0x421
            if(m_bIsDeployed && int(TgP.Physics) != int(17))
            {
                HealImpact.bDirectHit = true;
                HealImpact.DeviceModeReference = m_FireMode;
                HealImpact.HitActor = Other;
                HealImpact.HitLocation = Other.Location;
                SetFlashLocation(Other.Location);
                m_FireMode.ApplyHit(HealImpact, self);
                I = 1;
                J0x1ED:

                // End:0x338 [Loop If]
                if(I < 33)
                {
                    Dev = TgP.GetDeviceByEqPoint(I);
                    // End:0x32A
                    if(Dev != none)
                    {
                        // End:0x292
                        if(Dev.r_nDeviceId == 10339)
                        {
                            m_FireMode.ApplyHit(HealImpact, self);                            
                        }
                        else
                        {
                            // End:0x2D0
                            if(Dev.r_nDeviceId == 10364)
                            {
                                DeployAllyHealAOE(TgP);                                
                            }
                            else
                            {
                                // End:0x32A
                                if(Dev.r_nDeviceId == 10698)
                                {
                                    DeployAllyHealAOE(TgP);
                                    TgP.ExitCombat();
                                }
                            }
                        }
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x1ED;
                }
                TgP.PawnOnGetHealthNugget(self);
                ChaosGame = TgGame_Paladins(WorldInfo.Game);
                // End:0x413
                if(ChaosGame != none)
                {
                    ChaosGame.OnKillConfirmed(TgP.GetPRI(), TgP.GetPRI().r_TaskForce, bonusScore);
                }
                DestroyIt();                
            }
            else
            {
                // End:0x457
                if(m_PendingTouches.Find(Other) == -1)
                {
                    m_PendingTouches.AddItem(Other);
                }
            }
        }
    }
    //return;    
}

simulated event UnTouch(Actor Other)
{
    // End:0x47
    if((Other != none) && m_PendingTouches.Find(Other) != -1)
    {
        m_PendingTouches.RemoveItem(Other);
    }
    super(Actor).UnTouch(Other);
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    J0x01:
    // End:0x21 [Loop If]
    if(m_PendingTouches.Length > 0)
    {
        m_PendingTouches.Remove(0, 1);
        // [Loop Continue]
        goto J0x01;
    }
    super.DestroyIt(bSkipFx);
    //return;    
}

simulated function Destroyed()
{
    // End:0x3A
    if(c_HelpTipActor != none)
    {
        c_HelpTipActor.Remove(true);
        c_HelpTipActor = none;
    }
    super.Destroyed();
    //return;    
}

defaultproperties
{
    m_bRenderAsActive=true
    m_fHealOverride=-1.0000000
    m_fHoTOverride=-1.0000000
    m_bFireOnDeploy=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_HealthNugget.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_HealthNugget.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    Physics=EPhysics.PHYS_Falling
    bCollideActors=true
    bCollideWorld=true
    CollisionComponent=CollisionCylinder
}