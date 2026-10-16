class UIScene extends UIComponent
    native(UIComponent)
    config(Engine);

struct UIAnimData {
    var byte eType;
    var byte eQuad;
    var float fOrig;
    var float fDelay;
    var float fTarget;
    var float fDuration;
    var float fTimeLeft;
    var GFxObject mcObject;
    structdefaultproperties {}
};

var array<UIAnimData> m_AnimObjects;
var array<UIComponent_Interactable> m_Interactables;
var bool m_bUninitializing;

native function FadeIn(GFxObject pObj, optional float fTime=0.0500000, optional float fDelay=0.0000000);  // Export UUIScene::execFadeIn(FFrame&, void* const)

native function FadeOut(GFxObject pObj, optional float fTime=0.0500000, optional float fDelay=0.0000000);  // Export UUIScene::execFadeOut(FFrame&, void* const)

native function Animate(GFxObject pObj, float fTime, UIComponent.UIANIMTYPE eType, float fValue, optional float fDelay=0.0000000, optional byte eQuad=1, optional bool bEndCurrentAnim=true);  // Export UUIScene::execAnimate(FFrame&, void* const)

native function bool IsAnimating(GFxObject pObj, optional UIComponent.UIANIMTYPE eType=9);  // Export UUIScene::execIsAnimating(FFrame&, void* const)

native function float GetAnimationTarget(GFxObject pObj, optional UIComponent.UIANIMTYPE eType=9);  // Export UUIScene::execGetAnimationTarget(FFrame&, void* const)

native function EndAnim(GFxObject pObj, optional UIComponent.UIANIMTYPE eType=9);  // Export UUIScene::execEndAnim(FFrame&, void* const)

defaultproperties
{
    m_ComponentType=UICOMP_SCENE
}
