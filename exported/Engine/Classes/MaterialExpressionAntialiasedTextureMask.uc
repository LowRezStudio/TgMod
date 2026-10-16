class MaterialExpressionAntialiasedTextureMask extends MaterialExpressionTextureSampleParameter2D
    native(Material)
    collapsecategories
    hidecategories(Object,Object,Object,Object);

enum ETextureColorChannel
{
    TCC_Red,                        // 0
    TCC_Green,                      // 1
    TCC_Blue,                       // 2
    TCC_Alpha,                      // 3
    TCC_MAX                         // 4
};

var() float Threshold;
var() MaterialExpressionAntialiasedTextureMask.ETextureColorChannel Channel;

defaultproperties
{
    Threshold=0.5000000
    Channel=ETextureColorChannel.TCC_Alpha
    MenuCategories[0]="HighLevel"
    MenuCategories[1]="Parameters"
    Outputs[0]=(OutputName="",Mask=1,MaskR=1,MaskG=0,MaskB=0,MaskA=0)
    Outputs[1]=(OutputName="",Mask=1,MaskR=1,MaskG=0,MaskB=0,MaskA=0)
    Outputs[2]=(OutputName="",Mask=1,MaskR=0,MaskG=1,MaskB=0,MaskA=0)
    Outputs[3]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=1,MaskA=0)
    Outputs[4]=(OutputName="",Mask=1,MaskR=0,MaskG=0,MaskB=0,MaskA=1)
}