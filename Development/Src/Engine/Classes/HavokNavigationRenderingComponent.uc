class HavokNavigationRenderingComponent extends PrimitiveComponent
    native(Havok)
    hidecategories(Object)
    config(Engine);

var editoronly transient bool bDrawEdges;

defaultproperties
{
    ReplacementPrimitive=none
    HiddenGame=true
    bAcceptsDynamicDecals=false
    bCastDynamicShadow=false
    bCastStaticShadow=false
    bAcceptsDynamicDominantLightShadows=false
    bAcceptsDynamicLights=false
    bUseOnePassLightingOnTranslucency=true
    CanBlockCamera=false
    AlwaysLoadOnClient=false
    AlwaysLoadOnServer=false
    bAllowShadowFade=false
    TranslucencySortPriority=-2
}
