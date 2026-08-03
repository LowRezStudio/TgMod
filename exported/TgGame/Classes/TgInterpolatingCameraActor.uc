class TgInterpolatingCameraActor extends CameraActor
    hidecategories(Navigation);

struct InterpolatingCameraInfo
{
    var() bool m_bInterpLocation;
    var() bool m_bInterpRotation;
    var() bool m_bInterpFOVAngle;
    var() Vector m_BaseLocation;
    var() Vector m_TargetLocation;
    var() Rotator m_BaseRotation;
    var() Rotator m_TargetRotation;
    var() float m_fBaseFOVAngle;
    var() float m_fTargetFOVAngle;
    var() float m_fInterpSpeed;

    structdefaultproperties
    {
        m_bInterpLocation=true
        m_bInterpRotation=true
        m_bInterpFOVAngle=true
        m_BaseLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        m_TargetLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        m_BaseRotation=(Pitch=0,Yaw=0,Roll=0)
        m_TargetRotation=(Pitch=0,Yaw=0,Roll=0)
        m_fBaseFOVAngle=0.0000000
        m_fTargetFOVAngle=0.0000000
        m_fInterpSpeed=8.0000000
    }
};

var() array<InterpolatingCameraInfo> m_CameraArray;
var() int m_nCurrentCameraIndex;
var float m_fCurrentInterpValue;
var() float m_fTargetInterpValue;

simulated event GetActorEyesViewPoint(out Vector out_Location, out Rotator out_Rotation)
{
    // End:0x4E
    if(!(m_CameraArray.Length > 0) && m_nCurrentCameraIndex <= (m_CameraArray.Length - 1))
    {
        super(Actor).GetActorEyesViewPoint(out_Location, out_Rotation);        
    }
    else
    {
        out_Location = ((m_CameraArray[m_nCurrentCameraIndex].m_bInterpLocation) ? m_CameraArray[m_nCurrentCameraIndex].m_BaseLocation + ((m_CameraArray[m_nCurrentCameraIndex].m_TargetLocation - m_CameraArray[m_nCurrentCameraIndex].m_BaseLocation) * m_fCurrentInterpValue) : Location);
        out_Rotation = ((m_CameraArray[m_nCurrentCameraIndex].m_bInterpRotation) ? m_CameraArray[m_nCurrentCameraIndex].m_BaseRotation + ((m_CameraArray[m_nCurrentCameraIndex].m_TargetRotation - m_CameraArray[m_nCurrentCameraIndex].m_BaseRotation) * m_fCurrentInterpValue) : Rotation);
    }
    //return;    
}

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV)
{
    // End:0x4E
    if(!(m_CameraArray.Length > 0) && m_nCurrentCameraIndex <= (m_CameraArray.Length - 1))
    {
        super.GetCameraView(DeltaTime, OutPOV);        
    }
    else
    {
        GetActorEyesViewPoint(OutPOV.Location, OutPOV.Rotation);
        OutPOV.FOV = ((m_CameraArray[m_nCurrentCameraIndex].m_bInterpFOVAngle) ? m_CameraArray[m_nCurrentCameraIndex].m_fBaseFOVAngle + ((m_CameraArray[m_nCurrentCameraIndex].m_fTargetFOVAngle - m_CameraArray[m_nCurrentCameraIndex].m_fBaseFOVAngle) * m_fCurrentInterpValue) : FOVAngle);
        FOVAngle = OutPOV.FOV;
    }
    //return;    
}

event Tick(float DeltaTime)
{
    super(Actor).Tick(DeltaTime);
    // End:0x95
    if((m_CameraArray.Length > 0) && m_nCurrentCameraIndex <= (m_CameraArray.Length - 1))
    {
        m_fCurrentInterpValue = FInterpTo(m_fCurrentInterpValue, m_fTargetInterpValue, DeltaTime, m_CameraArray[m_nCurrentCameraIndex].m_fInterpSpeed);
    }
    //return;    
}

defaultproperties
{
    Physics=EPhysics.PHYS_None
}