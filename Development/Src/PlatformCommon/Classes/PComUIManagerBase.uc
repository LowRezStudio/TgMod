class PComUIManagerBase extends Object
    abstract
    native
    config(Engine);

struct ManagerImage {
    var init string strImageName;
    var Texture2DDynamic pTexture;
    structdefaultproperties {}
};

var bool m_bDebugDraw;
var init array<init ManagerImage> m_cachedImages;
var init string m_strJson;

event DebugDraw(Canvas Canvas) { }
