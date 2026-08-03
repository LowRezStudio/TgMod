class AppNotificationsBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

struct native NotificationMessageInfo
{
    var string Key;
    var string Value;

    structdefaultproperties
    {
        Key=""
        Value=""
    }
};

struct native NotificationInfo
{
    var bool bIsLocal;
    var string MessageBody;
    var int BadgeNumber;
    var array<NotificationMessageInfo> MessageInfo;

    structdefaultproperties
    {
        bIsLocal=false
        MessageBody=""
        BadgeNumber=0
        MessageInfo=none
    }
};

struct native LaunchNotificationInfo
{
    var bool bWasLaunchedViaNotification;
    var NotificationInfo Notification;

    structdefaultproperties
    {
        bWasLaunchedViaNotification=false
        Notification=(bIsLocal=false,MessageBody="",BadgeNumber=0,MessageInfo=none)
    }
};

var const LaunchNotificationInfo AppLaunchNotification;
//var delegate<OnReceivedLocalNotification> __OnReceivedLocalNotification__Delegate;
//var delegate<OnReceivedRemoteNotification> __OnReceivedRemoteNotification__Delegate;

// Export UAppNotificationsBase::execInit(FFrame&, void* const)
native event Init();

function bool WasLaunchedViaNotification()
{
    return AppLaunchNotification.bWasLaunchedViaNotification;
    //return ReturnValue;    
}

// Export UAppNotificationsBase::execScheduleLocalNotification(FFrame&, void* const)
native function ScheduleLocalNotification(const out NotificationInfo Notification, int StartOffsetSeconds);

// Export UAppNotificationsBase::execCancelAllScheduledLocalNotifications(FFrame&, void* const)
native function CancelAllScheduledLocalNotifications();

delegate OnReceivedLocalNotification(const out NotificationInfo Notification, bool bWasAppActive)
{
    //return;    
}

delegate OnReceivedRemoteNotification(const out NotificationInfo Notification, bool bWasAppActive)
{
    //return;    
}

function DebugLogNotification(const out NotificationInfo Notification)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x44 [Loop If]
    if(Idx < Notification.MessageInfo.Length)
    {
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}
