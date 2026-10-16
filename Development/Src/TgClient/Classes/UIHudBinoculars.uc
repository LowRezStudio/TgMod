class UIHudBinoculars extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDBINOCULARS_BARRAGES = 3;

const UIHUDBINOCULARS_RETICULEARROWS = 4;

struct UIBinocArrowPositions {
    var Vector2D vInnerArrowStart;
    var Vector2D vInnerArrowEnd;
    var Vector2D vOuterArrowStart;
    var Vector2D vOuterArrowEnd;
    structdefaultproperties {}
};

var bool m_bWasVisible;
var bool m_bHadTarget;
var BinocularSettings m_PrevBinocsSettings;
var Vector2D m_vInnerGuideStartPos;
var Vector2D m_vOuterGuideStartPos;
var Vector2D m_vGuideOffset;
var GFxObject m_mcHeadingGraphic;
var GFxObject m_mcHeading;
var GFxObject m_mcRange;
var GFxObject m_mcTargets;
var GFxObject m_mcInnerGuides;
var GFxObject m_mcOuterGuides;
var GFxObject m_mcGuideFrame;
var GFxObject m_mcStatus;
var GFxObject m_mcStatusTF;
var GFxObject m_mcBarrageFrame[3];
var GFxObject m_mcBarrageMeter[3];
var GFxObject m_mcBarrageTime[3];
var GFxObject m_mcBarrageTimeTF[3];
var GFxObject m_mcReticule;
var GFxObject m_mcReticuleInnerArrows[4];
var GFxObject m_mcReticuleOuterArrows[4];
var UIBinocArrowPositions m_ReticuleArrowPositions[4];
var GFxObject m_mcRefire;
var GFxObject m_mcRefireMask;
var GFxObject m_mcDurationMeter;
var GFxObject m_mcDurationMeterCap;

defaultproperties
{
    m_ReticuleArrowPositions[0]=(vInnerArrowStart=(X=4.0000000,Y=4.0000000),vInnerArrowEnd=(X=40.0000000,Y=40.0000000),vOuterArrowStart=(X=0.0000000,Y=0.0000000),vOuterArrowEnd=(X=43.0000000,Y=43.0000000))
    m_ReticuleArrowPositions[1]=(vInnerArrowStart=(X=209.0000000,Y=4.0000000),vInnerArrowEnd=(X=173.0000000,Y=40.0000000),vOuterArrowStart=(X=213.0000000,Y=0.0000000),vOuterArrowEnd=(X=170.0000000,Y=43.0000000))
    m_ReticuleArrowPositions[2]=(vInnerArrowStart=(X=209.0000000,Y=209.0000000),vInnerArrowEnd=(X=173.0000000,Y=173.0000000),vOuterArrowStart=(X=213.0000000,Y=213.0000000),vOuterArrowEnd=(X=170.0000000,Y=170.0000000))
    m_ReticuleArrowPositions[3]=(vInnerArrowStart=(X=4.0000000,Y=209.0000000),vInnerArrowEnd=(X=40.0000000,Y=173.0000000),vOuterArrowStart=(X=0.0000000,Y=213.0000000),vOuterArrowEnd=(X=43.0000000,Y=170.0000000))
    m_eScalingType=UISCALING_FITTALL
    m_eSnappingType=UISNAPPING_TOP
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudBinoculars"
}
