class TwitterIntegrationBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

enum ETwitterRequestMethod
{
    TRM_Get,                        // 0
    TRM_Post,                       // 1
    TRM_Delete,                     // 2
    TRM_MAX                         // 3
};

enum ETwitterIntegrationDelegate
{
    TID_AuthorizeComplete,          // 0
    TID_TweetUIComplete,            // 1
    TID_RequestComplete,            // 2
    TID_MAX                         // 3
};

// Export UTwitterIntegrationBase::execInit(FFrame&, void* const)
native event Init();

// Export UTwitterIntegrationBase::execCanShowTweetUI(FFrame&, void* const)
native event bool CanShowTweetUI();

// Export UTwitterIntegrationBase::execShowTweetUI(FFrame&, void* const)
native event bool ShowTweetUI(optional string InitialMessage, optional string URL, optional string Picture);

// Export UTwitterIntegrationBase::execAuthorizeAccounts(FFrame&, void* const)
native event bool AuthorizeAccounts();

// Export UTwitterIntegrationBase::execGetNumAccounts(FFrame&, void* const)
native event int GetNumAccounts();

// Export UTwitterIntegrationBase::execGetAccountName(FFrame&, void* const)
native event string GetAccountName(int AccountIndex);

// Export UTwitterIntegrationBase::execGetAccountId(FFrame&, void* const)
native event string GetAccountId(int AccountIndex);

// Export UTwitterIntegrationBase::execTwitterRequest(FFrame&, void* const)
native event bool TwitterRequest(string URL, array<string> ParamKeysAndValues, TwitterIntegrationBase.ETwitterRequestMethod RequestMethod, int AccountIndex);
