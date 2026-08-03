class HttpBaseInterface extends Object
    abstract
    native;

// Export UHttpBaseInterface::execGetHeader(FFrame&, void* const)
native function string GetHeader(string HeaderName);

// Export UHttpBaseInterface::execGetHeaders(FFrame&, void* const)
native function array<string> GetHeaders();

// Export UHttpBaseInterface::execGetURLParameter(FFrame&, void* const)
native function string GetURLParameter(string ParameterName);

// Export UHttpBaseInterface::execGetContentType(FFrame&, void* const)
native function string GetContentType();

// Export UHttpBaseInterface::execGetContentLength(FFrame&, void* const)
native function int GetContentLength();

// Export UHttpBaseInterface::execGetURL(FFrame&, void* const)
native function string GetURL();

// Export UHttpBaseInterface::execGetContent(FFrame&, void* const)
native function GetContent(out array<byte> Content);
