class UIComponent extends Object
    abstract
    native(UIComponent)
    implements(TgCallbackInterface);

enum UIANIMTYPE
{
    UIANIM_X,                       // 0
    UIANIM_Y,                       // 1
    UIANIM_ALPHA,                   // 2
    UIANIM_WIDTH,                   // 3
    UIANIM_HEIGHT,                  // 4
    UIANIM_XSCALE,                  // 5
    UIANIM_YSCALE,                  // 6
    UIANIM_VISIBLE,                 // 7
    UIANIM_ROTATION,                // 8
    UIANIM_MAX                      // 9
};

enum UICOMPONENTTYPE
{
    UICOMP_COMPONENT,               // 0
    UICOMP_SCENE,                   // 1
    UICOMP_MAX                      // 2
};

var private native const noexport Pointer VfTable_ITgCallbackInterface;
var UIComponent.UICOMPONENTTYPE m_ComponentType;
var UIComponent m_Owner;
var GFxObject m_mcRoot;
var string m_sLoadName;
var int m_nLoadIndex;
var string m_sConstructName;
var protected bool m_bConstructed;
var int m_nDeferredUpdateCallbackHandle;
var const array<UIComponent> m_Components;
var native const MultiMap_Mirror m_ComponentMap;
var TgCallbackContainer m_CallbackContainer;

// Export UUIComponent::execFadeIn(FFrame&, void* const)
native function FadeIn(GFxObject pObj, optional float fTime = 0.0500000, optional float fDelay = 0.0000000);

// Export UUIComponent::execFadeOut(FFrame&, void* const)
native function FadeOut(GFxObject pObj, optional float fTime = 0.0500000, optional float fDelay = 0.0000000);

// Export UUIComponent::execAnimate(FFrame&, void* const)
native function Animate(GFxObject pObj, float fTime, UIComponent.UIANIMTYPE eType, float fValue, optional float fDelay = 0.0000000, optional byte eQuad = 1, optional bool bEndCurrentAnim = true);

// Export UUIComponent::execIsAnimating(FFrame&, void* const)
native function bool IsAnimating(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

// Export UUIComponent::execGetAnimationTarget(FFrame&, void* const)
native function float GetAnimationTarget(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

// Export UUIComponent::execEndAnim(FFrame&, void* const)
native function EndAnim(GFxObject pObj, optional UIComponent.UIANIMTYPE eType = 9);

event float HandleAnimEvent(int nEventType, optional array<float> fExtraData)
{
    return 0.0000000;
    //return ReturnValue;    
}

defaultproperties
{
    m_nLoadIndex=-1
}