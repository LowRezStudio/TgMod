interface OnlinePlayerInterfaceEx extends Interface
    abstract;

function bool ShowFeedbackUI(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool ShowHelpUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowHelpForErrorUI(string ContextId, string ErrorString)
{
    //return ReturnValue;    
}

delegate OnShowHelpComplete(bool bWasSuccessful)
{
    //return;    
}

function AddShowHelpCompleteDelegate(delegate<OnShowHelpComplete> HelpDelegate)
{
    //return;    
}

function ClearShowHelpCompleteDelegate(delegate<OnShowHelpComplete> HelpDelegate)
{
    //return;    
}

function bool ShowVideo(string URL)
{
    //return ReturnValue;    
}

delegate OnShowGamerCardComplete(bool bWasSuccessful)
{
    //return;    
}

function AddShowGamerCardCompleteDelegate(delegate<OnShowGamerCardComplete> GamerCardDelegate)
{
    //return;    
}

function ClearShowGamerCardCompleteDelegate(delegate<OnShowGamerCardComplete> GamerCardDelegate)
{
    //return;    
}

function bool ShowGamerCardUI(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool ShowGamerCardUIByUsername(byte LocalUserNum, string UserName)
{
    //return ReturnValue;    
}

delegate OnShowComposeMessageUIComplete(bool bWasSuccessful)
{
    //return;    
}

function AddShowComposeMessageUICompleteDelegate(delegate<OnShowComposeMessageUIComplete> MessageDelegate)
{
    //return;    
}

function ClearShowComposeMessageUICompleteDelegate(delegate<OnShowComposeMessageUIComplete> MessageDelegate)
{
    //return;    
}

function bool ShowComposeMessageUI(byte LocalUserNum, optional array<UniqueNetId> People, optional string Text)
{
    //return ReturnValue;    
}

function bool ShowMessagesUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowAchievementsUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowInviteUI(byte LocalUserNum, optional string InviteText)
{
    //return ReturnValue;    
}

function bool ShowPeoplePickerUI(byte LocalUserNum, array<OnlineFriend> People, int MaxSelectable, optional string Text)
{
    //return ReturnValue;    
}

delegate OnPeoplePickerComplete(bool bWasSuccessful, array<OnlineFriend> PeoplePicked)
{
    //return;    
}

function AddPeoplePickerCompleteDelegate(byte LocalUserNum, delegate<OnPeoplePickerComplete> InDelegate)
{
    //return;    
}

function ClearPeoplePickerCompleteDelegate(byte LocalUserNum, delegate<OnPeoplePickerComplete> InDelegate)
{
    //return;    
}

function bool ShowDataSendingUI(byte LocalUserNum, string Message, string DataName, string DataDescription, array<byte> Data, int MaxSelectableUsers)
{
    //return ReturnValue;    
}

delegate OnAcceptReceivedData(string Data)
{
    //return;    
}

function AddAcceptReceivedDataDelegate(byte LocalUserNum, delegate<OnAcceptReceivedData> InDelegate)
{
    //return;    
}

function ClearAcceptReceivedDataDelegate(byte LocalUserNum, delegate<OnAcceptReceivedData> InDelegate)
{
    //return;    
}

function bool ShowProductDetailsUI(byte LocalUserNum, optional string ParentProductId)
{
    //return ReturnValue;    
}

function bool ShowContentMarketplaceUI(byte LocalUserNum, int ParentProductType, int RequestedProductTypes, optional string ParentProductId)
{
    //return ReturnValue;    
}

function bool ShowContentPurchaseUI(byte LocalUserNum, string Offer)
{
    //return ReturnValue;    
}

function bool ShowContentRedeemCodeUI(byte LocalUserNum, string Offer)
{
    //return ReturnValue;    
}

function CloseCurrentContentUI()
{
    //return;    
}

function bool ShowMembershipMarketplaceUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowDeviceSelectionUI(byte LocalUserNum, int SizeNeeded, optional bool bManageStorage)
{
    //return ReturnValue;    
}

delegate OnDeviceSelectionComplete(bool bWasSuccessful)
{
    //return;    
}

function AddDeviceSelectionDoneDelegate(byte LocalUserNum, delegate<OnDeviceSelectionComplete> DeviceDelegate)
{
    //return;    
}

function ClearDeviceSelectionDoneDelegate(byte LocalUserNum, delegate<OnDeviceSelectionComplete> DeviceDelegate)
{
    //return;    
}

function int GetDeviceSelectionResults(byte LocalUserNum, out string DeviceName)
{
    //return ReturnValue;    
}

function bool IsDeviceValid(int DeviceID, optional int SizeNeeded)
{
    //return ReturnValue;    
}

function bool UnlockGamerPicture(byte LocalUserNum, int PictureId)
{
    //return ReturnValue;    
}

delegate OnProfileDataChanged()
{
    //return;    
}

function AddProfileDataChangedDelegate(byte LocalUserNum, delegate<OnProfileDataChanged> ProfileDataChangedDelegate)
{
    //return;    
}

function ClearProfileDataChangedDelegate(byte LocalUserNum, delegate<OnProfileDataChanged> ProfileDataChangedDelegate)
{
    //return;    
}

function bool ShowFriendsInviteUI(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool ShowPlayersUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowCustomPlayersUI(byte LocalUserNum, const out array<UniqueNetId> Players, string Title, string Description)
{
    //return ReturnValue;    
}

function bool UnlockAvatarAward(byte LocalUserNum, int AvatarItemId)
{
    //return ReturnValue;    
}

function bool ReadCrossTitleProfileSettings(byte LocalUserNum, int TitleId, OnlineProfileSettings ProfileSettings)
{
    //return ReturnValue;    
}

delegate OnReadCrossTitleProfileSettingsComplete(byte LocalUserNum, int TitleId, bool bWasSuccessful)
{
    //return;    
}

function AddReadCrossTitleProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadCrossTitleProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
    //return;    
}

function ClearReadCrossTitleProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadCrossTitleProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
    //return;    
}

function OnlineProfileSettings GetCrossTitleProfileSettings(byte LocalUserNum, int TitleId)
{
    //return ReturnValue;    
}

function ClearCrossTitleProfileSettings(byte LocalUserNum, int TitleId)
{
    //return;    
}

function bool ShowCustomMessageUI(byte LocalUserNum, const out array<UniqueNetId> Recipients, string MessageTitle, string NonEditableMessage, optional string EditableMessage)
{
    //return ReturnValue;    
}

function bool ShowSystemErrorUI(int ErrorCode, string ErrorContext)
{
    //return ReturnValue;    
}

function bool ShowCustomErrorUI(int ErrorCode, string ErrorContext, string DialogTitle, string DialogContent)
{
    //return ReturnValue;    
}

function bool GetPlayerNicknameForPlayerId(UniqueNetId InPlayerId, out string OutPlayerNickname)
{
    //return ReturnValue;    
}

function bool GetPlayerIDForPlayerNickname(string InPlayerNickname, out UniqueNetId OutPlayerId)
{
    //return ReturnValue;    
}

function bool ReadOnlineProfilesForPlayers(array<string> PlayerIDs)
{
    //return ReturnValue;    
}

delegate OnReadOnlineProfilesComplete(bool bWasSuccessful, array<string> PlayerIDs, array<OnlineProfile> OnlineProfiles)
{
    //return;    
}

function AddReadOnlineProfilesCompleteDelegate(delegate<OnReadOnlineProfilesComplete> ReadOnlineProfileDelegate)
{
    //return;    
}

function ClearReadOnlineProfilesCompleteDelegate(delegate<OnReadOnlineProfilesComplete> ReadOnlineProfileDelegate)
{
    //return;    
}

delegate OnRegisterLocalTalkerComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddRegisterLocalTalkerCompleteDelegate(delegate<OnRegisterLocalTalkerComplete> RegisterLocalTalkerCompleteDelegate)
{
    //return;    
}

function ClearRegisterLocalTalkerCompleteDelegate(delegate<OnRegisterLocalTalkerComplete> RegisterLocalTalkerCompleteDelegate)
{
    //return;    
}

delegate OnUnregisterLocalTalkerComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddUnregisterLocalTalkerCompleteDelegate(delegate<OnUnregisterLocalTalkerComplete> UnregisterLocalTalkerCompleteDelegate)
{
    //return;    
}

function ClearUnregisterLocalTalkerCompleteDelegate(delegate<OnUnregisterLocalTalkerComplete> UnregisterLocalTalkerCompleteDelegate)
{
    //return;    
}

delegate OnUnregisterRemoteTalkerComplete(UniqueNetId RemoteNetId, bool bWasSuccessful)
{
    //return;    
}

function AddUnregisterRemoteTalkerCompleteDelegate(delegate<OnUnregisterRemoteTalkerComplete> UnregisterRemoteTalkerCompleteDelegate)
{
    //return;    
}

function ClearUnregisterRemoteTalkerCompleteDelegate(delegate<OnUnregisterRemoteTalkerComplete> UnregisterRemoteTalkerCompleteDelegate)
{
    //return;    
}

delegate OnRemoteTalkerStatusChange(UniqueNetId RemoteNetId, bool bIsTalking)
{
    //return;    
}

function AddPlayerTalkingDelegate(delegate<OnRemoteTalkerStatusChange> RemoteTalkerStatusChangeDelegate)
{
    //return;    
}

function ClearPlayerTalkingDelegate(delegate<OnRemoteTalkerStatusChange> RemoteTalkerStatusChangeDelegate)
{
    //return;    
}

function bool SendReputationFeedback(byte SenderLocalUserNum, UniqueNetId ReputeeNetId, OnlineSubsystem.EReputationFeedbackType FeedbackType, string ReportText)
{
    //return ReturnValue;    
}
