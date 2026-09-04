class MultiFont extends Font
    native
    hidecategories(Object);

var() editinline array<editinline float> ResolutionTestTable;

// Export UMultiFont::execGetResolutionTestTableIndex(FFrame&, void* const)
native function int GetResolutionTestTableIndex(float HeightTest);
