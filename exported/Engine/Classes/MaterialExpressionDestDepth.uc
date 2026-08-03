class MaterialExpressionDestDepth extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var() bool bNormalize;

defaultproperties
{
    MenuCategories[0]="Destination"
    MenuCategories[1]="Depth"
    Outputs[0]=(OutputName="",Mask=1,MaskR=1,MaskG=0,MaskB=0,MaskA=0)
}