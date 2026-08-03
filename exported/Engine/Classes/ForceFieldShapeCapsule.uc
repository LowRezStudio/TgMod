class ForceFieldShapeCapsule extends ForceFieldShape
    native(ForceField)
    editinlinenew;

var export editinline DrawCapsuleComponent Shape;

event float GetHeight()
{
    return Shape.CapsuleHeight;
    //return ReturnValue;    
}

event float GetRadius()
{
    return Shape.CapsuleRadius;
    //return ReturnValue;    
}

event FillBySphere(float Radius)
{
    Shape.CapsuleRadius = Radius;
    Shape.CapsuleHeight = 0.0000000;
    //return;    
}

event FillByBox(Vector Extent)
{
    Shape.CapsuleRadius = Sqrt((Extent.X * Extent.X) + (Extent.Y * Extent.Y));
    Shape.CapsuleHeight = Extent.Z * float(2);
    //return;    
}

event FillByCapsule(float Height, float Radius)
{
    Shape.CapsuleHeight = Height;
    Shape.CapsuleRadius = Radius;
    //return;    
}

event FillByCylinder(float BottomRadius, float TopRadius, float Height, float HeightOffset)
{
    Shape.CapsuleRadius = FMax(BottomRadius, TopRadius);
    Shape.CapsuleHeight = Height;
    //return;    
}

event PrimitiveComponent GetDrawComponent()
{
    return Shape;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DrawCapsuleComponent'Engine.Default__ForceFieldShapeCapsule.DrawCapsule0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawCapsule0'
    begin object name="DrawCapsule0" class=Engine.DrawCapsuleComponent
        ReplacementPrimitive=none
        Rotation=(Pitch=0,Yaw=0,Roll=16384)
    end object
    Shape=DrawCapsule0
}