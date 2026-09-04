class TgSpectatorHUD extends TgGameHUD
    transient
    native(GameUI)
    config(Game)
    hidecategories(Navigation);

var byte m_eClientVisibilityMode;
var Actor m_LastUIViewTarget;
var bool m_StatsSeeded;
var bool m_bIsBottomPanelHidden;

native function UpdateSpectatorViewTarget(Actor Target);  // Export UTgSpectatorHUD::execUpdateSpectatorViewTarget(FFrame&, void* const)

native function UpdateSpectatorViewMode(byte Mode);  // Export UTgSpectatorHUD::execUpdateSpectatorViewMode(FFrame&, void* const)

native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);  // Export UTgSpectatorHUD::execEndMission(FFrame&, void* const)

native exec function ToggleBans();  // Export UTgSpectatorHUD::execToggleBans(FFrame&, void* const)

native exec function SetSpectatorSkillsMode(int nNum);  // Export UTgSpectatorHUD::execSetSpectatorSkillsMode(FFrame&, void* const)

native exec function SetSpectatorTeamMode(int nNum);  // Export UTgSpectatorHUD::execSetSpectatorTeamMode(FFrame&, void* const)

native exec function SetSpectatorStatsMode(int nNum);  // Export UTgSpectatorHUD::execSetSpectatorStatsMode(FFrame&, void* const)

exec function ToggleVisibilityMode() { }

exec function SetVisibilityMode(byte Mode) { }

event Tick(float DeltaTime) { }

native exec function ToggleHUD();  // Export UTgSpectatorHUD::execToggleHUD(FFrame&, void* const)

function bool ValidateSceneForSpectate(string SceneName) { }

exec function ToggleCursor(bool bEnabled) { }

defaultproperties
{}
