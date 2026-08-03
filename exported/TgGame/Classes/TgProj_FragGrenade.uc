class TgProj_FragGrenade extends TgProj_FreeGrenade
    native(ChampViktor)
    hidecategories(Navigation);

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    SetCookedInfo();
    //return;    
}

simulated function SetCookedInfo()
{
    local TgPawn_Viktor Viktor;

    Viktor = TgPawn_Viktor(Instigator);
    // End:0x69
    if((Viktor == none) || Viktor.r_fFragGrenadeExplodeTime == float(0))
    {
        SetTimer(3.0000000, false, 'TimerExplode');        
    }
    else
    {
        m_bExplodeOnTouch = Viktor.r_bFragGrenadeExplodeOnTouch;
        m_bExplodeOnGeometry = Viktor.r_bFragGrenadeExplodeOnTouch;
        SetTimer(Viktor.r_fFragGrenadeExplodeTime, false, 'TimerExplode');
    }
    // End:0x198
    if(Viktor != none)
    {
        m_fBounceDampingVertMin = Viktor.m_fBounceDampingVertMin;
        m_fBounceDampingVertMax = Viktor.m_fBounceDampingVertMax;
        m_fBounceDampingHorizMin = Viktor.m_fBounceDampingHorizMin;
        m_fBounceDampingHorizMax = Viktor.m_fBounceDampingHorizMax;
    }
    //return;    
}

simulated function ApplyBounce(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    m_bUseBilinearInterpolationForBounceDamping = !(Wall != none) && Wall.IsA('TgPawn_Character');
    super.ApplyBounce(HitNormal, Wall, WallComp);
    // End:0xAE
    if(((int(WorldInfo.NetMode) == int(NM_Client)) || m_OwnerFireMode == none) || m_bUseBilinearInterpolationForBounceDamping)
    {
        return;
    }
    // End:0x121
    if((Wall != none) && m_OwnerFireMode.IsValidTarget(Wall,,, m_bInvertTeam))
    {
        m_OwnerFireMode.ApplyHitSpecial(Wall);
    }
    //return;    
}

simulated function PlayBounceSound()
{
    // End:0x92
    if(!m_bUseBilinearInterpolationForBounceDamping)
    {
        // End:0x8F
        if((c_Mesh != none) && Speed > m_fSpeedToActivateBounceFX)
        {
            c_Mesh.FxDeactivateGroup('ProjectileBounceHitCharacter', 0);
            c_Mesh.FxActivateGroup('ProjectileBounceHitCharacter', 0);
        }        
    }
    else
    {
        super.PlayBounceSound();
    }
    //return;    
}

defaultproperties
{
    m_bExplodeOnTouch=false
    m_bUseBilinearInterpolationForBounceDamping=true
    m_fBounceDampingVertMin=0.1000000
    m_fBounceDampingVertMax=1.0000000
    m_fBounceDampingHorizMin=0.0900000
    m_fBounceDampingHorizMax=0.7500000
    m_fBounceDamping=0.1000000
    m_nShadowFXID=7068
    m_fMaxDecalHeight=2000.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FragGrenade.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_FragGrenade.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}