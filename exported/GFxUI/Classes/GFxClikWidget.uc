class GFxClikWidget extends GFxObject within GFxMoviePlayer;

struct EventData
{
    var GFxObject _this;
    var GFxObject Target;
    var string Type;
    var int Data;
    var int mouseIndex;
    var int Button;
    var int Index;
    var int lastIndex;

    structdefaultproperties
    {
        _this=none
        Target=none
        Type=""
        Data=0
        mouseIndex=0
        Button=0
        Index=0
        lastIndex=0
    }
};

//var delegate<EventListener> __EventListener__Delegate;

delegate EventListener(EventData Data)
{
    //return;    
}

function AddEventListener(name Type, delegate<EventListener> Listener, optional bool useCapture = false, optional int listenerPriority = 0, optional bool useWeakReference = false)
{
    local GFxObject O, funcobj;
    local string TypeString;

    TypeString = GetEventStringFromTypename(Type);
    // End:0x14E
    if(TypeString != "")
    {
        O = Outer.CreateObject("Object");
        SetListener(O, TypeString, Listener);
        // End:0x129
        if(Outer.GetAVMVersion() == 2)
        {
            funcobj = O.GetObject(TypeString);
            AS3AddEventListener(TypeString, funcobj, useCapture, listenerPriority, useWeakReference);            
        }
        else
        {
            ASAddEventListener(TypeString, O, TypeString);
        }
    }
    //return;    
}

function RemoveAllEventListeners(string Event)
{
    ASRemoveAllEventListeners(Event);
    //return;    
}

private final function string GetEventStringFromTypename(name Typename)
{
    local string TypeString;

    TypeString = string(Typename);
    // End:0x4F
    if(InStr(TypeString, "CLIK_") >= 0)
    {
        return Split(TypeString, "CLIK_", true);        
    }
    else
    {
        return "";
    }
    //return ReturnValue;    
}

private final function SetListener(GFxObject O, string Member, delegate<EventListener> Listener)
{
    ActionScriptSetFunctionOn(O, Member);
    //return;    
}

private final function ASAddEventListener(string Type, GFxObject O, string func)
{
    ActionScriptVoid("addEventListener");
    //return;    
}

private final function AS3AddEventListener(string Type, GFxObject O, optional bool useCapture = false, optional int listenerPriority = 0, optional bool useWeakReference = true)
{
    ActionScriptVoid("addEventListener");
    //return;    
}

private final function ASRemoveAllEventListeners(string Event)
{
    ActionScriptVoid("removeAllEventListeners");
    //return;    
}
