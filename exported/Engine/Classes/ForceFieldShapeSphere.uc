class ForceFieldShapeSphere extends ForceFieldShape
    native(ForceField)
    editinlinenew;

var export editinline DrawSphereComponent Shape;

event float GetRadius()
{
    return Shape.SphereRadius;
    //return ReturnValue;    
}

event FillBySphere(float Radius)
{
    Shape.SphereRadius = Radius;
    //return;    
}

event FillByBox(Vector Extent)
{
    Shape.SphereRadius = VSize(Extent);
    //return;    
}

event FillByCapsule(float Height, float Radius)
{
    Shape.SphereRadius = (Height / float(2)) + Radius;
    //return;    
}

event FillByCylinder(float BottomRadius, float TopRadius, float Height, float HeightOffset)
{
    local float topDistance, bottomDistance, centerBelowTop, centerAboveBottom;

    centerBelowTop = (Height / float(2)) + HeightOffset;
    centerAboveBottom = (Height / float(2)) - HeightOffset;
    topDistance = Sqrt((TopRadius * TopRadius) + (centerBelowTop * centerBelowTop));
    bottomDistance = Sqrt((BottomRadius * BottomRadius) + (centerAboveBottom * centerAboveBottom));
    Shape.SphereRadius = FMax(topDistance, bottomDistance);
    //return;    
}

event PrimitiveComponent GetDrawComponent()
{
    return Shape;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DrawSphereComponent'Engine.Default__ForceFieldShapeSphere.DrawSphere0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawSphere0'
    begin object name="DrawSphere0" class=Engine.DrawSphereComponent
        SphereRadius=200.0000000
        ReplacementPrimitive=none
    end object
    Shape=DrawSphere0
}