class OnlineEventTracker extends Object
    abstract
    native
    config(Engine);

event Init() { }

event ShutDown() { }

event bool RaiseEvent(const string EventName, const array<string> EventParams) { }
