class TgAnimBlendByBuffMonsterIntro extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(Introduction) bool m_bScalePlayRateOfSpawnAndIntro;
var(Introduction) bool m_bEndIntroStateEarly;
var bool m_bIntroHasBeenSetup;
var(Introduction) float m_fIntroTimeHittableAt;
var float m_fTimeToStartIntroAnim;
var TgPawn m_CachedPawn;
var float m_fSpawnIntroScaleRate;

// Export UTgAnimBlendByBuffMonsterIntro::execSetupIntro(FFrame&, void* const)
native function SetupIntro(float fTotalIntroTime, float fIntroOffset);

defaultproperties
{
    m_fSpawnIntroScaleRate=1.0000000
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}