class PComRepInfo_Game extends GameReplicationInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var PComMusicThemePlayer m_MusicThemePlayer;
var class<PComMusicThemePlayer> m_MusicThemePlayerClass;
var globalconfig string m_MusicThemePlayerClassName;

// Export UPComRepInfo_Game::execPlayMusicEvent(FFrame&, void* const)
native function PlayMusicEvent(const name EventName);

simulated function PostBeginPlay()
{
    //return;    
}

simulated function CreateMusicThemePlayer()
{
    //return;    
}

defaultproperties
{
    m_MusicThemePlayerClass=Class'PComMusicThemePlayer'
}