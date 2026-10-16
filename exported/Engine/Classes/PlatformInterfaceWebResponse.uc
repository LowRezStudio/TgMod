class PlatformInterfaceWebResponse extends Object
    transient
    native(PlatformInterface);

var string OriginalURL;
var int ResponseCode;
var int Tag;
var native Map_Mirror Headers;
var string StringResponse;
var array<byte> BinaryResponse;

// Export UPlatformInterfaceWebResponse::execGetNumHeaders(FFrame&, void* const)
native function int GetNumHeaders();

// Export UPlatformInterfaceWebResponse::execGetHeader(FFrame&, void* const)
native function GetHeader(int HeaderIndex, out string Header, out string Value);

// Export UPlatformInterfaceWebResponse::execGetHeaderValue(FFrame&, void* const)
native function string GetHeaderValue(string HeaderName);
