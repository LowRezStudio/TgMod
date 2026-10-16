class TgPostProcessVolume extends PostProcessVolume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display,Advanced,Collision,Volume,Brush,Attachment)
    config(Engine);

var () MaterialInterface m_Material;
var () Scene.ESceneDepthPriorityGroup m_SceneDPG;
var MaterialInstanceConstant m_MaterialMIC;
var () float m_FadeInTime;
var () float m_FadeOutTime;
var () name m_FadeScalarParameterName;

simulated event PostBeginPlay() { }

defaultproperties
{}
