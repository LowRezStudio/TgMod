class AnalyticEventsBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface)
    config(Engine);

struct native EventStringParam
{
    var string ParamName;
    var string ParamValue;

    structdefaultproperties
    {
        ParamName=""
        ParamValue=""
    }
};

var const bool bSessionInProgress;
var config bool bAutoStartSession;
var config int SessionPauseThresholdSec;
var const string UserId;

function bool IsSessionInProgress()
{
    return bSessionInProgress;
    //return ReturnValue;    
}

// Export UAnalyticEventsBase::execInit(FFrame&, void* const)
native event Init();

// Export UAnalyticEventsBase::execSetUserId(FFrame&, void* const)
native event SetUserId(string NewUserId);

// Export UAnalyticEventsBase::execStartSession(FFrame&, void* const)
native event StartSession();

// Export UAnalyticEventsBase::execEndSession(FFrame&, void* const)
native event EndSession();

// Export UAnalyticEventsBase::execLogStringEvent(FFrame&, void* const)
native event LogStringEvent(string EventName, bool bTimed);

// Export UAnalyticEventsBase::execEndStringEvent(FFrame&, void* const)
native event EndStringEvent(string EventName);

// Export UAnalyticEventsBase::execLogStringEventParam(FFrame&, void* const)
native event LogStringEventParam(string EventName, string ParamName, string ParamValue, bool bTimed);

// Export UAnalyticEventsBase::execEndStringEventParam(FFrame&, void* const)
native event EndStringEventParam(string EventName, string ParamName, string ParamValue);

// Export UAnalyticEventsBase::execLogStringEventParamArray(FFrame&, void* const)
native event LogStringEventParamArray(string EventName, array<EventStringParam> ParamArray, bool bTimed);

// Export UAnalyticEventsBase::execEndStringEventParamArray(FFrame&, void* const)
native event EndStringEventParamArray(string EventName, array<EventStringParam> ParamArray);

// Export UAnalyticEventsBase::execLogErrorMessage(FFrame&, void* const)
native event LogErrorMessage(string ErrorName, string ErrorMessage);

// Export UAnalyticEventsBase::execLogUserAttributeUpdate(FFrame&, void* const)
native event LogUserAttributeUpdate(string AttributeName, string AttributeValue);

// Export UAnalyticEventsBase::execLogUserAttributeUpdateArray(FFrame&, void* const)
native event LogUserAttributeUpdateArray(array<EventStringParam> AttributeArray);

// Export UAnalyticEventsBase::execLogItemPurchaseEvent(FFrame&, void* const)
native event LogItemPurchaseEvent(string ItemId, string Currency, int PerItemCost, int ItemQuantity);

// Export UAnalyticEventsBase::execLogCurrencyPurchaseEvent(FFrame&, void* const)
native event LogCurrencyPurchaseEvent(string GameCurrencyType, int GameCurrencyAmount, string RealCurrencyType, float RealMoneyCost, string PaymentProvider);

// Export UAnalyticEventsBase::execLogCurrencyGivenEvent(FFrame&, void* const)
native event LogCurrencyGivenEvent(string GameCurrencyType, int GameCurrencyAmount);

// Export UAnalyticEventsBase::execSendCachedEvents(FFrame&, void* const)
native event SendCachedEvents();
