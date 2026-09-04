class PComRepInfo_Game extends GameReplicationInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var PComMusicThemePlayer m_MusicThemePlayer;
var Class<PComMusicThemePlayer> m_MusicThemePlayerClass;
var globalconfig string m_MusicThemePlayerClassName;

native function PlayMusicEvent(const name EventName);  // Export UPComRepInfo_Game::execPlayMusicEvent(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function CreateMusicThemePlayer() { }

defaultproperties
{
    m_MusicThemePlayerClass=Class'PComMusicThemePlayer'
}
