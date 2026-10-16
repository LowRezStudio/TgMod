class TgPortal extends Portal
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var(Teleport) bool bUpdateRotation;
var(Teleport) bool bCheckOverlap;
var(Teleport) bool bResetVelocity;
var(Teleport) bool bCheckTaskForce;
var(Teleport) int nTaskForce;
var(TeleportSound) SoundCue TeleportSoundCue;
var(TeleportSound) float FadeInTime;
var(TeleportSound) float VolumeMultiplier;
var(TeleportSound) float PitchMultiplier;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local array<Object> TeleportDestinations;
    local editinline AudioComponent AC;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x279
    if(IsValidPortal() && !bCheckTaskForce || !IsEnemy(Other))
    {
        // End:0x279
        if(Pawn(Other) != none)
        {
            TeleportDestinations.AddItem(Destination);
            // End:0x276
            if(Pawn(Other).HandleTeleport(TeleportDestinations, bUpdateRotation, bCheckOverlap, -1.0000000))
            {
                // End:0x11C
                if(bResetVelocity)
                {
                    Other.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
                }
                // End:0x273
                if(TeleportSoundCue != none)
                {
                    AC = Other.CreateAudioComponent(TeleportSoundCue, false, true);
                    // End:0x273
                    if(AC != none)
                    {
                        AC.VolumeMultiplier = VolumeMultiplier;
                        AC.PitchMultiplier = PitchMultiplier;
                        AC.bAutoDestroy = true;
                        AC.SubtitlePriority = 10000.0000000;
                        AC.bSuppressSubtitles = true;
                        AC.FadeIn(FadeInTime, 1.0000000);
                        AC.Play();
                    }
                }                
            }            
        }
    }
    //return;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgPortal.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Portal.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    Components[2]=none
    CollisionComponent=BrushComponent0
}