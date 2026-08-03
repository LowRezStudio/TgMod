class McpClashMobBase extends McpServiceBase
    abstract
    config(Engine);

enum McpChallengeFileStatus
{
    MCFS_NotStarted,                // 0
    MCFS_Pending,                   // 1
    MCFS_Success,                   // 2
    MCFS_Failed,                    // 3
    MCFS_MAX                        // 4
};

struct McpClashMobChallengeFile
{
    var bool should_keep_post_challenge;
    var string title_id;
    var string file_name;
    var string dl_name;
    var string hash_code;
    var string Type;
    var McpClashMobBase.McpChallengeFileStatus Status;

    structdefaultproperties
    {
        should_keep_post_challenge=false
        title_id=""
        file_name=""
        dl_name=""
        hash_code=""
        Type=""
        Status=McpChallengeFileStatus.MCFS_NotStarted
    }
};

struct McpClashMobPushNotificationParams
{
    var int bah;

    structdefaultproperties
    {
        bah=0
    }
};

struct McpClashMobPushNotification
{
    var array<string> device_tokens;
    var string badge_type;
    var string Sound;
    var string Message;
    var McpClashMobPushNotificationParams Params;

    structdefaultproperties
    {
        device_tokens=none
        badge_type=""
        Sound=""
        Message=""
        Params=(bah=0)
    }
};

struct McpClashMobChallengeEvent
{
    var string unique_challenge_id;
    var string Description;
    var string visible_date;
    var string start_date;
    var string end_date;
    var string completed_date;
    var string purge_date;
    var int repeat_after_days;
    var int repeat_count;
    var string challenge_type;
    var int num_attempts;
    var int num_successful_attempts;
    var int goal_value;
    var int goal_start_value;
    var int goal_current_value;
    var bool has_started;
    var bool is_visible;
    var bool has_completed;
    var bool was_successful;
    var array<McpClashMobChallengeFile> file_list;
    var McpClashMobPushNotification start_notification;
    var McpClashMobPushNotification end_notification;
    var int facebook_likes;
    var string facebook_comments;
    var float facebook_like_scaler;
    var float facebook_comment_scaler;
    var int facebook_like_goal_progress;
    var int facebook_comment_goal_progress;
    var string facebook_id;
    var string facebook_post_message;
    var bool wants_facebook_posting;
    var int twitter_retweets;
    var float twitter_retweets_scaler;
    var int twitter_goal_progress;
    var string twitter_id;
    var string twitter_message;
    var bool wants_twitter_posting;

    structdefaultproperties
    {
        unique_challenge_id=""
        Description=""
        visible_date=""
        start_date=""
        end_date=""
        completed_date=""
        purge_date=""
        repeat_after_days=0
        repeat_count=0
        challenge_type=""
        num_attempts=0
        num_successful_attempts=0
        goal_value=0
        goal_start_value=0
        goal_current_value=0
        has_started=false
        is_visible=false
        has_completed=false
        was_successful=false
        file_list=none
        start_notification=(device_tokens=none,badge_type="",Sound="",Message="",Params=(bah=0))
        end_notification=(device_tokens=none,badge_type="",Sound="",Message="",Params=(bah=0))
        facebook_likes=0
        facebook_comments=""
        facebook_like_scaler=0.0000000
        facebook_comment_scaler=0.0000000
        facebook_like_goal_progress=0
        facebook_comment_goal_progress=0
        facebook_id=""
        facebook_post_message=""
        wants_facebook_posting=false
        twitter_retweets=0
        twitter_retweets_scaler=0.0000000
        twitter_goal_progress=0
        twitter_id=""
        twitter_message=""
        wants_twitter_posting=false
    }
};

struct McpClashMobChallengeUserStatus
{
    var string unique_challenge_id;
    var string unique_user_id;
    var int num_attempts;
    var int num_successful_attempts;
    var int goal_progress;
    var bool did_complete;
    var string last_update_time;
    var int user_award_given;
    var string accept_time;
    var bool did_preregister;
    var string facebook_like_time;
    var bool enrolled_via_facebook;
    var bool liked_via_facebook;
    var bool commented_via_facebook;
    var string twitter_retweet_time;
    var bool enrolled_via_twitter;
    var bool retweeted;

    structdefaultproperties
    {
        unique_challenge_id=""
        unique_user_id=""
        num_attempts=0
        num_successful_attempts=0
        goal_progress=0
        did_complete=false
        last_update_time=""
        user_award_given=0
        accept_time=""
        did_preregister=false
        facebook_like_time=""
        enrolled_via_facebook=false
        liked_via_facebook=false
        commented_via_facebook=false
        twitter_retweet_time=""
        enrolled_via_twitter=false
        retweeted=false
    }
};

var config string McpClashMobClassName;
//var delegate<OnQueryChallengeListComplete> __OnQueryChallengeListComplete__Delegate;
//var delegate<OnDownloadChallengeFileComplete> __OnDownloadChallengeFileComplete__Delegate;
//var delegate<OnAcceptChallengeComplete> __OnAcceptChallengeComplete__Delegate;
//var delegate<OnQueryChallengeUserStatusComplete> __OnQueryChallengeUserStatusComplete__Delegate;
//var delegate<OnUpdateChallengeUserProgressComplete> __OnUpdateChallengeUserProgressComplete__Delegate;
//var delegate<OnUpdateChallengeUserRewardComplete> __OnUpdateChallengeUserRewardComplete__Delegate;

static final function McpClashMobBase CreateInstance()
{
    local Class<McpClashMobBase> McpClashMobBaseClass;
    local McpClashMobBase NewInstance;

    McpClashMobBaseClass = Class<McpClashMobBase>(DynamicLoadObject(default.McpClashMobClassName, Class'Core.Class'));
    // End:0x76
    if(McpClashMobBaseClass != none)
    {
        NewInstance = new McpClashMobBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

delegate OnQueryChallengeListComplete(bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryChallengeList()
{
    //return;    
}

function GetChallengeList(out array<McpClashMobChallengeEvent> OutChallengeEvents)
{
    //return;    
}

delegate OnDownloadChallengeFileComplete(bool bWasSuccessful, string UniqueChallengeId, string DLName, string Filename, string Error)
{
    //return;    
}

function GetChallengeFileList(string UniqueChallengeId, out array<McpClashMobChallengeFile> OutChallengeFiles)
{
    //return;    
}

function DownloadChallengeFile(string UniqueChallengeId, string DLName)
{
    //return;    
}

function GetChallengeFileContents(string UniqueChallengeId, string DLName, out array<byte> OutFileContents)
{
    //return;    
}

function ClearCachedChallengeFile(string UniqueChallengeId, string DLName)
{
    //return;    
}

function DeleteCachedChallengeFile(string UniqueChallengeId, string DLName)
{
    //return;    
}

delegate OnAcceptChallengeComplete(bool bWasSuccessful, string UniqueChallengeId, string UniqueUserId, string Error)
{
    //return;    
}

function AcceptChallenge(string UniqueChallengeId, string UniqueUserId)
{
    //return;    
}

delegate OnQueryChallengeUserStatusComplete(bool bWasSuccessful, string UniqueChallengeId, string UniqueUserId, string Error)
{
    //return;    
}

function QueryChallengeUserStatus(string UniqueChallengeId, string UniqueUserId)
{
    //return;    
}

function QueryChallengeMultiUserStatus(string UniqueChallengeId, string UniqueUserId, const out array<string> UserIdsToRead)
{
    //return;    
}

function GetChallengeUserStatus(string UniqueChallengeId, string UniqueUserId, out McpClashMobChallengeUserStatus OutChallengeUserStatus)
{
    //return;    
}

delegate OnUpdateChallengeUserProgressComplete(bool bWasSuccessful, string UniqueChallengeId, string UniqueUserId, string Error)
{
    //return;    
}

function UpdateChallengeUserProgress(string UniqueChallengeId, string UniqueUserId, bool bDidComplete, int GoalProgress)
{
    //return;    
}

delegate OnUpdateChallengeUserRewardComplete(bool bWasSuccessful, string UniqueChallengeId, string UniqueUserId, string Error)
{
    //return;    
}

function UpdateChallengeUserReward(string UniqueChallengeId, string UniqueUserId, int UserReward)
{
    //return;    
}

defaultproperties
{
    McpClashMobClassName="IpDrv.McpClashMobManager"
}