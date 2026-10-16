class UIHudWaypoint extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDWAYPOINT_PROJECTILES = 4;

struct native WaypointObjective
{
    var GFxObject pClip;
    var GFxObject pIcon;
    var GFxObject pDist;
    var GFxObject pPulse;
    var GFxObject pTitle;
    var bool bVisible;

    structdefaultproperties
    {
        pClip=none
        pIcon=none
        pDist=none
        pPulse=none
        pTitle=none
        bVisible=false
    }
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

event bool GetScreenCoordinates(Canvas pCanvas, Vector CameraLocation, Vector CameraRotation, Vector ObjectLocation, out Vector ScreenLocation)
{
    local bool bBehind;
    local float fClipX, fClipY, fLimitX, fLimitY, fBase, fLineSlope,
	    fLineConstant;

    local Vector ScreenDirection;

    fClipX = pCanvas.ClipX;
    fClipY = pCanvas.ClipY;
    fBase = m_fClipSize / float(2);
    fLimitX = fClipX - fBase;
    fLimitY = fClipY - fBase;
    ScreenLocation = pCanvas.Project(ObjectLocation);
    bBehind = (CameraRotation Dot (ObjectLocation - CameraLocation)) <= 0.0000000;
    // End:0x1C9
    if(((((ScreenLocation.X > fBase) && ScreenLocation.X < fLimitX) && ScreenLocation.Y > m_fClipSize) && ScreenLocation.Y < fLimitY) && !bBehind)
    {
        return false;
    }
    ScreenDirection = pCanvas.Project(CameraLocation + Normal(ObjectLocation - CameraLocation));
    // End:0x26A
    if(((fClipX / 2.0000000) - ScreenDirection.X) == float(0))
    {
        ScreenDirection.X -= float(1);
    }
    fLineSlope = ((fClipY / 2.0000000) - ScreenDirection.Y) / ((fClipX / 2.0000000) - ScreenDirection.X);
    fLineConstant = ScreenDirection.Y - (fLineSlope * ScreenDirection.X);
    // End:0x378
    if(ScreenDirection.Y > (fClipY / 2.0000000))
    {
        ScreenLocation.Y = fLimitY;
    }
    // End:0x3DB
    if(fLineSlope != float(0))
    {
        ScreenLocation.X = (ScreenLocation.Y - fLineConstant) / fLineSlope;        
    }
    else
    {
        ScreenLocation.X = fClipX / 2.0000000;
    }
    // End:0x4AA
    if(ScreenLocation.X > fLimitX)
    {
        ScreenLocation.X = fLimitX;
        ScreenLocation.Y = (fLineSlope * ScreenLocation.X) + fLineConstant;        
    }
    else
    {
        // End:0x549
        if(ScreenLocation.X < fBase)
        {
            ScreenLocation.X = fBase;
            ScreenLocation.Y = (fLineSlope * ScreenLocation.X) + fLineConstant;
        }
    }
    // End:0x619
    if(bBehind)
    {
        // End:0x5AF
        if(ScreenLocation.X < (fClipX / float(2)))
        {
            ScreenLocation.X = fLimitX;            
        }
        else
        {
            ScreenLocation.X = fBase;
        }
        ScreenLocation.Y = fClipY - ScreenLocation.Y;
    }
    // End:0x669
    if(ScreenLocation.Y < fBase)
    {
        ScreenLocation.Y = fBase;
    }
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    m_fClipSize=180.0000000
    m_fPulseDelay=1.0000000
    m_eScalingType=UISCALINGTYPE.UISCALING_FITTALL
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudWaypoint"
}