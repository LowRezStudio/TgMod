class TgClientHUD extends TgHUD
    transient
    native
    config(Game)
    hidecategories(Navigation);

struct native SceneInfo
{
    var int nDepth;
    var init string sName;
    var init string sPath;

    structdefaultproperties
    {
        nDepth=0
        sName=""
        sPath=""
    }
};

var array<SceneInfo> m_ScenePreloads;