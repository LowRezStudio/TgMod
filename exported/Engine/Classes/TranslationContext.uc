class TranslationContext extends Object
    native;

var array<TranslatorTag> TranslatorTags;

// Export UTranslationContext::execRegisterTranslatorTag(FFrame&, void* const)
native function bool RegisterTranslatorTag(TranslatorTag InTagHandler);
