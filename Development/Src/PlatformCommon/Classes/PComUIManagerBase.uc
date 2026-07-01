class PComUIManagerBase extends Object
    abstract
    native;

struct native ManagerImage
{
    var init string strImageName;
    var Texture2DDynamic pTexture;

    structdefaultproperties
    {
        strImageName=""
        pTexture=none
    }
};

var bool m_bDebugDraw;
var bool m_bLocalLoad;
var init array<init ManagerImage> m_cachedImages;
var init string m_strJson;

event DebugDraw(Canvas Canvas)
{
    //return;    
}
