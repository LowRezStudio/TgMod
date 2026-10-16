class UIHudWaypoint extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDWAYPOINT_PROJECTILES = 4;

struct WaypointObjective {
    var GFxObject pClip;
    var GFxObject pIcon;
    var GFxObject pDist;
    var GFxObject pPulse;
    var GFxObject pTitle;
    var bool bVisible;
    structdefaultproperties {}
};

var float m_fClipSize;
var float m_fPushTimer;
var float m_fPulseDelay;
var float m_fPulseTimer;
var array<WaypointObjective> m_Captures;
var WaypointObjective m_Escort;
var WaypointObjective m_Attack;
var WaypointObjective m_Defend;
var WaypointObjective m_Beacon;
var WaypointObjective m_Projectile[4];
var WaypointObjective m_KillCamYou;
var array<WaypointObjective> m_DominationObjectives;
var Vector m_SnappedWaypointOffset;

event bool GetScreenCoordinates(Canvas pCanvas, Vector CameraLocation, Vector CameraRotation, Vector ObjectLocation, out Vector ScreenLocation) { }

defaultproperties
{
    m_fClipSize=180.0000000
    m_fPulseDelay=1.0000000
    m_eScalingType=UISCALING_FITTALL
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudWaypoint"
}
