class PComRepInfo_Game extends GameReplicationInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var PComMusicThemePlayer m_MusicThemePlayer;
var Class<PComMusicThemePlayer> m_MusicThemePlayerClass;
var globalconfig string m_MusicThemePlayerClassName;

// Export UPComRepInfo_Game::execPlayMusicEvent(FFrame&, void* const)
native function PlayMusicEvent(const name EventName);

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    CreateMusicThemePlayer();
    //return;    
}

simulated function CreateMusicThemePlayer()
{
    // End:0x40
    if(Len(m_MusicThemePlayerClassName) > 0)
    {
        m_MusicThemePlayerClass = Class<PComMusicThemePlayer>(FindObject(m_MusicThemePlayerClassName, Class'Core.Class'));
    }
    m_MusicThemePlayer = new (self) m_MusicThemePlayerClass;
    m_MusicThemePlayer.Init();
    //return;    
}

defaultproperties
{
    m_MusicThemePlayerClass=Class'PlatformCommon.PComMusicThemePlayer'
}