class SeqEvent_MobileZoneBase extends SeqEvent_MobileBase
    abstract
    native
    hidecategories(Object);

var() string TargetZoneName;

event AddToMobileInput(MobilePlayerInput MPI)
{
    local MobileInputZone Zone;

    Zone = MPI.FindZone(TargetZoneName);
    // End:0x61
    if(Zone != none)
    {
        Zone.AddKismetEventHandler(self);
    }
    //return;    
}
