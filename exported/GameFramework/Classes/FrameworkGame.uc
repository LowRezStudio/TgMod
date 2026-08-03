class FrameworkGame extends GameInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

struct native RequiredMobileInputConfig
{
    var config string GroupName;
    var init config array<init config string> RequireZoneNames;
    var config bool bIsAttractModeGroup;

    structdefaultproperties
    {
        GroupName=""
        RequireZoneNames=none
        bIsAttractModeGroup=false
    }
};

var config array<config RequiredMobileInputConfig> RequiredMobileInputConfigs;

event TgStartGame(out string Reason)
{
    //return;    
}

event TgEndGame(out string Reason)
{
    //return;    
}

event TgTimer(out string sTimerCommand)
{
    //return;    
}

event TgChangeScore(int nTeam, optional int nCount = 1)
{
    //return;    
}

event TgChangeTime(int nSeconds)
{
    //return;    
}

event TgGetSpectators(out array<string> List)
{
    //return;    
}

defaultproperties
{
    RequiredMobileInputConfigs[0]=(GroupName="DebugGroup",RequireZoneNames=("DebugStickMoveZone","DebugStickLookZone","DebugLookZone"),bIsAttractModeGroup=false)
}