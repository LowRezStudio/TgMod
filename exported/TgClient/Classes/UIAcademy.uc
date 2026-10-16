class UIAcademy extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIACADEMY_BUTTONS = 8;
const UIACADEMY_VIDEOTYPE = 11427;

struct native AcademyVideoButton
{
    var string sImagePath;
    var string sVideoURL;
    var GFxObject pClip;
    var GFxObject pImage;
    var GFxObject pTitle;
    var GFxObject pSubtitle;

    structdefaultproperties
    {
        sImagePath=""
        sVideoURL=""
        pClip=none
        pImage=none
        pTitle=none
        pSubtitle=none
    }
};

var AcademyVideoButton m_Buttons[8];

defaultproperties
{
    m_Buttons[0]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[1]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[2]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[3]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[4]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[5]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[6]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_Buttons[7]=(sImagePath="Achievements.Achievements_I75",sVideoURL="",pClip=none,pImage=none,pTitle=none,pSubtitle=none)
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_bBlur=true
    m_Name="UIAcademy"
}