class ForceFieldShapeBox extends ForceFieldShape
    native(ForceField)
    editinlinenew;

var export editinline DrawBoxComponent Shape;

event Vector GetRadii()
{
    return Shape.BoxExtent;
    //return ReturnValue;    
}

event FillBySphere(float Radius)
{
    Shape.BoxExtent.X = Radius;
    Shape.BoxExtent.Y = Radius;
    Shape.BoxExtent.Z = Radius;
    //return;    
}

event FillByBox(Vector Extent)
{
    Shape.BoxExtent = Extent;
    //return;    
}

event FillByCapsule(float Height, float Radius)
{
    Shape.BoxExtent.X = Radius;
    Shape.BoxExtent.Y = Radius;
    Shape.BoxExtent.Z = Radius + (Height / float(2));
    //return;    
}

event FillByCylinder(float BottomRadius, float TopRadius, float Height, float HeightOffset)
{
    Shape.BoxExtent.X = FMax(BottomRadius, TopRadius);
    Shape.BoxExtent.Y = Shape.BoxExtent.X;
    Shape.BoxExtent.Z = (Height / float(2)) + Abs(HeightOffset);
    //return;    
}

event PrimitiveComponent GetDrawComponent()
{
    return Shape;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DrawBoxComponent'Engine.Default__ForceFieldShapeBox.DrawBox0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawBox0'
    begin object name="DrawBox0" class=Engine.DrawBoxComponent
        ReplacementPrimitive=none
    end object
    Shape=DrawBox0
}