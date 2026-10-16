class TgInterpolatingCameraActor extends CameraActor
    hidecategories(Navigation)
    config(Engine);

struct InterpolatingCameraInfo {
    var () bool m_bInterpLocation;
    var () bool m_bInterpRotation;
    var () bool m_bInterpFOVAngle;
    var () Vector m_BaseLocation;
    var () Vector m_TargetLocation;
    var () Rotator m_BaseRotation;
    var () Rotator m_TargetRotation;
    var () float m_fBaseFOVAngle;
    var () float m_fTargetFOVAngle;
    var () float m_fInterpSpeed;
    structdefaultproperties {}
};

var () array<InterpolatingCameraInfo> m_CameraArray;
var () int m_nCurrentCameraIndex;
var float m_fCurrentInterpValue;
var () float m_fTargetInterpValue;

simulated event GetActorEyesViewPoint(out vector out_Location, out Rotator out_Rotation) { }

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV) { }

event Tick(float DeltaTime) { }

defaultproperties
{
    Physics=PHYS_None
}
