class TgVisibilityVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var(PlayerCameraEffects) ParticleSystem m_PlayerCameraParticleSystem;
var(PlayerCameraEffects) ParticleSystem m_PlayerCameraInvisibleParticleSystem;

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x7D
    if(Other.IsA('TgPawn'))
    {
        TgPawn(Other).AddVisibilityVolume(self);        
    }
    else
    {
        // End:0xC9
        if(Other.IsA('TgRespawnBeaconExit'))
        {
            TgRespawnBeaconExit(Other).AddVisibilityVolume(self);
        }
    }
    //return;    
}

simulated event UnTouch(Actor Other)
{
    super(Actor).UnTouch(Other);
    // End:0x62
    if(Other.IsA('TgPawn'))
    {
        TgPawn(Other).RemoveVisibilityVolume(self);        
    }
    else
    {
        // End:0xAE
        if(Other.IsA('TgRespawnBeaconExit'))
        {
            TgRespawnBeaconExit(Other).RemoveVisibilityVolume(self);
        }
    }
    //return;    
}

defaultproperties
{
    m_PlayerCameraParticleSystem=ParticleSystem'FX_Env_Atmosphere.Particles.FX_Hidden_Area_1P_CAM'
    m_PlayerCameraInvisibleParticleSystem=ParticleSystem'FX_Env_Atmosphere.Particles.FX_Hidden_1P_CAM'
    // Reference: BrushComponent'TgGame.Default__TgVisibilityVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        BlockZeroExtent=true
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
    SupportedEvents=/* Array type was not detected. */
}