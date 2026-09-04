interface OnlinePartyChatInterface extends Interface
    abstract;

function bool SendPartyGameInvites(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnSendPartyGameInvitesComplete(bool bWasSuccessful)
{
    //return;    
}

function AddSendPartyGameInvitesCompleteDelegate(byte LocalUserNum, delegate<OnSendPartyGameInvitesComplete> SendPartyGameInvitesCompleteDelegate)
{
    //return;    
}

function ClearSendPartyGameInvitesCompleteDelegate(byte LocalUserNum, delegate<OnSendPartyGameInvitesComplete> SendPartyGameInvitesCompleteDelegate)
{
    //return;    
}

function bool GetPartyMembersInformation(out array<OnlinePartyMember> PartyMembers)
{
    //return ReturnValue;    
}

function bool GetPartyMemberInformation(UniqueNetId MemberId, out OnlinePartyMember PartyMember)
{
    //return ReturnValue;    
}

delegate OnPartyMemberListChanged(bool bJoinedOrLeft, string PlayerName, UniqueNetId PlayerID)
{
    //return;    
}

function AddPartyMemberListChangedDelegate(byte LocalUserNum, delegate<OnPartyMemberListChanged> PartyMemberListChangedDelegate)
{
    //return;    
}

function ClearPartyMemberListChangedDelegate(byte LocalUserNum, delegate<OnPartyMemberListChanged> PartyMemberListChangedDelegate)
{
    //return;    
}

delegate OnReservedPartyMemberListChanged(bool bJoinedOrLeft, string PlayerName, UniqueNetId PlayerID)
{
    //return;    
}

function AddReservedPartyMemberListChangedDelegate(byte LocalUserNum, delegate<OnReservedPartyMemberListChanged> ReservedPartyMemberListChangedDelegate)
{
    //return;    
}

function ClearReservedPartyMemberListChangedDelegate(byte LocalUserNum, delegate<OnReservedPartyMemberListChanged> ReservedPartyMemberListChangedDelegate)
{
    //return;    
}

delegate OnPartyMembersInfoChanged(string PlayerName, UniqueNetId PlayerID, int CustomData1, int CustomData2, int CustomData3, int CustomData4)
{
    //return;    
}

function AddPartyMembersInfoChangedDelegate(byte LocalUserNum, delegate<OnPartyMembersInfoChanged> PartyMembersInfoChangedDelegate)
{
    //return;    
}

function ClearPartyMembersInfoChangedDelegate(byte LocalUserNum, delegate<OnPartyMembersInfoChanged> PartyMembersInfoChangedDelegate)
{
    //return;    
}

function bool SetPartyMemberCustomData(byte LocalUserNum, int Data1, int Data2, int Data3, int Data4)
{
    //return ReturnValue;    
}

function int GetPartyBandwidth()
{
    //return ReturnValue;    
}

function bool ShowPartyUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowVoiceChannelUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool ShowCommunitySessionsUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool IsInPartyChat(byte LocalUserNum)
{
    //return ReturnValue;    
}
