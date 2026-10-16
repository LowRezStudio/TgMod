class TgAnimNodePlayFireAnim extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () name FireAnimNodeName;
var transient AnimNodeSequence FireAnimNodeSequence;

native function PlayFireAnim(optional name FireName='Fire');  // Export UTgAnimNodePlayFireAnim::execPlayFireAnim(FFrame&, void* const)

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
