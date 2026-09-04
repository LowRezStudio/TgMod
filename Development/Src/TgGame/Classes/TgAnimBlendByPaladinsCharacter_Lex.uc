class TgAnimBlendByPaladinsCharacter_Lex extends TgAnimBlendByPaladinsCharacter
    native(AnimNodesLex)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var TgPawn_Lex m_CachedLex;
var (Lex) name m_LeftSlideSkelControlName;
var (Lex) name m_RightSlideSkelControlName;
var SkelControlBase m_LeftSlideSkelControl;
var SkelControlBase m_RightSlideSkelControl;

native function UpdateSlideSkelControls();  // Export UTgAnimBlendByPaladinsCharacter_Lex::execUpdateSlideSkelControls(FFrame&, void* const)

native function SetActiveChild(INT ChildIndex, FLOAT BlendTime);  // Export UTgAnimBlendByPaladinsCharacter_Lex::execSetActiveChild(FFrame&, void* const)
