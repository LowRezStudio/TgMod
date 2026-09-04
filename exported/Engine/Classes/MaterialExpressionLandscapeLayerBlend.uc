class MaterialExpressionLandscapeLayerBlend extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

enum ELandscapeLayerBlendType
{
    LB_AlphaBlend,                  // 0
    LB_HeightBlend,                 // 1
    LB_MAX                          // 2
};

struct native LayerBlendInput
{
    var() name LayerName;
    var() MaterialExpressionLandscapeLayerBlend.ELandscapeLayerBlendType BlendType;
    var edithide ExpressionInput LayerInput;
    var edithide ExpressionInput HeightInput;
    var() float PreviewWeight;
    var native const transient Pointer InstanceOverride;

    structdefaultproperties
    {
        LayerName="None"
        BlendType=ELandscapeLayerBlendType.LB_AlphaBlend
        LayerInput=(Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
        HeightInput=(Expression=none,OutputIndex=0,InputName="",Mask=0,MaskR=0,MaskG=0,MaskB=0,MaskA=0,GCC64_Padding=0)
        PreviewWeight=0.0000000
    }
};

var() array<LayerBlendInput> Layers;
var const Guid ExpressionGUID;

defaultproperties
{
    bIsParameterExpression=true
    bUsedByStaticParameterSet=true
    MenuCategories[0]="Terrain"
    MenuCategories[1]="WorldPosOffset"
}