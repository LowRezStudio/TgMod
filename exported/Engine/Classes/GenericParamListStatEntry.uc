class GenericParamListStatEntry extends Object
    native;

var native transient Pointer StatEvent;
var protected transient GameplayEventsWriter Writer;

// Export UGenericParamListStatEntry::execAddFloat(FFrame&, void* const)
native function AddFloat(name ParamName, float Value);

// Export UGenericParamListStatEntry::execAddInt(FFrame&, void* const)
native function AddInt(name ParamName, int Value);

// Export UGenericParamListStatEntry::execAddVector(FFrame&, void* const)
native function AddVector(name ParamName, Vector Value);

// Export UGenericParamListStatEntry::execAddString(FFrame&, void* const)
native function AddString(name ParamName, coerce string Value);

// Export UGenericParamListStatEntry::execGetFloat(FFrame&, void* const)
native function bool GetFloat(name ParamName, out float out_Float);

// Export UGenericParamListStatEntry::execGetInt(FFrame&, void* const)
native function bool GetInt(name ParamName, out int out_int);

// Export UGenericParamListStatEntry::execGetVector(FFrame&, void* const)
native function bool GetVector(name ParamName, out Vector out_vector);

// Export UGenericParamListStatEntry::execGetString(FFrame&, void* const)
native function bool GetString(name ParamName, out string out_string);

// Export UGenericParamListStatEntry::execCommitToDisk(FFrame&, void* const)
native function CommitToDisk();
