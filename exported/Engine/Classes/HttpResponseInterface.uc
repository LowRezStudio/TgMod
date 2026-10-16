class HttpResponseInterface extends HttpBaseInterface
    abstract
    native;

// Export UHttpResponseInterface::execGetResponseCode(FFrame&, void* const)
native function int GetResponseCode();

// Export UHttpResponseInterface::execGetContentAsString(FFrame&, void* const)
native function string GetContentAsString();
