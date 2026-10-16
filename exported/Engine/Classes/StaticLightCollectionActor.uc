class StaticLightCollectionActor extends Light
    native(Light)
    config(Engine)
    placeable
    hidecategories(Navigation);

var const export editinline array<export editinline LightComponent> LightComponents;
var config int MaxLightComponents;

defaultproperties
{
    MaxLightComponents=100
    Components=none
}