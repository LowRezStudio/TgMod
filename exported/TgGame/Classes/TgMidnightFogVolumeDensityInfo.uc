class TgMidnightFogVolumeDensityInfo extends FogVolumeSphericalDensityInfo
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo);

var bool m_bFogOn;
var bool m_bFogUpdateNeeded;
var bool m_bIsFadingOut;
var float m_fCurrentStartDistance;
var float m_fFadeOutDuration;
var float m_fFadeOutTimer;
var float m_fTargetMaxDensity;
var float m_fDestroyTimer;
var export editinline FogVolumeSphericalDensityComponent SphericalDensityComponent;

simulated event PostBeginPlay()
{
    super(FogVolumeDensityInfo).PostBeginPlay();
    // End:0xA8
    if(SphericalDensityComponent != none)
    {
        SphericalDensityComponent.SetViewOriginOverride(Location, SphericalDensityComponent.bUseViewOriginOverride);
        // End:0xA8
        if(!SphericalDensityComponent.bEnabled)
        {
            SphericalDensityComponent.MaxDensity = 0.0000000;
        }
    }
    m_bFogOn = bEnabled;
    //return;    
}

simulated function ToggleFog(bool bOn)
{
    // End:0x7B
    if(m_bFogOn != bOn)
    {
        // End:0x51
        if(SphericalDensityComponent != none)
        {
            SphericalDensityComponent.SetEnabled(bOn);
        }
        bEnabled = bOn;
        m_bFogOn = bOn;
    }
    //return;    
}

simulated function SetOrigin(Vector vOrigin)
{
    // End:0x6E
    if(SphericalDensityComponent != none)
    {
        SetLocation(vOrigin);
        SphericalDensityComponent.SetViewOriginOverride(vOrigin, SphericalDensityComponent.bUseViewOriginOverride);
        m_bFogUpdateNeeded = true;
    }
    //return;    
}

simulated function SetStartDistance(float fNewStartDistance)
{
    fNewStartDistance *= 0.9000000;
    // End:0x7F
    if((SphericalDensityComponent != none) && m_fCurrentStartDistance != fNewStartDistance)
    {
        m_fCurrentStartDistance = fNewStartDistance;
        SphericalDensityComponent.StartDistance = m_fCurrentStartDistance;
        m_bFogUpdateNeeded = true;
    }
    //return;    
}

simulated function FadeOut(float fFadeTime)
{
    m_bIsFadingOut = true;
    m_fFadeOutDuration = fFadeTime;
    m_fFadeOutTimer = fFadeTime;
    m_fDestroyTimer = fFadeTime * 1.2500000;
    //return;    
}

simulated function Tick(float DeltaTime)
{
    local float fFadeOutPerc, fFadeOutAlpha;

    // End:0xB0
    if(m_bIsFadingOut)
    {
        m_fFadeOutTimer -= DeltaTime;
        // End:0x4F
        if(m_fFadeOutTimer <= 0.0000000)
        {
            m_fFadeOutTimer = 0.0000000;
            m_bIsFadingOut = false;
        }
        fFadeOutPerc = m_fFadeOutTimer / m_fFadeOutDuration;
        fFadeOutAlpha = fFadeOutPerc;
        SetAlpha(fFadeOutAlpha);
        // End:0xB0
        if(!m_bIsFadingOut)
        {
            ToggleFog(false);
            Destroy();
        }
    }
    // End:0x12F
    if((SphericalDensityComponent != none) && SphericalDensityComponent.bEnabled)
    {
        SetOrigin(Location);
        // End:0x12F
        if(m_bFogUpdateNeeded)
        {
            m_bFogUpdateNeeded = false;
            SphericalDensityComponent.ForceUpdate(false);
        }
    }
    // End:0x16C
    if(m_fDestroyTimer > 0.0000000)
    {
        m_fDestroyTimer -= DeltaTime;
        // End:0x16C
        if(m_fDestroyTimer <= 0.0000000)
        {
            Destroy();
        }
    }
    //return;    
}

simulated function SetAlpha(float fNewAlpha)
{
    // End:0x5E
    if(SphericalDensityComponent != none)
    {
        m_bFogUpdateNeeded = true;
        SphericalDensityComponent.MaxDensity = Lerp(0.0000000, m_fTargetMaxDensity, fNewAlpha * fNewAlpha);
    }
    //return;    
}

defaultproperties
{
    m_bFogUpdateNeeded=true
    m_fCurrentStartDistance=13000.0000000
    m_fTargetMaxDensity=0.0450000
    m_fDestroyTimer=15.0000000
    // Reference: FogVolumeSphericalDensityComponent'TgGame.Default__TgMidnightFogVolumeDensityInfo.FogVolumeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FogVolumeComponent0'
    // Archetype: FogVolumeSphericalDensityComponent'Engine.Default__FogVolumeSphericalDensityInfo.FogVolumeComponent0'
    begin object name="FogVolumeComponent0"
        MaxDensity=0.0450000
        FogMaterial=MaterialInstanceConstant'FX_Gen_Materials.Materials.MIC_FogVolumeMaterial'
        bAffectsTranslucency=false
        bUseViewOriginOverride=true
        SimpleLightColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        ApproxFogLightColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        StartDistance=13000.0000000
    end object
    SphericalDensityComponent=FogVolumeComponent0
    DensityComponent=FogVolumeComponent0
    // Reference: StaticMeshComponent'TgGame.Default__TgMidnightFogVolumeDensityInfo.AutomaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AutomaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__FogVolumeSphericalDensityInfo.AutomaticMeshComponent0'
    begin object name="AutomaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    AutomaticMeshComponent=AutomaticMeshComponent0
    Components[0]=none
    Components[1]=AutomaticMeshComponent0
    Components[2]=none
    Components[3]=FogVolumeComponent0
    DrawScale=156.0000000
    bNoDelete=false
}