class UISoundTheme extends Object
    native(UserInterface);

struct native SoundEventMapping
{
    var() name SoundEventName;
    var() SoundCue SoundToPlay;

    structdefaultproperties
    {
        SoundEventName="None"
        SoundToPlay=none
    }
};

var() array<SoundEventMapping> SoundEventBindings;

event ProcessSoundEvent(name SoundEventName, optional PlayerController SoundOwner)
{
    local int EventIndex;

    EventIndex = SoundEventBindings.Find('SoundEventName', SoundEventName);
    // End:0xFC
    if(EventIndex != -1)
    {
        // End:0x99
        if(SoundOwner != none)
        {
            SoundOwner.PlaySound(SoundEventBindings[EventIndex].SoundToPlay, true, true, true);            
        }
        else
        {
            Class'Engine.WorldInfo'.static.GetWorldInfo().PlaySound(SoundEventBindings[EventIndex].SoundToPlay, true, true, true);
        }        
    }
    //return;    
}
