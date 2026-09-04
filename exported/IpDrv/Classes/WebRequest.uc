class WebRequest extends Object
    native;

enum ERequestType
{
    Request_GET,                    // 0
    Request_POST,                   // 1
    Request_MAX                     // 2
};

var string RemoteAddr;
var string URI;
var string UserName;
var string Password;
var int ContentLength;
var string ContentType;
var WebRequest.ERequestType RequestType;
var private native const Map_Mirror HeaderMap;
var private native const Map_Mirror VariableMap;

// Export UWebRequest::execDecodeBase64(FFrame&, void* const)
native final function string DecodeBase64(string Encoded);

// Export UWebRequest::execEncodeBase64(FFrame&, void* const)
native final function string EncodeBase64(string Decoded);

// Export UWebRequest::execAddHeader(FFrame&, void* const)
native final function AddHeader(string HeaderName, coerce string Value);

// Export UWebRequest::execGetHeader(FFrame&, void* const)
native final function string GetHeader(string HeaderName, optional string DefaultValue);

// Export UWebRequest::execGetHeaders(FFrame&, void* const)
native final function GetHeaders(out array<string> Headers);

// Export UWebRequest::execAddVariable(FFrame&, void* const)
native final function AddVariable(string VariableName, coerce string Value);

// Export UWebRequest::execGetVariable(FFrame&, void* const)
native final function string GetVariable(string VariableName, optional string DefaultValue);

// Export UWebRequest::execGetVariableCount(FFrame&, void* const)
native final function int GetVariableCount(string VariableName);

// Export UWebRequest::execGetVariableNumber(FFrame&, void* const)
native final function string GetVariableNumber(string VariableName, int Number, optional string DefaultValue);

// Export UWebRequest::execGetVariables(FFrame&, void* const)
native final function GetVariables(out array<string> varNames);

// Export UWebRequest::execDump(FFrame&, void* const)
native final function Dump();

function ProcessHeaderString(string S)
{
    local int I;

    // End:0xBC
    if(Left(S, 21) ~= "Authorization: Basic ")
    {
        S = DecodeBase64(Mid(S, 21));
        I = InStr(S, ":");
        // End:0xB9
        if(I != -1)
        {
            UserName = Left(S, I);
            Password = Mid(S, I + 1);
        }        
    }
    else
    {
        // End:0xFE
        if(Left(S, 16) ~= "Content-Length: ")
        {
            ContentLength = int(Mid(S, 16, 64));            
        }
        else
        {
            // End:0x138
            if(Left(S, 14) ~= "Content-Type: ")
            {
                ContentType = Mid(S, 14);
            }
        }
    }
    I = InStr(S, ":");
    // End:0x19D
    if(I > -1)
    {
        AddHeader(Left(S, I), Mid(S, I + 2));
    }
    //return;    
}

function DecodeFormData(string Data, optional int MaxValueLength = -1, optional int MaxLineLength = -1)
{
    local string Token[2], ch;
    local int I, H1, H2, Limit, T;

    // End:0x4D
    if(MaxValueLength == -1)
    {
        MaxValueLength = Class'IpDrv.WebConnection'.default.MaxValueLength;
    }
    // End:0x88
    if(MaxLineLength == -1)
    {
        MaxLineLength = Class'IpDrv.WebConnection'.default.MaxLineLength;
    }
    T = 0;
    I = 0;
    J0x9E:

    // End:0x33E [Loop If]
    if(I < Len(Data))
    {
        // End:0xEA
        if((Limit > MaxValueLength) || I > MaxLineLength)
        {
            // [Explicit Break]
            goto J0x33E;
        }
        ch = Mid(Data, I, 1);
        switch(ch)
        {
            // End:0x152
            case "+":                
                Token[T] $= " ";
                Limit++;
                // End:0x330
                break;
            // End:0x158
            case "&":
            // End:0x1C5
            case "?":
                // End:0x190
                if(Token[0] != "")
                {
                    AddVariable(Token[0], Token[1]);
                }
                Token[0] = "";
                Token[1] = "";
                T = 0;
                Limit = 0;
                // End:0x330
                break;
            // End:0x21B
            case "=":
                // End:0x1F3
                if(T == 0)
                {
                    Limit = 0;
                    T = 1;                    
                }
                else
                {                    
                    Token[1] $= "=";
                    Limit++;
                }
                // End:0x330
                break;
            // End:0x2FA
            case "%":
                H1 = GetHexDigit(Mid(Data, ++I, 1));
                // End:0x2EC
                if(H1 != -1)
                {
                    Limit++;
                    H1 *= float(16);
                    H2 = GetHexDigit(Mid(Data, ++I, 1));
                    // End:0x2EC
                    if(H2 != -1)
                    {                        
                        Token[T] $= Chr(H1 + H2);
                    }
                }
                Limit++;
                // End:0x330
                break;
            // End:0xFFFF
            default:                
                Token[T] $= ch;
                Limit++;
                break;
        }
        I++;
        // [Loop Continue]
        goto J0x9E;
    }
    J0x33E:

    // End:0x370
    if(Token[0] != "")
    {
        AddVariable(Token[0], Token[1]);
    }
    //return;    
}

function int GetHexDigit(string D)
{
    switch(Caps(D))
    {
        // End:0x1D
        case "0":
            return 0;
        // End:0x25
        case "1":
            return 1;
        // End:0x2E
        case "2":
            return 2;
        // End:0x37
        case "3":
            return 3;
        // End:0x40
        case "4":
            return 4;
        // End:0x49
        case "5":
            return 5;
        // End:0x52
        case "6":
            return 6;
        // End:0x5B
        case "7":
            return 7;
        // End:0x64
        case "8":
            return 8;
        // End:0x6D
        case "9":
            return 9;
        // End:0x76
        case "A":
            return 10;
        // End:0x7F
        case "B":
            return 11;
        // End:0x88
        case "C":
            return 12;
        // End:0x91
        case "D":
            return 13;
        // End:0x9A
        case "E":
            return 14;
        // End:0xA3
        case "F":
            return 15;
        // End:0xFFFF
        default:
            return -1;
            break;
    }
    //return ReturnValue;    
}
