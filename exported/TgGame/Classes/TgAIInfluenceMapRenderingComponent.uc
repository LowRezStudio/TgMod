class TgAIInfluenceMapRenderingComponent extends HavokNavigationRenderingComponent
    native(AI)
    hidecategories(Object);

var transient TgAIInfluenceMap InfluenceMap;
var transient Texture2DDynamic InfluenceMapTexture;

defaultproperties
{
    ReplacementPrimitive=none
    HiddenGame=false
    bIgnoreOwnerHidden=true
    TranslucencySortPriority=1
}