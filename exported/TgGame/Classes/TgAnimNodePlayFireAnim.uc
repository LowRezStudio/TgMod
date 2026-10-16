class TgAnimNodePlayFireAnim extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() name FireAnimNodeName;
var transient AnimNodeSequence FireAnimNodeSequence;

// Export UTgAnimNodePlayFireAnim::execPlayFireAnim(FFrame&, void* const)
native function PlayFireAnim(optional name FireName = 'Fire');

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}