class PComUtilityFunctions extends Object
    native
    config(Engine);

native function Vector FakeNetSerialize(const out Vector InVector);  // Export UPComUtilityFunctions::execFakeNetSerialize(FFrame&, void* const)

native function bool IsAWithStop(Object InObject, const Class SomeBase, const Class StopAtBase);  // Export UPComUtilityFunctions::execIsAWithStop(FFrame&, void* const)

native function float GetGDeltaTime();  // Export UPComUtilityFunctions::execGetGDeltaTime(FFrame&, void* const)
