class UIDataStore_GameState extends UIDataStore
    abstract
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

//var delegate<OnRefreshDataFieldValue> __OnRefreshDataFieldValue__Delegate;

delegate OnRefreshDataFieldValue()
{
    //return;    
}

function bool NotifyGameSessionEnded()
{
    return true;
    //return ReturnValue;    
}
