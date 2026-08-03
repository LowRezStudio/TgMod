class HttpFactory extends Object
    config(Engine);

var config string HttpRequestClassName;

static function HttpRequestInterface CreateRequest()
{
    local Class HttpRequestClass;
    local Object HttpReq;

    HttpRequestClass = Class<Object>(DynamicLoadObject(default.HttpRequestClassName, Class'Core.Class'));
    HttpReq = new HttpRequestClass;
    return HttpRequestInterface(HttpReq);
    //return ReturnValue;    
}

defaultproperties
{
    HttpRequestClassName="WinDrv.HttpRequestWindows"
}