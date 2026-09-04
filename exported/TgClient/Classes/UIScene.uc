class UIScene extends UIComponent
    native(UIComponent);

struct native UIAnimData
{
    var byte eType;
    var byte eQuad;
    var float fOrig;
    var float fDelay;
    var float fTarget;
    var float fDuration;
    var float fTimeLeft;
    var GFxObject mcObject;

    structdefaultproperties
    {
        eType=0
        eQuad=0
        fOrig=0.0000000
        fDelay=0.0000000
        fTarget=0.0000000
        fDuration=0.0000000
        fTimeLeft=0.0000000
        mcObject=none
    }
};

var array<UIAnimData> m_AnimObjects;
var array<UIComponent_Interactable> m_Interactables;
var bool m_bUninitializing;

// Export UUIScene::execFadeIn(FFrame&, void* const)
native function FadeIn(GFxObject pObj, optional float fTime = 0.0500000, optional float fDelay = 0.0000000);

// Export UUIScene::execFadeOut(FFrame&, void* const)
native function FadeOut(GFxObject pObj, optional float fTime = 0.0500000, optional float fDelay = 0.0000000);

// Export UUIScene::execAnimate(FFrame&, void* const)
native function Animate(GFxObject pObj, float fTime, UIComponent.UIANIMTYPE eType, float fValue, optional float fDelay = 0.0000000, optional byte eQuad = 1, optional bool bEndCurrentAnim = true);

// Export UUIScene::execIsAnimating(FFrame&, void* const)
native function bool IsAnimating(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

// Export UUIScene::execGetAnimationTarget(FFrame&, void* const)
native function float GetAnimationTarget(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

// Export UUIScene::execEndAnim(FFrame&, void* const)
native function EndAnim(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

defaultproperties
{
    m_ComponentType=UICOMPONENTTYPE.UICOMP_SCENE
}