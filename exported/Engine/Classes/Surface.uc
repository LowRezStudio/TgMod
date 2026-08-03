class Surface extends Object
    abstract
    native;

// Export USurface::execGetSurfaceWidth(FFrame&, void* const)
native final function float GetSurfaceWidth();

// Export USurface::execGetSurfaceHeight(FFrame&, void* const)
native final function float GetSurfaceHeight();
