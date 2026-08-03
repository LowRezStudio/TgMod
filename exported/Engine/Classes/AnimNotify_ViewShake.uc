class AnimNotify_ViewShake extends AnimNotify_Scripted
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var private editconst float Duration;
var private editconst Vector RotAmplitude;
var private editconst Vector RotFrequency;
var private editconst Vector LocAmplitude;
var private editconst Vector LocFrequency;
var private editconst float FOVAmplitude;
var private editconst float FOVFrequency;
var() bool bDoControllerVibration;
var() bool bUseBoneLocation;
var() float ShakeRadius;
var() name BoneName;
var() export editinline CameraShake ShakeParams;

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator)
{
    local Vector ViewShakeOrigin;
    local Pawn P;
    local PlayerController PC;

    // End:0xCF
    if(ShakeRadius == float(0))
    {
        P = Pawn(Owner);
        // End:0xCC
        if((P != none) && P.IsLocallyControlled())
        {
            PC = PlayerController(P.Controller);
            // End:0xCC
            if(PC != none)
            {
                PC.ClientPlayCameraShake(ShakeParams);
            }
        }        
    }
    else
    {
        // End:0x15E
        if((bUseBoneLocation && AnimSeqInstigator != none) && AnimSeqInstigator.SkelComponent != none)
        {
            ViewShakeOrigin = AnimSeqInstigator.SkelComponent.GetBoneLocation(BoneName);            
        }
        else
        {
            ViewShakeOrigin = Owner.Location;
        }
        // End:0x1ED
        if(Owner != none)
        {
            Class'Engine.Camera'.static.PlayWorldCameraShake(ShakeParams, Owner, ViewShakeOrigin, 0.0000000, ShakeRadius, 1.0000000, bDoControllerVibration);
        }
    }
    //return;    
}

defaultproperties
{
    Duration=1.0000000
    RotAmplitude=(X=100.0000000,Y=100.0000000,Z=200.0000000)
    RotFrequency=(X=10.0000000,Y=10.0000000,Z=25.0000000)
    LocAmplitude=(X=0.0000000,Y=3.0000000,Z=6.0000000)
    LocFrequency=(X=1.0000000,Y=10.0000000,Z=20.0000000)
    FOVAmplitude=2.0000000
    FOVFrequency=5.0000000
    ShakeRadius=4096.0000000
}