class MaterialExpressionDepthBiasedBlend extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var() bool bNormalize;
var() float BiasScale;
var ExpressionInput RGB;
var ExpressionInput Alpha;
var ExpressionInput Bias;

defaultproperties
{
    BiasScale=1.0000000
    MenuCategories[0]="Obsolete"
    Outputs[0]=(OutputName="",Mask=1,MaskR=1,MaskG=1,MaskB=1,MaskA=0)
    Outputs[1]=(OutputName="",Mask=1,MaskR=1,MaskG=0,MaskB=0,MaskA=0)
    Outputs[2]=(OutputName="",Mask=1,MaskR=0,MaskG=1,MaskB=0,MaskA=0)
    Outputs[3]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=1,MaskA=0)
    Outputs[4]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=0,MaskA=1)
}