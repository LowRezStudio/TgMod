// Parsed HTTP response. Headers/Body are always valid objects once a
// TmHttpRequest delivers this; bFailed+ErrorMessage describe transport or
// parse failures, in which case StatusCode is 0.
class TmHttpResponse extends Object;

var int StatusCode;         // 0 on failure
var string ReasonPhrase;
var string HttpVersion;     // "HTTP/1.1"
var TmHttpHeaders Headers;
var TmByteBuffer Body;
var int ContentLength;      // from Content-Length; -1 when absent
var bool bFinished;         // terminal: either finished or failed
var bool bFailed;
var string ErrorMessage;

function Reset() {
    StatusCode = 0;
    ReasonPhrase = "";
    HttpVersion = "";
    ContentLength = -1;
    bFinished = false;
    bFailed = false;
    ErrorMessage = "";
    if (Headers == none) {
        Headers = new class'TmHttpHeaders';
    }
    Headers.Reset();
    if (Body == none) {
        Body = new class'TmByteBuffer';
    }
    Body.Reset();
}

// Body as text via byte->Chr widening. Only meaningful for text bodies.
function string BodyText() {
    if (Body == none) {
        return "";
    }
    return Body.ToStringAt(0, Body.Length);
}

function bool Ok() {
    return bFinished && !bFailed && StatusCode >= 200 && StatusCode < 300;
}
