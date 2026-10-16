interface UIDataStoreSubscriber extends Interface
    abstract
    native(UIPrivate);

// Export UUIDataStoreSubscriber::execSetDataStoreBinding(FFrame&, void* const)
native function SetDataStoreBinding(string MarkupText, optional int BindingIndex = -1);

// Export UUIDataStoreSubscriber::execGetDataStoreBinding(FFrame&, void* const)
native function string GetDataStoreBinding(optional int BindingIndex = -1);

// Export UUIDataStoreSubscriber::execRefreshSubscriberValue(FFrame&, void* const)
native function bool RefreshSubscriberValue(optional int BindingIndex = -1);

// Export UUIDataStoreSubscriber::execNotifyDataStoreValueUpdated(FFrame&, void* const)
native function NotifyDataStoreValueUpdated(UIDataStore SourceDataStore, bool bValuesInvalidated, name PropertyTag, UIDataProvider SourceProvider, int ArrayIndex);

// Export UUIDataStoreSubscriber::execGetBoundDataStores(FFrame&, void* const)
native function GetBoundDataStores(out array<UIDataStore> out_BoundDataStores);

// Export UUIDataStoreSubscriber::execClearBoundDataStores(FFrame&, void* const)
native function ClearBoundDataStores();
