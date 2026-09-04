class PostProcessEffect extends Object
    native
    hidecategories(Object);

var() bool bShowInEditor;
var() bool bShowInGame;
var() bool bUseWorldSettings;
var() bool m_D3D11Only;
var bool bAffectsLightingOnly;
var() name EffectName;
var int NodePosY;
var int NodePosX;
var int DrawWidth;
var int DrawHeight;
var int OutDrawY;
var int InDrawY;
var() Scene.ESceneDepthPriorityGroup SceneDPG;

defaultproperties
{
    bShowInEditor=true
    bShowInGame=true
    SceneDPG=ESceneDepthPriorityGroup.SDPG_PostProcess
}