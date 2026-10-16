class TgGFxGroup extends Object
    native
    config(Engine);

const GFXGROUP_LOC_NONE = -10000;

struct UIGroupObject {
    var int nLocX;
    var int nLocY;
    var int nWidth;
    var int nHeight;
    var TgGFxGroup pGroup;
    var GFxObject pObj;
    var GFxObject pCursorHoverObj;
    structdefaultproperties {}
};

var int m_nMinX;
var int m_nMinY;
var int m_nSizeX;
var int m_nSizeY;
var int m_nFocusX;
var int m_nFocusY;
var int m_nPrevFocusX;
var int m_nPrevFocusY;
var bool m_bLoopX;
var bool m_bLoopY;
var bool m_bCursorUpdateX;
var bool m_bCursorUpdateY;
var bool m_bCursorUpdateWidth;
var bool m_bCursorUpdateHeight;
var bool m_bAllowSelect;
var bool m_bAllowNavigation;
var int m_nDefaultXFocus;
var int m_nDefaultYFocus;
var TgGfxScene m_pScene;
var array<UIGroupObject> m_Objects;
var GFxObject m_mcCursor;

defaultproperties
{
    m_bCursorUpdateX=true
    m_bCursorUpdateY=true
    m_bAllowSelect=true
    m_bAllowNavigation=true
}
