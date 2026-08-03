class SkelControlSpline extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

enum ESplineControlRotMode
{
    SCR_NoChange,                   // 0
    SCR_AlongSpline,                // 1
    SCR_Interpolate,                // 2
    SCR_MAX                         // 3
};

var(Spline) int SplineLength;
var(Spline) Object.EAxis SplineBoneAxis;
var(Spline) SkelControlSpline.ESplineControlRotMode BoneRotMode;
var(Spline) bool bInvertSplineBoneAxis;
var(Spline) float EndSplineTension;
var(Spline) float StartSplineTension;

defaultproperties
{
    SplineLength=2
    SplineBoneAxis=EAxis.AXIS_X
    EndSplineTension=10.0000000
    StartSplineTension=10.0000000
}