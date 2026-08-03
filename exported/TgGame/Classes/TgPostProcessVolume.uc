class TgPostProcessVolume extends PostProcessVolume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display,Advanced,Collision,Volume,Brush,Attachment);

var() MaterialInterface m_Material;
var() Scene.ESceneDepthPriorityGroup m_SceneDPG;
var MaterialInstanceConstant m_MaterialMIC;
var() float m_FadeInTime;
var() float m_FadeOutTime;
var() name m_FadeScalarParameterName;

simulated event PostBeginPlay()
{
    super(Volume).PostBeginPlay();
    m_MaterialMIC = new (none) Class'Engine.MaterialInstanceConstant';
    m_MaterialMIC.SetParent(m_Material);
    //return;    
}

defaultproperties
{
    m_SceneDPG=ESceneDepthPriorityGroup.SDPG_Foreground
    m_FadeInTime=0.5000000
    m_FadeOutTime=1.0000000
    m_FadeScalarParameterName="SCAL_PPFade"
    // Reference: BrushComponent'TgGame.Default__TgPostProcessVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PostProcessVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}