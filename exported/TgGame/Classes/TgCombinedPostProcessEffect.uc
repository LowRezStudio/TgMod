class TgCombinedPostProcessEffect extends PostProcessEffect
    native
    hidecategories(Object);

var(Hit) Color HitEffectColor;
var Vector SceneShadows;
var Vector SceneHighLights;
var Vector SceneMidTones;
var float SceneDesaturation;
var Vector SceneColorize;

defaultproperties
{
    HitEffectColor=(R=89,G=0,B=0,A=255)
}