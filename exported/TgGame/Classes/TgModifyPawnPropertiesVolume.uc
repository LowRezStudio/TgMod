class TgModifyPawnPropertiesVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var(Object) editconst int m_nMapObjectId;
var() bool m_bDisableJump;
var() bool m_bDisableBlockActors;
var() bool m_bDisableHanging;
var() bool m_bDisableAllDevices;
var() bool m_bTriggerUseEvent;
var() bool m_bOneWayMovement;
var Rotator m_vOnewWay;
var export editinline ArrowComponent m_DirArrow;
var() int s_nLootTableId;

// Export UTgModifyPawnPropertiesVolume::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

// Export UTgModifyPawnPropertiesVolume::execUsed(FFrame&, void* const)
native function Used(Actor Other);

event PostBeginPlay()
{
    super.PostBeginPlay();
    LoadObjectConfig();
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn Pawn;

    Pawn = TgPawn(Other);
    // End:0x77
    if(Pawn != none)
    {
        Pawn.ModifyPawnPropertiesVolumeChanged();
        // End:0x77
        if(m_bTriggerUseEvent)
        {
            Pawn.m_CurrentUseActor = self;
        }
    }
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn Pawn;

    Pawn = TgPawn(Other);
    // End:0x77
    if(Pawn != none)
    {
        Pawn.ModifyPawnPropertiesVolumeChanged();
        // End:0x77
        if(m_bTriggerUseEvent)
        {
            Pawn.m_CurrentUseActor = none;
        }
    }
    super(Actor).UnTouch(Other);
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'TgGame.Default__TgModifyPawnPropertiesVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bSkipActorPropertyReplication=false
    CollisionComponent=BrushComponent0
    SupportedEvents=/* Array type was not detected. */
}