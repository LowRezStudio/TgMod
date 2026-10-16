class VolumeTimer extends Info
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var PhysicsVolume V;

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    V = PhysicsVolume(Owner);
    SetTimer(V.PainInterval, true);
    //return;    
}

event Timer()
{
    V.TimerPop(self);
    //return;    
}
