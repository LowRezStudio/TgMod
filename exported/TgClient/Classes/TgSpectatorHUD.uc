class TgSpectatorHUD extends TgGameHUD
    transient
    native(GameUI)
    config(Game)
    hidecategories(Navigation);

var byte m_eClientVisibilityMode;
var Actor m_LastUIViewTarget;
var bool m_StatsSeeded;
var bool m_bIsBottomPanelHidden;

// Export UTgSpectatorHUD::execUpdateSpectatorViewTarget(FFrame&, void* const)
native function UpdateSpectatorViewTarget(Actor Target);

// Export UTgSpectatorHUD::execUpdateSpectatorViewMode(FFrame&, void* const)
native function UpdateSpectatorViewMode(byte Mode);

// Export UTgSpectatorHUD::execEndMission(FFrame&, void* const)
native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);

// Export UTgSpectatorHUD::execToggleBans(FFrame&, void* const)
native exec function ToggleBans();

// Export UTgSpectatorHUD::execSetSpectatorSkillsMode(FFrame&, void* const)
native exec function SetSpectatorSkillsMode(int nNum);

// Export UTgSpectatorHUD::execSetSpectatorTeamMode(FFrame&, void* const)
native exec function SetSpectatorTeamMode(int nNum);

// Export UTgSpectatorHUD::execSetSpectatorStatsMode(FFrame&, void* const)
native exec function SetSpectatorStatsMode(int nNum);

exec function ToggleVisibilityMode()
{
    SetVisibilityMode(0);
    //return;    
}

exec function SetVisibilityMode(byte Mode)
{
    local TgRepInfo_Player PRI;

    m_eClientVisibilityMode = Mode;
    // End:0x4C
    foreach DynamicActors(Class'TgGame.TgRepInfo_Player', PRI)
    {
        PRI.ClientUpdateItemStoreItems();        
    }    
    UpdateSpectatorViewMode(m_eClientVisibilityMode);
    //return;    
}

event Tick(float DeltaTime)
{
    local Actor ViewTarget;

    super(TgClientHUD).Tick(DeltaTime);
    ViewTarget = PlayerOwner.GetViewTarget();
    // End:0x79
    if(ViewTarget != m_LastUIViewTarget)
    {
        UpdateSpectatorViewTarget(ViewTarget);
        m_LastUIViewTarget = ViewTarget;
    }
    //return;    
}

// Export UTgSpectatorHUD::execToggleHUD(FFrame&, void* const)
native exec function ToggleHUD();

function bool ValidateSceneForSpectate(string SceneName)
{
    // End:0x5D
    if(SceneName == "GodStats")
    {
        // End:0x52
        if(TgSpectatorController(PlayerOwner.GetViewTarget()) == none)
        {
            m_StatsSeeded = true;
        }
        return m_StatsSeeded;
    }
    return true;
    //return ReturnValue;    
}

exec function ToggleCursor(bool bEnabled)
{
    m_pMovie.usc_toggle_cursor(bEnabled);
    //return;    
}

defaultproperties
{
    // Reference: PComPictureInPicture'TgClient.Default__TgSpectatorHUD.PictureInPicture'
    // Archetype: PComPictureInPicture'TgClient.Default__TgGameHUD.PictureInPicture'
    begin object name="PictureInPicture"
    end object
    m_PictureInPicture=PictureInPicture
}