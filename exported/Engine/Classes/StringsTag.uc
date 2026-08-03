class StringsTag extends TranslatorTag
    native;

// Export UStringsTag::execTranslate(FFrame&, void* const)
native function string Translate(string InArgument);

defaultproperties
{
    Tag="Strings"
}