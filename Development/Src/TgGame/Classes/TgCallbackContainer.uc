class TgCallbackContainer extends Object
    native(TgCallbacks)
    config(Engine);

struct FunctionWrapperInfo {
    var Pointer FunctionWrapper;
    var byte CallbackType;
    var TgCallbackContainer HandleOwner;
    structdefaultproperties {}
};

var private native const MultiMap_Mirror m_RegisteredCallbacks;
var private native const Map_Mirror m_RegisteredCallbacksByHandle;
var private native const Map_Mirror m_CallbackHandles;
