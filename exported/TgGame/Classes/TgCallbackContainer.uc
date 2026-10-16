class TgCallbackContainer extends Object
    native(TgCallbacks);

struct native FunctionWrapperInfo
{
    var native Pointer FunctionWrapper;
    var byte CallbackType;
    var TgCallbackContainer HandleOwner;

    structdefaultproperties
    {
        CallbackType=0
        HandleOwner=none
    }
};

var private native const MultiMap_Mirror m_RegisteredCallbacks;
var private native const Map_Mirror m_RegisteredCallbacksByHandle;
var private native const Map_Mirror m_CallbackHandles;
