class ReverbVolume extends Volume
    native
    placeable
    dontsortcategories(ReverbVolume)
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Volume,Toggle);

enum ReverbPreset
{
    REVERB_Default,                 // 0
    REVERB_Bathroom,                // 1
    REVERB_StoneRoom,               // 2
    REVERB_Auditorium,              // 3
    REVERB_ConcertHall,             // 4
    REVERB_Cave,                    // 5
    REVERB_Hallway,                 // 6
    REVERB_StoneCorridor,           // 7
    REVERB_Alley,                   // 8
    REVERB_Forest,                  // 9
    REVERB_City,                    // 10
    REVERB_Mountains,               // 11
    REVERB_Quarry,                  // 12
    REVERB_Plain,                   // 13
    REVERB_ParkingLot,              // 14
    REVERB_SewerPipe,               // 15
    REVERB_Underwater,              // 16
    REVERB_SmallRoom,               // 17
    REVERB_MediumRoom,              // 18
    REVERB_LargeRoom,               // 19
    REVERB_MediumHall,              // 20
    REVERB_LargeHall,               // 21
    REVERB_Plate,                   // 22
    REVERB_MAX                      // 23
};

struct native ReverbSettings
{
    var() bool bApplyReverb;
    var() ReverbVolume.ReverbPreset ReverbType;
    var() float Volume;
    var() float FadeTime;

    structdefaultproperties
    {
        bApplyReverb=true
        ReverbType=ReverbPreset.REVERB_Default
        Volume=0.5000000
        FadeTime=2.0000000
    }
};

struct InteriorSettings
{
    var bool bIsWorldInfo;
    var() float ExteriorVolume;
    var() float ExteriorTime;
    var() float ExteriorLPF;
    var() float ExteriorLPFTime;
    var() float InteriorVolume;
    var() float InteriorTime;
    var() float InteriorLPF;
    var() float InteriorLPFTime;
    var() float InsulationDistanceMin;
    var() float InsulationDistanceMax;
    var() float InsulationTime;

    structdefaultproperties
    {
        bIsWorldInfo=false
        ExteriorVolume=1.0000000
        ExteriorTime=0.5000000
        ExteriorLPF=1.0000000
        ExteriorLPFTime=0.5000000
        InteriorVolume=1.0000000
        InteriorTime=0.5000000
        InteriorLPF=1.0000000
        InteriorLPFTime=0.5000000
        InsulationDistanceMin=0.0000000
        InsulationDistanceMax=0.0000000
        InsulationTime=0.5000000
    }
};

var() float Priority;
var(Toggle) bool bEnabled;
var(AudioAltitude) bool m_bUseAudioAltitude;
var() ReverbSettings Settings;
var() InteriorSettings AmbientZoneSettings;
var noimport const transient ReverbVolume NextLowerPriorityVolume;
var() name AuxBusName;
var() float SendLevel;
var(AudioAltitude) float m_fAudioAltitudeCeiling;
var(AudioAltitude) float m_fAudioAltitudeFloor;

replication
{
    // Pos:0x000
    if(bNetDirty)
        bEnabled;
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    Other.UpdateReverbVolume(HitLocation, self);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    super(Actor).UnTouch(Other);
    Other.UpdateReverbVolume(Other.Location);
    //return;    
}

defaultproperties
{
    bEnabled=true
    Settings=(bApplyReverb=true,ReverbType=ReverbPreset.REVERB_Default,Volume=0.5000000,FadeTime=2.0000000)
    AmbientZoneSettings=(bIsWorldInfo=false,ExteriorVolume=1.0000000,ExteriorTime=0.5000000,ExteriorLPF=1.0000000,ExteriorLPFTime=0.5000000,InteriorVolume=1.0000000,InteriorTime=0.5000000,InteriorLPF=1.0000000,InteriorLPFTime=0.5000000,InsulationDistanceMin=0.0000000,InsulationDistanceMax=0.0000000,InsulationTime=0.5000000)
    SendLevel=1.0000000
    BrushColor=(R=255,G=255,B=0,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__ReverbVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        bAcceptsLights=false
        BlockZeroExtent=true
        AlwaysLoadOnServer=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
}