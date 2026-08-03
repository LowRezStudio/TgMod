class MaterialExpressionDynamicParameter extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var() editfixedsize array<string> ParamNames;

defaultproperties
{
    ParamNames[0]="Param1"
    ParamNames[1]="Param2"
    ParamNames[2]="Param3"
    ParamNames[3]="Param4"
    bShowOutputNameOnPin=true
    bHidePreviewWindow=true
    MenuCategories[0]="Particles"
    MenuCategories[1]="Parameters"
    Outputs[0]=(OutputName="",Mask=1,MaskR=1,MaskG=0,MaskB=0,MaskA=0)
    Outputs[1]=(OutputName="",Mask=1,MaskR=0,MaskG=1,MaskB=0,MaskA=0)
    Outputs[2]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=1,MaskA=0)
    Outputs[3]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=0,MaskA=1)
}