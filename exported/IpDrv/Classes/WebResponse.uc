class WebResponse extends Object
    native
    config(Web);

var array<string> Headers;
var private native const Map_Mirror ReplacementMap;
var const config string IncludePath;
var const localized string CharSet;
var WebConnection Connection;
var protected bool bSentText;
var protected bool bSentResponse;

// Export UWebResponse::execFileExists(FFrame&, void* const)
native final function bool FileExists(string Filename);

// Export UWebResponse::execSubst(FFrame&, void* const)
native final function Subst(string Variable, coerce string Value, optional bool bClear);

// Export UWebResponse::execClearSubst(FFrame&, void* const)
native final function ClearSubst();

// Export UWebResponse::execIncludeUHTM(FFrame&, void* const)
native final function bool IncludeUHTM(string Filename);

// Export UWebResponse::execIncludeBinaryFile(FFrame&, void* const)
native final function bool IncludeBinaryFile(string Filename);

// Export UWebResponse::execLoadParsedUHTM(FFrame&, void* const)
native final function string LoadParsedUHTM(string Filename);

// Export UWebResponse::execGetHTTPExpiration(FFrame&, void* const)
native final function string GetHTTPExpiration(optional int OffsetSeconds);

// Export UWebResponse::execDump(FFrame&, void* const)
native final function Dump();

event SendText(string Text, optional bool bNoCRLF)
{
    // End:0x28
    if(!bSentText)
    {
        SendStandardHeaders();
        bSentText = true;
    }
    // End:0x60
    if(bNoCRLF)
    {
        Connection.SendText(Text);        
    }
    else
    {
        Connection.SendText((Text $ Chr(13)) $ Chr(10));
    }
    //return;    
}

event SendBinary(int Count, byte B[255])
{
    Connection.SendBinary(Count, B);
    //return;    
}

function bool SendCachedFile(string Filename, optional string ContentType)
{
    // End:0x30
    if(!bSentText)
    {
        SendStandardHeaders(ContentType, true);
        bSentText = true;
    }
    return IncludeUHTM(Filename);
    //return ReturnValue;    
}

function FailAuthentication(string Realm)
{
    HTTPError(401, Realm);
    //return;    
}

function HttpResponse(string Header)
{
    bSentResponse = true;
    HTTPHeader(Header);
    //return;    
}

function HTTPHeader(string Header)
{
    // End:0x10
    if(bSentText)
    {        
    }
    else
    {
        // End:0x3A
        if(!bSentResponse)
        {
            HttpResponse("HTTP/1.1 200 Ok");
        }
        // End:0x57
        if(Len(Header) == 0)
        {
            bSentText = true;
        }
        Connection.SendText((Header $ Chr(13)) $ Chr(10));
    }
    //return;    
}

function AddHeader(string Header, optional bool bReplace = true)
{
    local int I, Idx;
    local string Part, Entry;

    I = InStr(Header, ":");
    // End:0x59
    if(I > -1)
    {
        Part = Caps(Left(Header, I + 1));        
    }
    else
    {
        return;
    }
    // End:0x100
    foreach Headers(Entry, Idx)
    {
        // End:0xFF
        if(InStr(Caps(Entry), Part) > -1)
        {
            // End:0xFC
            if(bReplace)
            {
                // End:0xDF
                if((I + 2) >= Len(Header))
                {
                    Headers.Remove(Idx, 1);                    
                }
                else
                {
                    Headers[Idx] = Header;
                }
            }            
            return;
        }        
    }    
    // End:0x134
    if(Len(Header) > (I + 2))
    {
        Headers.AddItem(Header);
    }
    //return;    
}

function SendHeaders()
{
    local string hdr;

    // End:0x2B
    foreach Headers(hdr)
    {
        HTTPHeader(hdr);        
    }    
    //return;    
}

function HTTPError(int ErrorNum, optional string Data)
{
    switch(ErrorNum)
    {
        // End:0x112
        case 400:
            HttpResponse("HTTP/1.1 400 Bad Request");
            SendText("<HTML><HEAD><TITLE>400 Bad Request</TITLE></HEAD><BODY><H1>400 Bad Request</H1>If you got this error from a standard web browser, please mail epicgames.com and submit a bug report.</BODY></HTML>");
            // End:0x2B1
            break;
        // End:0x1EA
        case 401:
            HttpResponse("HTTP/1.1 401 Unauthorized");
            AddHeader(("WWW-authenticate: basic realm=\"" $ Data) $ "\"");
            SendText("<HTML><HEAD><TITLE>401 Unauthorized</TITLE></HEAD><BODY><H1>401 Unauthorized</H1></BODY></HTML>");
            // End:0x2B1
            break;
        // End:0x2AB
        case 404:
            HttpResponse("HTTP/1.1 404 Not Found");
            SendText("<HTML><HEAD><TITLE>404 File Not Found</TITLE></HEAD><BODY><H1>404 File Not Found</H1>The URL you requested was not found.</BODY></HTML>");
            // End:0x2B1
            break;
        // End:0xFFFF
        default:
            // End:0x2B1
            break;
            break;
    }
    //return;    
}

function SendStandardHeaders(optional string ContentType, optional bool bCache)
{
    // End:0x27
    if(ContentType == "")
    {
        ContentType = "text/html";
    }
    // End:0x51
    if(!bSentResponse)
    {
        HttpResponse("HTTP/1.1 200 OK");
    }
    AddHeader("Server: UnrealEngine IpDrv Web Server Build " $ Connection.WorldInfo.EngineVersion, false);
    AddHeader("Content-Type: " $ ContentType, false);
    // End:0x1A2
    if(bCache)
    {
        AddHeader("Cache-Control: max-age=" $ string(Connection.WebServer.ExpirationSeconds), false);
        AddHeader("Expires: " $ GetHTTPExpiration(Connection.WebServer.ExpirationSeconds), false);
    }
    AddHeader("Connection: Close");
    SendHeaders();
    HTTPHeader("");
    //return;    
}

function Redirect(string URL)
{
    HttpResponse("HTTP/1.1 302 Document Moved");
    AddHeader("Location: " $ URL);
    SendText("<html><head><title>Document Moved</title></head>");
    SendText(("<body><h1>Object Moved</h1>This document may be found <a HREF=\"" $ URL) $ "\">here</a>.</body></html>");
    //return;    
}

function bool SentText()
{
    return bSentText;
    //return ReturnValue;    
}

function bool SentResponse()
{
    return bSentResponse;
    //return ReturnValue;    
}
