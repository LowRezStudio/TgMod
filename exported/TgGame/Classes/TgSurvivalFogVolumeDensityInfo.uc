class TgSurvivalFogVolumeDensityInfo extends FogVolumeSphericalDensityInfo
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo);

var bool m_bFogOn;
var float m_fTargetStartDistance;
var float m_fPreviousStartDistance;
var float m_fFogUpdateTimestamp;
var float m_fFogUpdateInterval;
var float m_fConvergenceRate;
var float m_fFadeInRate;
var float m_fFadeOutRate;
var export editinline FogVolumeSphericalDensityComponent SphericalDensityComponent;

event PostBeginPlay()
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

function ToggleFog(bool bOn)
{
    local bool bShouldDisable;

    // End:0x13E
    if(m_bFogOn != bOn)
    {
        // End:0x76
        if(bOn)
        {
            // End:0x5E
            if(SphericalDensityComponent != none)
            {
                SphericalDensityComponent.SetEnabled(bOn);
            }
            bEnabled = bOn;            
        }
        else
        {
            bShouldDisable = true;
            // End:0x112
            if(SphericalDensityComponent != none)
            {
                bShouldDisable = !SphericalDensityComponent.bEnabled || SphericalDensityComponent.MaxDensity <= 0.0000000;
                SphericalDensityComponent.SetEnabled(!bShouldDisable);
            }
            bEnabled = !bShouldDisable;
        }
        m_bFogOn = bOn;
    }
    //return;    
}

function ConvergeFog(float fNewStartDistance, float interval, optional bool bForce)
{
    m_fFogUpdateTimestamp = WorldInfo.TimeSeconds;
    m_fFogUpdateInterval = interval;
    m_fPreviousStartDistance = m_fTargetStartDistance;
    m_fTargetStartDistance = fNewStartDistance;
    // End:0x129
    if(((bForce || !bEnabled) && SphericalDensityComponent != none) && SphericalDensityComponent.StartDistance != m_fTargetStartDistance)
    {
        SphericalDensityComponent.StartDistance = fNewStartDistance;
        // End:0x129
        if(SphericalDensityComponent.bEnabled)
        {
            SphericalDensityComponent.ForceUpdate(false);
        }
    }
    //return;    
}

simulated function Tick(float DeltaTime)
{
    local bool bForceUpdate;
    local float fTargetDensity;

    super(Actor).Tick(DeltaTime);
    // End:0x295
    if(bEnabled && SphericalDensityComponent != none)
    {
        // End:0xEF
        if((SphericalDensityComponent.StartDistance != m_fTargetStartDistance) && m_fFogUpdateInterval != float(0))
        {
            SphericalDensityComponent.StartDistance = Lerp(m_fPreviousStartDistance, m_fTargetStartDistance, FClamp((WorldInfo.TimeSeconds - m_fFogUpdateTimestamp) / m_fFogUpdateInterval, 0.0000000, 1.0000000));
            bForceUpdate = true;
        }
        fTargetDensity = ((m_bFogOn) ? default.SphericalDensityComponent.MaxDensity : 0.0000000);
        // End:0x1FD
        if(SphericalDensityComponent.MaxDensity != fTargetDensity)
        {
            SphericalDensityComponent.MaxDensity = FInterpConstantTo(SphericalDensityComponent.MaxDensity, fTargetDensity, DeltaTime, ((m_bFogOn) ? m_fFadeInRate : m_fFadeOutRate) * default.SphericalDensityComponent.MaxDensity);
            bForceUpdate = true;
        }
        // End:0x265
        if(!m_bFogOn && SphericalDensityComponent.MaxDensity <= 0.0000000)
        {
            SphericalDensityComponent.SetEnabled(false);
            bEnabled = false;            
        }
        else
        {
            // End:0x292
            if(bForceUpdate)
            {
                SphericalDensityComponent.ForceUpdate(false);
            }
        }        
    }
    else
    {
        // End:0x2FB
        if(bEnabled != m_bFogOn)
        {
            // End:0x2E6
            if(SphericalDensityComponent != none)
            {
                SphericalDensityComponent.SetEnabled(m_bFogOn);
            }
            bEnabled = m_bFogOn;
        }
    }
    //return;    
}

defaultproperties
{
    m_fConvergenceRate=1.0000000
    m_fFadeInRate=0.2000000
    m_fFadeOutRate=0.5000000
    // Reference: FogVolumeSphericalDensityComponent'TgGame.Default__TgSurvivalFogVolumeDensityInfo.FogVolumeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FogVolumeComponent0'
    // Archetype: FogVolumeSphericalDensityComponent'Engine.Default__FogVolumeSphericalDensityInfo.FogVolumeComponent0'
    begin object name="FogVolumeComponent0"
        MaxDensity=0.0060000
        bEnabled=false
        bUseViewOriginOverride=true
        StartDistance=13000.0000000
    end object
    SphericalDensityComponent=FogVolumeComponent0
    DensityComponent=FogVolumeComponent0
    // Reference: StaticMeshComponent'TgGame.Default__TgSurvivalFogVolumeDensityInfo.AutomaticMeshComponent0'
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