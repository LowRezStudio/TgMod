class MultiProviderAnalytics extends AnalyticEventsBase
    transient
    native(PlatformInterface)
    config(Engine);

var config array<config string> AnalyticsProviderClassNames;
var transient array<AnalyticEventsBase> AnalyticsProviders;

function Init()
{
    local string AnalyticsClassStr;
    local Class<AnalyticEventsBase> AnalyticsClass;
    local AnalyticEventsBase Analytics;

    // End:0xB3
    foreach AnalyticsProviderClassNames(AnalyticsClassStr)
    {
        AnalyticsClass = Class<AnalyticEventsBase>(DynamicLoadObject(AnalyticsClassStr, Class'Core.Class'));
        // End:0xB2
        if(AnalyticsClass != none)
        {
            Analytics = new AnalyticsClass;
            // End:0xB2
            if(Analytics != none)
            {
                Analytics.Init();
                AnalyticsProviders.AddItem(Analytics);
            }
        }        
    }    
    //return;    
}

// Export UMultiProviderAnalytics::execSetUserId(FFrame&, void* const)
native event SetUserId(string NewUserId);

// Export UMultiProviderAnalytics::execStartSession(FFrame&, void* const)
native event StartSession();

// Export UMultiProviderAnalytics::execEndSession(FFrame&, void* const)
native event EndSession();

// Export UMultiProviderAnalytics::execLogStringEvent(FFrame&, void* const)
native event LogStringEvent(string EventName, bool bTimed);

// Export UMultiProviderAnalytics::execEndStringEvent(FFrame&, void* const)
native event EndStringEvent(string EventName);

// Export UMultiProviderAnalytics::execLogStringEventParam(FFrame&, void* const)
native event LogStringEventParam(string EventName, string ParamName, string ParamValue, bool bTimed);

// Export UMultiProviderAnalytics::execEndStringEventParam(FFrame&, void* const)
native event EndStringEventParam(string EventName, string ParamName, string ParamValue);

// Export UMultiProviderAnalytics::execLogStringEventParamArray(FFrame&, void* const)
native event LogStringEventParamArray(string EventName, array<EventStringParam> ParamArray, bool bTimed);

// Export UMultiProviderAnalytics::execEndStringEventParamArray(FFrame&, void* const)
native event EndStringEventParamArray(string EventName, array<EventStringParam> ParamArray);

// Export UMultiProviderAnalytics::execLogErrorMessage(FFrame&, void* const)
native event LogErrorMessage(string ErrorName, string ErrorMessage);

// Export UMultiProviderAnalytics::execLogUserAttributeUpdate(FFrame&, void* const)
native event LogUserAttributeUpdate(string AttributeName, string AttributeValue);

// Export UMultiProviderAnalytics::execLogUserAttributeUpdateArray(FFrame&, void* const)
native event LogUserAttributeUpdateArray(array<EventStringParam> AttributeArray);

// Export UMultiProviderAnalytics::execLogItemPurchaseEvent(FFrame&, void* const)
native event LogItemPurchaseEvent(string ItemId, string Currency, int PerItemCost, int ItemQuantity);

// Export UMultiProviderAnalytics::execLogCurrencyPurchaseEvent(FFrame&, void* const)
native event LogCurrencyPurchaseEvent(string GameCurrencyType, int GameCurrencyAmount, string RealCurrencyType, float RealMoneyCost, string PaymentProvider);

// Export UMultiProviderAnalytics::execLogCurrencyGivenEvent(FFrame&, void* const)
native event LogCurrencyGivenEvent(string GameCurrencyType, int GameCurrencyAmount);

// Export UMultiProviderAnalytics::execSendCachedEvents(FFrame&, void* const)
native event SendCachedEvents();
