class PComUtilityFunctions extends Object
    native;

// Export UPComUtilityFunctions::execFakeNetSerialize(FFrame&, void* const)
native static function Vector FakeNetSerialize(const out Vector InVector);

// Export UPComUtilityFunctions::execIsAWithStop(FFrame&, void* const)
native static function bool IsAWithStop(Object InObject, const Class SomeBase, const Class StopAtBase);

// Export UPComUtilityFunctions::execGetGDeltaTime(FFrame&, void* const)
native static function float GetGDeltaTime();
