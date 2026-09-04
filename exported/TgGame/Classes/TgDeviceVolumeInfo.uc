class TgDeviceVolumeInfo extends Info
    hidecategories(Navigation,Movement,Collision);

var TgDeviceVolume V;

event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    SetTimer(1.0000000, true);
    V = TgDeviceVolume(Owner);
    //return;    
}

event Timer()
{
    V.TimerPop(self);
    //return;    
}
