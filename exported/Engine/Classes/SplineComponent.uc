class SplineComponent extends PrimitiveComponent
    native(Spline);

var() InterpCurveVector SplineInfo;
var() editconst float SplineCurviness;
var() Color SplineColor;
var() float SplineDrawRes;
var() float SplineArrowSize;
var() bool bSplineDisabled;
var() InterpCurveFloat SplineReparamTable;

// Export USplineComponent::execUpdateSplineCurviness(FFrame&, void* const)
native function UpdateSplineCurviness();

// Export USplineComponent::execUpdateSplineReparamTable(FFrame&, void* const)
native function UpdateSplineReparamTable();

// Export USplineComponent::execGetSplineLength(FFrame&, void* const)
native function float GetSplineLength();

// Export USplineComponent::execGetLocationAtDistanceAlongSpline(FFrame&, void* const)
native function Vector GetLocationAtDistanceAlongSpline(float Distance);

// Export USplineComponent::execGetTangentAtDistanceAlongSpline(FFrame&, void* const)
native function Vector GetTangentAtDistanceAlongSpline(float Distance);

defaultproperties
{
    SplineColor=(R=255,G=0,B=255,A=255)
    SplineDrawRes=0.1000000
    SplineArrowSize=60.0000000
    ReplacementPrimitive=none
}