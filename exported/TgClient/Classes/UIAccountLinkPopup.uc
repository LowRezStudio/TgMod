class UIAccountLinkPopup extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

var init string m_sUserEmail;

event SetOSSRecordingEnabled(bool bEnabled)
{
    local OnlineSubsystem OnlineSub;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xE9
    if((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.GameDVRInterface, OnlineGameDVRInterface(none)))
    {
        // End:0xB4
        if(bEnabled)
        {
            OnlineSub.GameDVRInterface.EnableRecording();            
        }
        else
        {
            OnlineSub.GameDVRInterface.DisableRecording();
        }
    }
    //return;    
}

defaultproperties
{
    m_UISceneClass=Class'TgClient.UIScene_UIAccountLink'
    m_OptionList[0]=245
    m_OptionList[1]=3
    m_OptionList[2]=0
    m_bIsPopup=true
    m_Name="UIAccountLinkPopup"
}