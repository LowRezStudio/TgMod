class JsonObject extends Object
    native;

var native Map_Mirror ValueMap;
var native Map_Mirror ObjectMap;
var native array<string> ValueArray;
var native array<JsonObject> ObjectArray;

// Export UJsonObject::execGetObject(FFrame&, void* const)
native function JsonObject GetObject(const string Key);

// Export UJsonObject::execGetStringValue(FFrame&, void* const)
native function string GetStringValue(const string Key);

// Export UJsonObject::execHasKey(FFrame&, void* const)
native function bool HasKey(const string Key);

function int GetIntValue(const string Key)
{
    local string Value;

    Value = Mid(GetStringValue(Key), 2);
    return int(Value);
    //return ReturnValue;    
}

function float GetFloatValue(const string Key)
{
    local string Value;

    Value = Mid(GetStringValue(Key), 2);
    return float(Value);
    //return ReturnValue;    
}

function bool GetBoolValue(const string Key)
{
    local string Value;

    Value = Mid(GetStringValue(Key), 2);
    return bool(Value);
    //return ReturnValue;    
}

// Export UJsonObject::execSetObject(FFrame&, void* const)
native function SetObject(const string Key, JsonObject Object);

// Export UJsonObject::execSetStringValue(FFrame&, void* const)
native function SetStringValue(const string Key, const string Value);

function SetIntValue(const string Key, int Value)
{
    SetStringValue(Key, "\\#" $ string(Value));
    //return;    
}

function SetFloatValue(const string Key, float Value)
{
    SetStringValue(Key, "\\#" $ string(Value));
    //return;    
}

function SetBoolValue(const string Key, bool Value)
{
    SetStringValue(Key, "\\#" $ ((Value) ? "true" : "false"));
    //return;    
}

// Export UJsonObject::execEncodeJson(FFrame&, void* const)
native static function string EncodeJson(JsonObject Root);

// Export UJsonObject::execDecodeJson(FFrame&, void* const)
native static function JsonObject DecodeJson(const string Str);
