class McpGroupsBase extends McpServiceBase
    abstract
    config(Engine);

enum EMcpGroupAcceptState
{
    MGAS_Error,                     // 0
    MGAS_Pending,                   // 1
    MGAS_Accepted,                  // 2
    MGAS_MAX                        // 3
};

enum EMcpGroupAccessLevel
{
    MGAL_Owner,                     // 0
    MGAL_Member,                    // 1
    MGAL_Public,                    // 2
    MGAL_MAX                        // 3
};

struct McpGroupMember
{
    var string MemberId;
    var McpGroupsBase.EMcpGroupAcceptState AcceptState;

    structdefaultproperties
    {
        MemberId=""
        AcceptState=EMcpGroupAcceptState.MGAS_Error
    }
};

struct McpGroup
{
    var string OwnerId;
    var string GroupID;
    var string GroupName;
    var McpGroupsBase.EMcpGroupAccessLevel AccessLevel;
    var array<McpGroupMember> Members;

    structdefaultproperties
    {
        OwnerId=""
        GroupID=""
        GroupName=""
        AccessLevel=EMcpGroupAccessLevel.MGAL_Owner
        Members=none
    }
};

struct McpGroupList
{
    var string RequesterId;
    var array<McpGroup> Groups;

    structdefaultproperties
    {
        RequesterId=""
        Groups=none
    }
};

var config string McpGroupsManagerClassName;
var array<McpGroupList> GroupLists;
//var delegate<OnCreateGroupComplete> __OnCreateGroupComplete__Delegate;
//var delegate<OnDeleteGroupComplete> __OnDeleteGroupComplete__Delegate;
//var delegate<OnQueryGroupsComplete> __OnQueryGroupsComplete__Delegate;
//var delegate<OnQueryGroupMembersComplete> __OnQueryGroupMembersComplete__Delegate;
//var delegate<OnAddGroupMembersComplete> __OnAddGroupMembersComplete__Delegate;
//var delegate<OnRemoveGroupMembersComplete> __OnRemoveGroupMembersComplete__Delegate;
//var delegate<OnDeleteAllGroupsComplete> __OnDeleteAllGroupsComplete__Delegate;
//var delegate<OnQueryGroupInvitesComplete> __OnQueryGroupInvitesComplete__Delegate;
//var delegate<OnAcceptGroupInviteComplete> __OnAcceptGroupInviteComplete__Delegate;

static final function McpGroupsBase CreateInstance()
{
    local Class<McpGroupsBase> McpGroupsManagerClass;
    local McpGroupsBase NewInstance;

    McpGroupsManagerClass = Class<McpGroupsBase>(DynamicLoadObject(default.McpGroupsManagerClassName, Class'Core.Class'));
    // End:0x76
    if(McpGroupsManagerClass != none)
    {
        NewInstance = new McpGroupsManagerClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function CreateGroup(string OwnerId, string GroupName)
{
    //return;    
}

delegate OnCreateGroupComplete(McpGroup Group, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteGroup(string UniqueUserId, string GroupID)
{
    //return;    
}

delegate OnDeleteGroupComplete(string GroupID, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryGroups(string RequesterId)
{
    //return;    
}

delegate OnQueryGroupsComplete(string UserId, bool bWasSuccessful, string Error)
{
    //return;    
}

function GetGroupList(string UserId, out McpGroupList GroupList)
{
    //return;    
}

function QueryGroupMembers(string UniqueUserId, string GroupID)
{
    //return;    
}

delegate OnQueryGroupMembersComplete(string GroupID, bool bWasSuccessful, string Error)
{
    //return;    
}

function GetGroupMembers(string GroupID, out array<McpGroupMember> GroupMembers)
{
    //return;    
}

function AddGroupMembers(string OwnerId, string GroupID, const out array<string> MemberIds, bool bRequiresAcceptance)
{
    //return;    
}

delegate OnAddGroupMembersComplete(string GroupID, bool bWasSuccessful, string Error)
{
    //return;    
}

function RemoveGroupMembers(string OwnerId, string GroupID, const out array<string> MemberIds)
{
    //return;    
}

delegate OnRemoveGroupMembersComplete(string GroupID, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteAllGroups(string OwnerId)
{
    //return;    
}

delegate OnDeleteAllGroupsComplete(string RequesterId, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryGroupInvites(string UniqueUserId)
{
    //return;    
}

delegate OnQueryGroupInvitesComplete(bool bWasSuccessful, string Error)
{
    //return;    
}

function GetGroupInviteList(string UserId, out McpGroupList InviteList)
{
    //return;    
}

function AcceptGroupInvite(string UniqueUserId, string GroupID, bool bShouldAccept)
{
    //return;    
}

delegate OnAcceptGroupInviteComplete(string GroupID, bool bWasSuccessful, string Error)
{
    //return;    
}

defaultproperties
{
    McpGroupsManagerClassName="IpDrv.McpGroupsManager"
}