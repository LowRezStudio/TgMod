class TgDeviceForm_Spray extends TgDeviceForm
    native(Devices);

enum SprayDisplayBehavior
{
    SDB_RandomSprayAlpha,           // 0
    SDB_MasteryNumbers,             // 1
    SDB_SprayAlphaMasteryNumbers,   // 2
    SDB_TickingNumbers,             // 3
    SDB_MAX                         // 4
};

var array<MaterialInterface> m_SprayMaterial;
var MaterialInstanceConstant m_SprayMIC;
var int m_nRandAlphaMaskMax;
var int m_nPrevAlphaMask;
var export editinline DecalComponent c_SpawnedDecal;
var float m_fAccurateTraceLength;
var float m_fWidth;
var float m_fHeight;
var float m_fDepth;
var int m_nActiveMaterialIndex;
var TgDeviceForm_Spray.SprayDisplayBehavior m_SprayBehavior;
var bool m_bInitializedSprayParams;
var int m_nSprayHitFXId1P;
var int m_nSprayHitFXId3P;
var int m_nSprayMissedFXId1P;
var int m_nSprayMissedFXId3P;
var TgSpecialFx c_SprayHitFX;
var TgSpecialFx c_SprayMissedFX;

// Export UTgDeviceForm_Spray::execPlaySprayFX(FFrame&, void* const)
native function PlaySprayFX(bool bSuccessfulSpray);

// Export UTgDeviceForm_Spray::execSetSprayBehaviorParams(FFrame&, void* const)
native function SetSprayBehaviorParams();

// Export UTgDeviceForm_Spray::execSetSprayNumbers(FFrame&, void* const)
native function SetSprayNumbers(int nNumberToSet);

// Export UTgDeviceForm_Spray::execSetRandomSprayAlpha(FFrame&, void* const)
native function SetRandomSprayAlpha();

// Export UTgDeviceForm_Spray::execGetCharacterMastery(FFrame&, void* const)
native function int GetCharacterMastery();

event PlayImpactEffects(Vector HitLocation, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional Vector FireOrigin, optional float fHitTraceDistOverride = -1.0000000, optional bool bGenerateUpdatedHitLocation = false)
{
    local Vector FireDirection, SprayHitLocation, HitNormal;
    local Actor SprayActor;
    local TraceHitInfo HitInfo;
    local float DecalRotation;
    local editinline DecalComponent NewComponent;

    // End:0x2DB
    if(((PawnOwner != none) && m_SprayMIC != none) && bSuccessfulHit)
    {
        PlaySprayFX(bSuccessfulHit);
        // End:0xA4
        if(FireOrigin == vect(0.0000000, 0.0000000, 0.0000000))
        {
            FireOrigin = PawnOwner.Location;
        }
        FireDirection = Normal(HitLocation - FireOrigin);
        SprayActor = PawnOwner.Trace(SprayHitLocation, HitNormal, HitLocation + (FireDirection * m_fAccurateTraceLength), HitLocation - (FireDirection * m_fAccurateTraceLength), true,, HitInfo, PawnOwner.1);
        // End:0x2DB
        if((SprayActor != none) && SprayActor.bWorldGeometry)
        {
            DecalRotation = Class'TgGame.TgSpecialFx'.static.CalculateOrientedDecalRotation(HitLocation, HitNormal, Normal(SprayHitLocation - FireOrigin));
            SetSprayBehaviorParams();
            NewComponent = PawnOwner.WorldInfo.MyDecalManager.SpawnDecal(false, m_SprayMIC, SprayHitLocation, Rotator(-HitNormal), m_fWidth, m_fHeight, m_fDepth, false, DecalRotation);
            // End:0x2D8
            if(NewComponent != none)
            {
                // End:0x2C5
                if(c_SpawnedDecal != none)
                {
                    c_SpawnedDecal.DetachFromAny();
                }
                c_SpawnedDecal = NewComponent;
            }            
        }
    }
    //return;    
}

simulated event OnDestroyed()
{
    super.OnDestroyed();
    // End:0x38
    if(c_SpawnedDecal != none)
    {
        c_SpawnedDecal.DetachFromAny();
    }
    //return;    
}

defaultproperties
{
    m_SprayMaterial[0]=MaterialInstanceConstant'Sprays.Materials.MIC_SprayMaterial'
    m_SprayMaterial[1]=MaterialInstanceConstant'Sprays.Materials.MIC_SprayMaterial_Mastery'
    m_nRandAlphaMaskMax=3
    m_nPrevAlphaMask=-1
    m_fAccurateTraceLength=5.0000000
    m_fWidth=128.0000000
    m_fHeight=128.0000000
    m_fDepth=128.0000000
    m_nSprayHitFXId1P=7428
    m_nSprayHitFXId3P=7427
    m_nSprayMissedFXId1P=-1
    m_nSprayMissedFXId3P=-1
}