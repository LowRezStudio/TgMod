class RB_ConstraintSetup extends Object
    native(Physics)
    hidecategories(Object);

struct native LinearDOFSetup
{
    var() byte bLimited;
    var() float LimitSize;

    structdefaultproperties
    {
        bLimited=1
        LimitSize=0.0000000
    }
};

var() const name JointName;
var() name ConstraintBone1;
var() name ConstraintBone2;
var Vector Pos1;
var Vector PriAxis1;
var Vector SecAxis1;
var Vector Pos2;
var Vector PriAxis2;
var Vector SecAxis2;
var Vector PulleyPivot1;
var Vector PulleyPivot2;
var() bool bEnableProjection;
var() bool m_bBreakOnOwnersDeath;
var bool m_bDoBreak;
var(Linear) bool bLinearLimitSoft;
var(Linear) bool bLinearBreakable;
var(Angular) bool bSwingLimited;
var(Angular) bool bTwistLimited;
var(Angular) bool bSwingLimitSoft;
var(Angular) bool bTwistLimitSoft;
var(Angular) bool bAngularBreakable;
var(Pulley) bool bIsPulley;
var(Pulley) bool bMaintainMinDistance;
var(Linear) LinearDOFSetup LinearXSetup;
var(Linear) LinearDOFSetup LinearYSetup;
var(Linear) LinearDOFSetup LinearZSetup;
var(Linear) float LinearLimitStiffness;
var(Linear) float LinearLimitDamping;
var(Linear) float LinearBreakThreshold;
var(Angular) float Swing1LimitAngle;
var(Angular) float Swing2LimitAngle;
var(Angular) float TwistLimitAngle;
var(Angular) float SwingLimitStiffness;
var(Angular) float SwingLimitDamping;
var(Angular) float TwistLimitStiffness;
var(Angular) float TwistLimitDamping;
var(Angular) float AngularBreakThreshold;
var(Pulley) float PulleyRatio;

defaultproperties
{
    PriAxis1=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    SecAxis1=(X=0.0000000,Y=1.0000000,Z=0.0000000)
    PriAxis2=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    SecAxis2=(X=0.0000000,Y=1.0000000,Z=0.0000000)
    LinearXSetup=(bLimited=1,LimitSize=0.0000000)
    LinearYSetup=(bLimited=1,LimitSize=0.0000000)
    LinearZSetup=(bLimited=1,LimitSize=0.0000000)
    LinearBreakThreshold=300.0000000
    AngularBreakThreshold=500.0000000
    PulleyRatio=1.0000000
}