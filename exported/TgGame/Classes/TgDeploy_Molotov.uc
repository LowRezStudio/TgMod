class TgDeploy_Molotov extends TgDeploy_EffectSpots
    native(ChampTyra)
    placeable
    hidecategories(Navigation);

const MOLOTOV_CENTER_POINTS = 18;
const MOLOTOV_NO_NEIGHBOR = -1;
const MOLOTOV_BLOCK_NEIGHBOR = -2;

struct native MolotovPointInfo
{
    var Vector vLocation;
    var Rotator rRotation;
    var int nEffectSpotIndex;
    var float fHeatLevel;
    var array<int> nTriNeighbors;

    structdefaultproperties
    {
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        rRotation=(Pitch=0,Yaw=0,Roll=0)
        nEffectSpotIndex=0
        fHeatLevel=0.0000000
        nTriNeighbors=none
    }
};

struct native MolotovCenterInfo
{
    var int ChildrenFront[3];
    var int ChildrenFrontLeft[3];
    var int ChildrenFrontRight[3];
    var int ChildrenBack[3];
    var int ChildrenBackLeft[3];
    var int ChildrenBackRight[3];

    structdefaultproperties
    {
        ChildrenFront[0]=0
        ChildrenFront[1]=0
        ChildrenFront[2]=0
        ChildrenFrontLeft[0]=0
        ChildrenFrontLeft[1]=0
        ChildrenFrontLeft[2]=0
        ChildrenFrontRight[0]=0
        ChildrenFrontRight[1]=0
        ChildrenFrontRight[2]=0
        ChildrenBack[0]=0
        ChildrenBack[1]=0
        ChildrenBack[2]=0
        ChildrenBackLeft[0]=0
        ChildrenBackLeft[1]=0
        ChildrenBackLeft[2]=0
        ChildrenBackRight[0]=0
        ChildrenBackRight[1]=0
        ChildrenBackRight[2]=0
    }
};

struct native MolotovTriangleInfo
{
    var int index1;
    var int index2;
    var int index3;
    var int neighborIndex1;
    var int neighborIndex2;
    var int neighborIndex3;
    var int nRank;
    var float fHeatLevel;
    var Vector vTriCenter;
    var Vector vCenterDirection;

    structdefaultproperties
    {
        index1=0
        index2=0
        index3=0
        neighborIndex1=0
        neighborIndex2=0
        neighborIndex3=0
        nRank=0
        fHeatLevel=0.0000000
        vTriCenter=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        vCenterDirection=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native MolotovStrandInfo
{
    var Vector vStartDirection;
    var float fAllowanceWeight;
    var int nHeadIndex;
    var int nAllowableSize;
    var array<int> nStrandTrace;

    structdefaultproperties
    {
        vStartDirection=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        fAllowanceWeight=0.0000000
        nHeadIndex=0
        nAllowableSize=0
        nStrandTrace=none
    }
};

struct native MolotovGrowthInfo
{
    var int nStrandAllotment;
    var int nMaxSpots;
    var int nMaxInitialStrands;
    var float fStrandGrowthFraction;
    var bool bStrandsAreSaturated;
    var int nCenterGrowthVariance;
    var int nSpreadsPerTick;

    structdefaultproperties
    {
        nStrandAllotment=0
        nMaxSpots=0
        nMaxInitialStrands=0
        fStrandGrowthFraction=0.0000000
        bStrandsAreSaturated=false
        nCenterGrowthVariance=0
        nSpreadsPerTick=0
    }
};

struct native MolotovGeneralSettings
{
    var Vector vBiasDirection;
    var float fUpFactor;
    var const float fSpotRadius;
    var const float fSpotHeight;

    structdefaultproperties
    {
        vBiasDirection=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        fUpFactor=0.0000000
        fSpotRadius=0.0000000
        fSpotHeight=0.0000000
    }
};

struct native MolotovEligibilityRecord
{
    var bool bIsEligible;
    var Vector vLocation;
    var Vector vHitNormal;

    structdefaultproperties
    {
        bIsEligible=false
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        vHitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var array<MolotovPointInfo> m_PointInfos;
var MolotovCenterInfo m_CenterInfo;
var array<MolotovTriangleInfo> m_TriInfos;
var array<MolotovStrandInfo> m_StrandInfos;
var MolotovGrowthInfo m_GrowthInfo;
var MolotovGeneralSettings m_Settings;

// Export UTgDeploy_Molotov::execGetSpawnEligibility(FFrame&, void* const)
native function MolotovEligibilityRecord GetSpawnEligibility(Vector StartLocation, float Radius, float Height);

// Export UTgDeploy_Molotov::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

simulated event bool CheckItemShopVolumeFailure(Vector TestLocation)
{
    local TgItemShopVolume ItemShop;
    local int nTaskForceNumber;

    nTaskForceNumber = GetTaskForceNumber();
    // End:0x8A
    foreach AllActors(Class'TgGame.TgItemShopVolume', ItemShop)
    {
        // End:0x89
        if((ItemShop.TaskforceIndex != nTaskForceNumber) && ItemShop.EncompassesPoint(TestLocation))
        {            
            return true;
        }        
    }    
    return false;
    //return ReturnValue;    
}

simulated function Tick(float DeltaSeconds)
{
    local int I;

    super.Tick(DeltaSeconds);
    // End:0x1FF
    if(((int(Role) == int(ROLE_Authority)) && !m_bInDestroyedState) && m_TriInfos.Length > 0)
    {
        UpdateHeatLevels();
        // End:0x1FF
        if(m_nNewSpotIndex < m_GrowthInfo.nMaxSpots)
        {
            CompleteSaturationLevel5Points();
            // End:0xB4
            if(m_nNewSpotIndex >= m_GrowthInfo.nMaxSpots)
            {
                return;
            }
            // End:0x150
            if(!m_GrowthInfo.bStrandsAreSaturated)
            {
                UpdateStrandAllowances();
                I = 0;
                J0xEB:

                // End:0x150 [Loop If]
                if(I < m_StrandInfos.Length)
                {
                    SpawnFromStrand(I);
                    // End:0x142
                    if(m_nNewSpotIndex >= m_GrowthInfo.nMaxSpots)
                    {
                        return;
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0xEB;
                }
            }
            SpawnFromPeripheral();
            // End:0x186
            if(m_nNewSpotIndex >= m_GrowthInfo.nMaxSpots)
            {
                return;
            }
            I = 0;
            J0x191:

            // End:0x1FF [Loop If]
            if(I < m_GrowthInfo.nSpreadsPerTick)
            {
                SpawnFromCenter();
                // End:0x1F1
                if(m_nNewSpotIndex >= m_GrowthInfo.nMaxSpots)
                {
                    return;
                }
                ++I;
                // [Loop Continue]
                goto J0x191;
            }
        }
    }
    //return;    
}

function CompleteSaturationLevel5Points()
{
    local int I, J, numPoints;

    numPoints = m_PointInfos.Length;
    I = 0;
    J0x1F:

    // End:0x563 [Loop If]
    if(I < m_PointInfos.Length)
    {
        // End:0x555
        if(m_PointInfos[I].nTriNeighbors.Length == 5)
        {
            J = 0;
            J0x70:

            // End:0x555 [Loop If]
            if(J < m_PointInfos[I].nTriNeighbors.Length)
            {
                // End:0x231
                if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].index1 == I)
                {
                    // End:0x198
                    if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex1 == -1)
                    {
                        SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 1);
                        // [Explicit Break]
                        goto J0x555;                        
                    }
                    else
                    {
                        // End:0x22E
                        if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex3 == -1)
                        {
                            SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 3);
                            // [Explicit Break]
                            goto J0x555;
                        }
                    }                    
                }
                else
                {
                    // End:0x3BD
                    if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].index2 == I)
                    {
                        // End:0x324
                        if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex1 == -1)
                        {
                            SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 1);
                            // [Explicit Break]
                            goto J0x555;                            
                        }
                        else
                        {
                            // End:0x3BA
                            if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex2 == -1)
                            {
                                SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 2);
                                // [Explicit Break]
                                goto J0x555;
                            }
                        }                        
                    }
                    else
                    {
                        // End:0x547
                        if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].index3 == I)
                        {
                            // End:0x4B1
                            if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex2 == -1)
                            {
                                SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 2);
                                // [Explicit Break]
                                goto J0x555;                                
                            }
                            else
                            {
                                // End:0x547
                                if(m_TriInfos[m_PointInfos[I].nTriNeighbors[J]].neighborIndex3 == -1)
                                {
                                    SpawnFromTriangle(m_PointInfos[I].nTriNeighbors[J], 3);
                                    // [Explicit Break]
                                    goto J0x555;
                                }
                            }
                        }
                    }
                }
                ++J;
                // [Loop Continue]
                goto J0x70;
            }
        }
        J0x555:

        ++I;
        // [Loop Continue]
        goto J0x1F;
    }
    // End:0x57B
    if(numPoints != m_PointInfos.Length)
    {
    }
    //return;    
}

function UpdateHeatLevels()
{
    local int I, J, nIntensityLevel, nTier1, nTier2;

    local float fHeatLevel, fAdjustedRank;
    local bool bInsertAtEnd;
    local array<int> heatIndexes;
    local array<float> heatLevels;

    I = 0;
    J0x0B:

    // End:0x5D [Loop If]
    if(I < m_PointInfos.Length)
    {
        m_PointInfos[I].fHeatLevel = 0.0000000;
        ++I;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x68:

    // End:0x36B [Loop If]
    if(I < m_TriInfos.Length)
    {
        fAdjustedRank = float(m_TriInfos[I].nRank);
        fAdjustedRank *= fAdjustedRank;
        // End:0xE8
        if(fAdjustedRank == 0.0000000)
        {
            fAdjustedRank = 0.5000000;
        }
        fHeatLevel = 1.0000000 / fAdjustedRank;
        // End:0x16D
        if(m_TriInfos[I].neighborIndex1 > -1)
        {
            fHeatLevel += (CalcHeatLevel(m_TriInfos[I].neighborIndex1));
        }
        // End:0x1D8
        if(m_TriInfos[I].neighborIndex2 > -1)
        {
            fHeatLevel += (CalcHeatLevel(m_TriInfos[I].neighborIndex2));
        }
        // End:0x243
        if(m_TriInfos[I].neighborIndex3 > -1)
        {
            fHeatLevel += (CalcHeatLevel(m_TriInfos[I].neighborIndex3));
        }
        m_TriInfos[I].fHeatLevel = fHeatLevel;
        m_PointInfos[m_TriInfos[I].index1].fHeatLevel += fHeatLevel;
        m_PointInfos[m_TriInfos[I].index2].fHeatLevel += fHeatLevel;
        m_PointInfos[m_TriInfos[I].index3].fHeatLevel += fHeatLevel;
        ++I;
        // [Loop Continue]
        goto J0x68;
    }
    I = 0;
    J0x376:

    // End:0x526 [Loop If]
    if(I < m_PointInfos.Length)
    {
        // End:0x3C1
        if(m_PointInfos[I].nEffectSpotIndex == -1)
        {            
        }
        else
        {
            bInsertAtEnd = true;
            // End:0x518
            if(heatLevels.Length == heatIndexes.Length)
            {
                J = 0;
                J0x3F1:

                // End:0x4BF [Loop If]
                if(J < heatIndexes.Length)
                {
                    // End:0x4B1
                    if(m_PointInfos[I].fHeatLevel < heatLevels[J])
                    {
                        heatIndexes.InsertItem(J, I);
                        heatLevels.InsertItem(J, m_PointInfos[I].fHeatLevel);
                        bInsertAtEnd = false;
                        // [Explicit Break]
                        goto J0x4BF;
                    }
                    ++J;
                    // [Loop Continue]
                    goto J0x3F1;
                }
                J0x4BF:

                // End:0x515
                if(bInsertAtEnd)
                {
                    heatIndexes.AddItem(I);
                    heatLevels.AddItem(m_PointInfos[I].fHeatLevel);
                }                
            }
        }
        ++I;
        // [Loop Continue]
        goto J0x376;
    }
    nTier1 = heatIndexes.Length / 3;
    nTier2 = nTier1 * 2;
    I = 0;
    J0x560:

    // End:0x603 [Loop If]
    if(I < heatIndexes.Length)
    {
        // End:0x59D
        if(I < nTier1)
        {
            nIntensityLevel = 1;            
        }
        else
        {
            // End:0x5C3
            if(I < nTier2)
            {
                nIntensityLevel = 2;                
            }
            else
            {
                nIntensityLevel = 3;
            }
        }
        SetPointIntensity(heatIndexes[I], nIntensityLevel);
        ++I;
        // [Loop Continue]
        goto J0x560;
    }
    UpdateEffectSpots();
    //return;    
}

function float CalcHeatLevel(int triIndex)
{
    local float fAdjustedRank;

    // End:0x2F
    if((triIndex < 0) || triIndex >= m_TriInfos.Length)
    {
        return 0.0000000;
    }
    fAdjustedRank = float(m_TriInfos[triIndex].nRank);
    fAdjustedRank *= fAdjustedRank;
    // End:0x97
    if(fAdjustedRank == 0.0000000)
    {
        fAdjustedRank = 0.5000000;
    }
    return 1.0000000 / fAdjustedRank;
    //return ReturnValue;    
}

function UpdateStrandAllowances()
{
    local float fTimeElapsed, fDuration, fElapsedPercent, fRandomChance, fWeightSum, fRunningProbability;

    local int nTotalStrandSizeAllowed, nTotalStrandSizeCurrent, I;
    local bool bFoundValidGrowth;

    // End:0x3BE
    if(m_StrandInfos.Length > 0)
    {
        fTimeElapsed = GetTimerCount('OnPersistTimerExpire');
        fDuration = GetTimerRate('OnPersistTimerExpire') * m_GrowthInfo.fStrandGrowthFraction;
        // End:0xBF
        if((fDuration > 0.0000000) && fTimeElapsed >= 0.0000000)
        {
            fElapsedPercent = FClamp(fTimeElapsed / fDuration, 0.0000000, 1.0000000);            
        }
        else
        {
            fElapsedPercent = 1.0000000;
        }
        nTotalStrandSizeAllowed = int(float(m_GrowthInfo.nStrandAllotment) * fElapsedPercent);
        nTotalStrandSizeCurrent = 0;
        fWeightSum = 0.0000000;
        I = 0;
        J0x128:

        // End:0x1B0 [Loop If]
        if(I < m_StrandInfos.Length)
        {
            nTotalStrandSizeCurrent += m_StrandInfos[I].nAllowableSize;
            fWeightSum += m_StrandInfos[I].fAllowanceWeight;
            ++I;
            // [Loop Continue]
            goto J0x128;
        }
        // End:0x223
        if((fWeightSum <= 0.0000000) || (fElapsedPercent >= 1.0000000) && nTotalStrandSizeCurrent == m_GrowthInfo.nStrandAllotment)
        {
            m_GrowthInfo.bStrandsAreSaturated = true;
        }
        bFoundValidGrowth = true;
        J0x22F:

        // End:0x3BE [Loop If]
        if((bFoundValidGrowth && fWeightSum > 0.0000000) && nTotalStrandSizeCurrent < nTotalStrandSizeAllowed)
        {
            bFoundValidGrowth = false;
            fRunningProbability = 0.0000000;
            fRandomChance = FRand() * fWeightSum;
            I = 0;
            J0x2A7:

            // End:0x3BB [Loop If]
            if(I < m_StrandInfos.Length)
            {
                // End:0x2F2
                if(m_StrandInfos[I].fAllowanceWeight <= 0.0000000)
                {                    
                }
                else
                {
                    fRunningProbability += m_StrandInfos[I].fAllowanceWeight;
                    // End:0x3AD
                    if(fRunningProbability > fRandomChance)
                    {
                        m_StrandInfos[I].nAllowableSize++;
                        nTotalStrandSizeCurrent++;
                        bFoundValidGrowth = true;
                        fWeightSum -= m_StrandInfos[I].fAllowanceWeight;
                        // [Explicit Break]
                        goto J0x3BB;
                    }
                }
                ++I;
                // [Loop Continue]
                goto J0x2A7;
            }
            J0x3BB:

            // [Loop Continue]
            goto J0x22F;
        }
    }
    //return;    
}

function bool IsInStrand(int triIndex, int strandIndex)
{
    local int I;

    // End:0x56
    if((((triIndex < 0) || triIndex >= m_TriInfos.Length) || strandIndex < 0) || strandIndex >= m_StrandInfos.Length)
    {
        return false;
    }
    I = 0;
    J0x61:

    // End:0xE4 [Loop If]
    if(I < m_StrandInfos[strandIndex].nStrandTrace.Length)
    {
        // End:0xD6
        if(m_StrandInfos[strandIndex].nStrandTrace[I] == triIndex)
        {
            return true;
        }
        ++I;
        // [Loop Continue]
        goto J0x61;
    }
    return false;
    //return ReturnValue;    
}

function float GetStrandSpreadWeight(int strandNum, int neighborNum)
{
    local int EdgeStart, EdgeEnd;
    local float fCurlDot, fWeight;
    local Vector curlDeviance, headCenter, edgeCenter;
    local MolotovTriangleInfo strandTri;

    // End:0x2F
    if((strandNum < 0) || strandNum >= m_StrandInfos.Length)
    {
        return 0.0000000;
    }
    EdgeStart = -1;
    EdgeEnd = -1;
    strandTri = m_TriInfos[m_StrandInfos[strandNum].nHeadIndex];
    switch(neighborNum)
    {
        // End:0x113
        case 1:
            // End:0x110
            if(strandTri.neighborIndex1 == -1)
            {
                EdgeStart = strandTri.index1;
                EdgeEnd = strandTri.index2;
            }
            // End:0x210
            break;
        // End:0x18D
        case 2:
            // End:0x18A
            if(strandTri.neighborIndex2 == -1)
            {
                EdgeStart = strandTri.index2;
                EdgeEnd = strandTri.index3;
            }
            // End:0x210
            break;
        // End:0x207
        case 3:
            // End:0x204
            if(strandTri.neighborIndex3 == -1)
            {
                EdgeStart = strandTri.index3;
                EdgeEnd = strandTri.index1;
            }
            // End:0x210
            break;
        // End:0xFFFF
        default:
            return 0.0000000;
            break;
    }
    // End:0x3E9
    if((EdgeStart >= 0) && EdgeEnd >= 0)
    {
        headCenter = m_TriInfos[m_StrandInfos[strandNum].nHeadIndex].vTriCenter;
        edgeCenter = ((m_PointInfos[EdgeEnd].vLocation - m_PointInfos[EdgeStart].vLocation) / float(2)) + m_PointInfos[EdgeStart].vLocation;
        curlDeviance = edgeCenter - headCenter;
        curlDeviance.Z = 0.0000000;
        curlDeviance = Normal(curlDeviance);
        fCurlDot = (m_StrandInfos[strandNum].vStartDirection Dot curlDeviance) + float(1);
        // End:0x3E9
        if(fCurlDot >= float(1))
        {
            fWeight = fCurlDot;
            fWeight *= fWeight;
            fWeight /= float(4);
            return fWeight;
        }
    }
    return 0.0000000;
    //return ReturnValue;    
}

function PushStrandToTip(int strandNum)
{
    local int I, headIndex, highestRank, highestRankIndex, tiedIndex;

    local bool bPushEnded, bIsInStrand;
    local MolotovTriangleInfo strandTri;

    // End:0x2B
    if((strandNum < 0) || strandNum >= m_StrandInfos.Length)
    {
        return;
    }
    headIndex = m_StrandInfos[strandNum].nHeadIndex;
    // End:0x804
    if(headIndex >= 0)
    {
        bPushEnded = false;
        J0x76:

        // End:0x804 [Loop If]
        if(!bPushEnded)
        {
            strandTri = m_TriInfos[headIndex];
            highestRank = strandTri.nRank;
            highestRankIndex = -1;
            tiedIndex = -1;
            // End:0x2FA
            if((strandTri.neighborIndex1 > -1) && m_TriInfos[strandTri.neighborIndex1].nRank > 0)
            {
                bIsInStrand = false;
                I = 0;
                J0x164:

                // End:0x1CB [Loop If]
                if(I < m_StrandInfos.Length)
                {
                    // End:0x1BD
                    if(IsInStrand(strandTri.neighborIndex1, I))
                    {
                        bIsInStrand = true;
                        // [Explicit Break]
                        goto J0x1CB;
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0x164;
                }
                J0x1CB:

                // End:0x2FA
                if(!bIsInStrand)
                {
                    // End:0x28D
                    if(m_TriInfos[strandTri.neighborIndex1].nRank > highestRank)
                    {
                        highestRank = m_TriInfos[strandTri.neighborIndex1].nRank;
                        highestRankIndex = strandTri.neighborIndex1;                        
                    }
                    else
                    {
                        // End:0x2FA
                        if(m_TriInfos[strandTri.neighborIndex1].nRank == highestRank)
                        {
                            tiedIndex = strandTri.neighborIndex1;
                        }
                    }
                }
            }
            // End:0x50E
            if((strandTri.neighborIndex2 > -1) && m_TriInfos[strandTri.neighborIndex2].nRank > 0)
            {
                bIsInStrand = false;
                I = 0;
                J0x378:

                // End:0x3DF [Loop If]
                if(I < m_StrandInfos.Length)
                {
                    // End:0x3D1
                    if(IsInStrand(strandTri.neighborIndex2, I))
                    {
                        bIsInStrand = true;
                        // [Explicit Break]
                        goto J0x3DF;
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0x378;
                }
                J0x3DF:

                // End:0x50E
                if(!bIsInStrand)
                {
                    // End:0x4A1
                    if(m_TriInfos[strandTri.neighborIndex2].nRank > highestRank)
                    {
                        highestRank = m_TriInfos[strandTri.neighborIndex2].nRank;
                        highestRankIndex = strandTri.neighborIndex2;                        
                    }
                    else
                    {
                        // End:0x50E
                        if(m_TriInfos[strandTri.neighborIndex2].nRank == highestRank)
                        {
                            tiedIndex = strandTri.neighborIndex2;
                        }
                    }
                }
            }
            // End:0x722
            if((strandTri.neighborIndex3 > -1) && m_TriInfos[strandTri.neighborIndex3].nRank > 0)
            {
                bIsInStrand = false;
                I = 0;
                J0x58C:

                // End:0x5F3 [Loop If]
                if(I < m_StrandInfos.Length)
                {
                    // End:0x5E5
                    if(IsInStrand(strandTri.neighborIndex3, I))
                    {
                        bIsInStrand = true;
                        // [Explicit Break]
                        goto J0x5F3;
                    }
                    ++I;
                    // [Loop Continue]
                    goto J0x58C;
                }
                J0x5F3:

                // End:0x722
                if(!bIsInStrand)
                {
                    // End:0x6B5
                    if(m_TriInfos[strandTri.neighborIndex3].nRank > highestRank)
                    {
                        highestRank = m_TriInfos[strandTri.neighborIndex3].nRank;
                        highestRankIndex = strandTri.neighborIndex3;                        
                    }
                    else
                    {
                        // End:0x722
                        if(m_TriInfos[strandTri.neighborIndex3].nRank == highestRank)
                        {
                            tiedIndex = strandTri.neighborIndex3;
                        }
                    }
                }
            }
            // End:0x7F5
            if(highestRank > strandTri.nRank)
            {
                // End:0x77C
                if((tiedIndex >= 0) && FRand() < 0.5000000)
                {
                    highestRankIndex = tiedIndex;
                }
                headIndex = highestRankIndex;
                m_StrandInfos[strandNum].nStrandTrace.AddItem(headIndex);
                m_StrandInfos[strandNum].nHeadIndex = headIndex;                
            }
            else
            {
                bPushEnded = true;
            }
            // [Loop Continue]
            goto J0x76;
        }
    }
    return;
    //return;    
}

function SpawnFromStrand(int strandNum)
{
    local int newTriIndex, I;
    local float fRandomChance, fRunningProbability, fWeight, fWeightSum;
    local array<float> fWeights;

    PushStrandToTip(strandNum);
    // End:0x92
    if(((strandNum < 0) || strandNum >= m_StrandInfos.Length) || m_StrandInfos[strandNum].nStrandTrace.Length >= m_StrandInfos[strandNum].nAllowableSize)
    {
        return;
    }
    fWeightSum = 0.0000000;
    I = 1;
    J0xAC:

    // End:0x11A [Loop If]
    if(I <= 3)
    {
        fWeight = GetStrandSpreadWeight(strandNum, I);
        fWeightSum += fWeight;
        fWeights.AddItem(fWeight);
        ++I;
        // [Loop Continue]
        goto J0xAC;
    }
    // End:0x12F
    if(fWeightSum == 0.0000000)
    {
        return;
    }
    fRunningProbability = 0.0000000;
    fRandomChance = FRand() * fWeightSum;
    newTriIndex = -1;
    I = 0;
    J0x16F:

    // End:0x233 [Loop If]
    if(I < fWeights.Length)
    {
        // End:0x1A7
        if(fWeights[I] <= 0.0000000)
        {            
        }
        else
        {
            fRunningProbability += fWeights[I];
            // End:0x225
            if(fRunningProbability > fRandomChance)
            {
                newTriIndex = SpawnFromTriangle(m_StrandInfos[strandNum].nHeadIndex, I + 1);
                // [Explicit Break]
                goto J0x233;
            }
        }
        ++I;
        // [Loop Continue]
        goto J0x16F;
    }
    J0x233:

    // End:0x2A8
    if(newTriIndex >= 0)
    {
        m_StrandInfos[strandNum].nStrandTrace.AddItem(newTriIndex);
        m_StrandInfos[strandNum].nHeadIndex = newTriIndex;        
    }
    else
    {
        // End:0x355
        if(IsSaturated(m_StrandInfos[strandNum].nHeadIndex))
        {
            m_StrandInfos[strandNum].fAllowanceWeight = 0.0000000;
            m_StrandInfos[strandNum].nAllowableSize = m_StrandInfos[strandNum].nStrandTrace.Length;
        }
    }
    //return;    
}

function SpawnFromPeripheral()
{
    local int I, J, nextIndex;
    local array<int> strandPeripheral;
    local array<float> heatLevels;
    local float fRandomChance, fRunningProbability, fWeightedSum, fWeightedHeat;

    I = 0;
    J0x0B:

    // End:0x59E [Loop If]
    if(I < m_StrandInfos.Length)
    {
        fWeightedSum = 0.0000000;
        // End:0x63
        if(m_StrandInfos[I].nStrandTrace.Length < 7)
        {            
        }
        else
        {
            J = 0;
            J0x6E:

            // End:0x3CB [Loop If]
            if(J < (m_StrandInfos[I].nStrandTrace.Length - 6))
            {
                // End:0x126
                if(!IsSaturated(m_StrandInfos[I].nStrandTrace[J]))
                {
                    strandPeripheral.AddItem(m_StrandInfos[I].nStrandTrace[J]);                    
                }
                else
                {
                    nextIndex = m_TriInfos[m_StrandInfos[I].nStrandTrace[J]].neighborIndex1;
                    // End:0x203
                    if(((nextIndex > -1) && !IsInStrand(nextIndex, I)) && !IsSaturated(nextIndex))
                    {
                        // End:0x203
                        if(strandPeripheral.Find(nextIndex) == -1)
                        {
                            strandPeripheral.AddItem(nextIndex);
                        }
                    }
                    nextIndex = m_TriInfos[m_StrandInfos[I].nStrandTrace[J]].neighborIndex2;
                    // End:0x2E0
                    if(((nextIndex > -1) && !IsInStrand(nextIndex, I)) && !IsSaturated(nextIndex))
                    {
                        // End:0x2E0
                        if(strandPeripheral.Find(nextIndex) == -1)
                        {
                            strandPeripheral.AddItem(nextIndex);
                        }
                    }
                    nextIndex = m_TriInfos[m_StrandInfos[I].nStrandTrace[J]].neighborIndex3;
                    // End:0x3BD
                    if(((nextIndex > -1) && !IsInStrand(nextIndex, I)) && !IsSaturated(nextIndex))
                    {
                        // End:0x3BD
                        if(strandPeripheral.Find(nextIndex) == -1)
                        {
                            strandPeripheral.AddItem(nextIndex);
                        }
                    }
                }
                ++J;
                // [Loop Continue]
                goto J0x6E;
            }
            // End:0x3DD
            if(strandPeripheral.Length == 0)
            {
                return;
            }
            J = 0;
            J0x3E8:

            // End:0x4AB [Loop If]
            if(J < strandPeripheral.Length)
            {
                fWeightedHeat = m_TriInfos[strandPeripheral[J]].fHeatLevel;
                // End:0x473
                if(IsInStrand(strandPeripheral[J], I))
                {
                    fWeightedHeat *= 1.2500000;
                }
                fWeightedSum += fWeightedHeat;
                heatLevels.AddItem(fWeightedHeat);
                ++J;
                // [Loop Continue]
                goto J0x3E8;
            }
            fRunningProbability = 0.0000000;
            fRandomChance = FRand() * fWeightedSum;
            J = 0;
            J0x4DC:

            // End:0x578 [Loop If]
            if(J < strandPeripheral.Length)
            {
                // End:0x514
                if(heatLevels[J] == 0.0000000)
                {                    
                }
                else
                {
                    fRunningProbability += heatLevels[J];
                    // End:0x56A
                    if(fRunningProbability > fRandomChance)
                    {
                        SpawnFromTriangle(strandPeripheral[J]);
                        // [Explicit Break]
                        goto J0x578;
                    }
                }
                ++J;
                // [Loop Continue]
                goto J0x4DC;
            }
            J0x578:

            strandPeripheral.Length = 0;
            heatLevels.Length = 0;
        }
        ++I;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function bool IsSaturated(int triIndex)
{
    // End:0x2B
    if((triIndex < 0) || triIndex >= m_TriInfos.Length)
    {
        return true;
    }
    // End:0xC1
    if(((m_TriInfos[triIndex].neighborIndex1 == -1) || m_TriInfos[triIndex].neighborIndex2 == -1) || m_TriInfos[triIndex].neighborIndex3 == -1)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

function SpawnFromCenter()
{
    local array<int> spreadableIndexes;
    local int I, saturation, randIndex;

    saturation = 2 * m_GrowthInfo.nMaxSpots;
    I = 0;
    J0x35:

    // End:0xD9 [Loop If]
    if(I < m_TriInfos.Length)
    {
        // End:0xCB
        if((m_TriInfos[I].nRank < saturation) && !IsSaturated(I))
        {
            saturation = m_TriInfos[I].nRank;
        }
        ++I;
        // [Loop Continue]
        goto J0x35;
    }
    I = 0;
    J0xE4:

    // End:0x1A8 [Loop If]
    if(I < m_TriInfos.Length)
    {
        // End:0x19A
        if((m_TriInfos[I].nRank >= saturation) && m_TriInfos[I].nRank <= (saturation + m_GrowthInfo.nCenterGrowthVariance))
        {
            spreadableIndexes.AddItem(I);
        }
        ++I;
        // [Loop Continue]
        goto J0xE4;
    }
    // End:0x1BB
    if(spreadableIndexes.Length == 0)
    {        
    }
    else
    {
        randIndex = int(RandRange(0.0000000, float(spreadableIndexes.Length)));
        SpawnFromTriangle(spreadableIndexes[randIndex]);
    }
    //return;    
}

function Vector GetNewSpotLocation(int index1, int index2)
{
    local Vector vEdgeDirection, vUp, vSpawnDirection;
    local float fEdgeLength, fTriHeight;

    // End:0x62
    if((((index1 < 0) || index1 >= m_PointInfos.Length) || index2 < 0) || index2 >= m_PointInfos.Length)
    {
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    vEdgeDirection = m_PointInfos[index2].vLocation - m_PointInfos[index1].vLocation;
    vEdgeDirection.Z = 0.0000000;
    vEdgeDirection = Normal(vEdgeDirection);
    vUp = vect(0.0000000, 0.0000000, 1.0000000);
    vSpawnDirection = vEdgeDirection Cross vUp;
    fEdgeLength = 2.0000000 * m_Settings.fSpotRadius;
    fTriHeight = (Sqrt(3.0000000) * fEdgeLength) / float(2);
    return (m_PointInfos[index1].vLocation + ((fEdgeLength / 2.0000000) * vEdgeDirection)) + (fTriHeight * vSpawnDirection);
    //return ReturnValue;    
}

function int SpawnFromTriangle(int triIndex, optional int neighborNum = 0)
{
    local int index1, index2, newSpotIndex, newTriIndex, I;

    local Vector vRotation, vNewSpotLocation;
    local bool bNeedsNewTriInfo;
    local MolotovTriangleInfo newTriInfo;

    // End:0x43
    if((m_bInDestroyedState || triIndex < 0) || triIndex >= m_TriInfos.Length)
    {
        return -1;
    }
    // End:0xF8
    if((m_TriInfos[triIndex].neighborIndex1 == -1) && (neighborNum == 1) || neighborNum == 0)
    {
        index1 = m_TriInfos[triIndex].index1;
        index2 = m_TriInfos[triIndex].index2;        
    }
    else
    {
        // End:0x1AE
        if((m_TriInfos[triIndex].neighborIndex2 == -1) && (neighborNum == 2) || neighborNum == 0)
        {
            index1 = m_TriInfos[triIndex].index2;
            index2 = m_TriInfos[triIndex].index3;            
        }
        else
        {
            // End:0x264
            if((m_TriInfos[triIndex].neighborIndex3 == -1) && (neighborNum == 3) || neighborNum == 0)
            {
                index1 = m_TriInfos[triIndex].index3;
                index2 = m_TriInfos[triIndex].index1;                
            }
            else
            {
                return -1;
            }
        }
    }
    vRotation = m_TriInfos[triIndex].vTriCenter - Location;
    vRotation.Z = 0.0000000;
    vNewSpotLocation = GetNewSpotLocation(index1, index2);
    newSpotIndex = AddNewPoint(vNewSpotLocation, Rotator(vRotation), true);
    newTriIndex = -1;
    // End:0xCAC
    if((newSpotIndex >= 0) && newSpotIndex < m_PointInfos.Length)
    {
        bNeedsNewTriInfo = true;
        I = 0;
        J0x366:

        // End:0x795 [Loop If]
        if(I < m_TriInfos.Length)
        {
            // End:0x787
            if((((((((index1 == m_TriInfos[I].index1) && index2 == m_TriInfos[I].index2) && newSpotIndex == m_TriInfos[I].index3) || ((index1 == m_TriInfos[I].index2) && index2 == m_TriInfos[I].index3) && newSpotIndex == m_TriInfos[I].index1) || ((index1 == m_TriInfos[I].index3) && index2 == m_TriInfos[I].index1) && newSpotIndex == m_TriInfos[I].index2) || ((index1 == m_TriInfos[I].index3) && index2 == m_TriInfos[I].index2) && newSpotIndex == m_TriInfos[I].index1) || ((index1 == m_TriInfos[I].index2) && index2 == m_TriInfos[I].index1) && newSpotIndex == m_TriInfos[I].index3) || ((index1 == m_TriInfos[I].index1) && index2 == m_TriInfos[I].index3) && newSpotIndex == m_TriInfos[I].index2)
            {
                newTriInfo = m_TriInfos[I];
                newTriIndex = I;
                bNeedsNewTriInfo = false;
                // [Explicit Break]
                goto J0x795;
            }
            ++I;
            // [Loop Continue]
            goto J0x366;
        }
        J0x795:

        // End:0xC8C
        if(bNeedsNewTriInfo)
        {
            newTriInfo.index1 = index2;
            newTriInfo.index2 = index1;
            newTriInfo.index3 = newSpotIndex;
            newTriInfo.neighborIndex1 = -1;
            newTriInfo.neighborIndex2 = -1;
            newTriInfo.neighborIndex3 = -1;
            newTriInfo.nRank = m_TriInfos[triIndex].nRank + 1;
            newTriInfo.fHeatLevel = 0.0000000;
            newTriInfo.vTriCenter = (m_PointInfos[newTriInfo.index1].vLocation + m_PointInfos[newTriInfo.index2].vLocation) + m_PointInfos[newTriInfo.index3].vLocation;
            newTriInfo.vTriCenter /= 3.0000000;
            newTriInfo.vCenterDirection = newTriInfo.vTriCenter - Location;
            newTriInfo.vCenterDirection.Z = 0.0000000;
            newTriInfo.vCenterDirection = Normal(newTriInfo.vCenterDirection);
            m_TriInfos.AddItem(newTriInfo);
            newTriIndex = m_TriInfos.Length - 1;
            // End:0xB50
            if(m_PointInfos[index2].nTriNeighbors.Find(newTriIndex) == -1)
            {
                // End:0xB1D
                if(m_PointInfos[index2].nTriNeighbors.Length == 6)
                {
                }
                m_PointInfos[index2].nTriNeighbors.AddItem(newTriIndex);
            }
            // End:0xBEE
            if(m_PointInfos[index1].nTriNeighbors.Find(newTriIndex) == -1)
            {
                // End:0xBBB
                if(m_PointInfos[index1].nTriNeighbors.Length == 6)
                {
                }
                m_PointInfos[index1].nTriNeighbors.AddItem(newTriIndex);
            }
            // End:0xC8C
            if(m_PointInfos[newSpotIndex].nTriNeighbors.Find(newTriIndex) == -1)
            {
                // End:0xC59
                if(m_PointInfos[newSpotIndex].nTriNeighbors.Length == 6)
                {
                }
                m_PointInfos[newSpotIndex].nTriNeighbors.AddItem(newTriIndex);
            }
        }
        LinkNeighbors(newTriIndex);
        UpdateAllRanks();        
    }
    else
    {
        // End:0xD2D
        if((m_TriInfos[triIndex].neighborIndex1 == -1) && (neighborNum == 1) || neighborNum == 0)
        {
            m_TriInfos[triIndex].neighborIndex1 = -2;            
        }
        else
        {
            // End:0xDAF
            if((m_TriInfos[triIndex].neighborIndex2 == -1) && (neighborNum == 2) || neighborNum == 0)
            {
                m_TriInfos[triIndex].neighborIndex2 = -2;                
            }
            else
            {
                // End:0xE2E
                if((m_TriInfos[triIndex].neighborIndex3 == -1) && (neighborNum == 3) || neighborNum == 0)
                {
                    m_TriInfos[triIndex].neighborIndex3 = -2;
                }
            }
        }
    }
    return newTriIndex;
    //return ReturnValue;    
}

function LinkNeighbors(int triIndex)
{
    local int testTriangle;

    // End:0x2B
    if((triIndex < 0) || triIndex >= m_TriInfos.Length)
    {
        return;
    }
    testTriangle = 0;
    J0x36:

    // End:0x102A [Loop If]
    if(testTriangle < m_TriInfos.Length)
    {
        // End:0x68
        if(testTriangle == triIndex)
        {            
        }
        else
        {
            // End:0x10C
            if((m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index1) && m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index2)
            {
            }
            // End:0x1B0
            if((m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index2) && m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index3)
            {
            }
            // End:0x254
            if((m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index1) && m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index3)
            {
            }
            // End:0x3DD
            if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index1)
            {
                // End:0x2F9
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index2)
                {                    
                }
                else
                {
                    // End:0x3DA
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index2)
                    {
                        // End:0x37A
                        if(m_TriInfos[testTriangle].neighborIndex3 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex1 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex3 = triIndex;
                    }
                }                
            }
            else
            {
                // End:0x566
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index1)
                {
                    // End:0x512
                    if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index2)
                    {
                        // End:0x4AF
                        if(m_TriInfos[testTriangle].neighborIndex1 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex1 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex1 = triIndex;                        
                    }
                    else
                    {
                        // End:0x563
                        if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index2)
                        {
                        }
                    }                    
                }
                else
                {
                    // End:0x6EC
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index1)
                    {
                        // End:0x60B
                        if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index2)
                        {                            
                        }
                        else
                        {
                            // End:0x6EC
                            if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index2)
                            {
                                // End:0x68C
                                if(m_TriInfos[testTriangle].neighborIndex2 > -1)
                                {
                                }
                                m_TriInfos[triIndex].neighborIndex1 = testTriangle;
                                m_TriInfos[testTriangle].neighborIndex2 = triIndex;
                            }
                        }
                    }
                }
            }
            // End:0x875
            if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index2)
            {
                // End:0x791
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index3)
                {                    
                }
                else
                {
                    // End:0x872
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index3)
                    {
                        // End:0x812
                        if(m_TriInfos[testTriangle].neighborIndex3 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex2 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex3 = triIndex;
                    }
                }                
            }
            else
            {
                // End:0x9FE
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index2)
                {
                    // End:0x9AA
                    if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index3)
                    {
                        // End:0x947
                        if(m_TriInfos[testTriangle].neighborIndex1 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex2 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex1 = triIndex;                        
                    }
                    else
                    {
                        // End:0x9FB
                        if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index3)
                        {
                        }
                    }                    
                }
                else
                {
                    // End:0xB84
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index2)
                    {
                        // End:0xAA3
                        if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index3)
                        {                            
                        }
                        else
                        {
                            // End:0xB84
                            if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index3)
                            {
                                // End:0xB24
                                if(m_TriInfos[testTriangle].neighborIndex2 > -1)
                                {
                                }
                                m_TriInfos[triIndex].neighborIndex2 = testTriangle;
                                m_TriInfos[testTriangle].neighborIndex2 = triIndex;
                            }
                        }
                    }
                }
            }
            // End:0xD0D
            if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index3)
            {
                // End:0xC29
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index1)
                {                    
                }
                else
                {
                    // End:0xD0A
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index1)
                    {
                        // End:0xCAA
                        if(m_TriInfos[testTriangle].neighborIndex3 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex3 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex3 = triIndex;
                    }
                }                
            }
            else
            {
                // End:0xE96
                if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index3)
                {
                    // End:0xE42
                    if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index1)
                    {
                        // End:0xDDF
                        if(m_TriInfos[testTriangle].neighborIndex1 > -1)
                        {
                        }
                        m_TriInfos[triIndex].neighborIndex3 = testTriangle;
                        m_TriInfos[testTriangle].neighborIndex1 = triIndex;                        
                    }
                    else
                    {
                        // End:0xE93
                        if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index1)
                        {
                        }
                    }                    
                }
                else
                {
                    // End:0x101C
                    if(m_TriInfos[testTriangle].index3 == m_TriInfos[triIndex].index3)
                    {
                        // End:0xF3B
                        if(m_TriInfos[testTriangle].index1 == m_TriInfos[triIndex].index1)
                        {                            
                        }
                        else
                        {
                            // End:0x101C
                            if(m_TriInfos[testTriangle].index2 == m_TriInfos[triIndex].index1)
                            {
                                // End:0xFBC
                                if(m_TriInfos[testTriangle].neighborIndex2 > -1)
                                {
                                }
                                m_TriInfos[triIndex].neighborIndex3 = testTriangle;
                                m_TriInfos[testTriangle].neighborIndex2 = triIndex;
                            }
                        }
                    }
                }
            }
        }
        ++testTriangle;
        // [Loop Continue]
        goto J0x36;
    }
    //return;    
}

function UpdateAllRanks()
{
    local array<int> pendingUpdateIndexes;
    local MolotovTriangleInfo nextTriangle;
    local int I, UpdateIndex, lowestRank;

    // End:0x12
    if(m_TriInfos.Length == 0)
    {
        return;
    }
    I = 0;
    J0x1D:

    // End:0x83 [Loop If]
    if(I < 18)
    {
        // End:0x72
        if(m_TriInfos[I].nRank == 0)
        {
            pendingUpdateIndexes.AddItem(I);            
        }
        else
        {
            // [Explicit Break]
            goto J0x83;
        }
        ++I;
        // [Loop Continue]
        goto J0x1D;
    }
    J0x83:

    UpdateIndex = 0;
    J0x8E:

    // End:0x490 [Loop If]
    if(UpdateIndex < pendingUpdateIndexes.Length)
    {
        nextTriangle = m_TriInfos[pendingUpdateIndexes[UpdateIndex]];
        lowestRank = 2 * m_GrowthInfo.nMaxSpots;
        // End:0x203
        if(nextTriangle.neighborIndex1 > -1)
        {
            // End:0x179
            if(pendingUpdateIndexes.Find(nextTriangle.neighborIndex1) == -1)
            {
                pendingUpdateIndexes.AddItem(nextTriangle.neighborIndex1);
            }
            // End:0x203
            if(m_TriInfos[nextTriangle.neighborIndex1].nRank < lowestRank)
            {
                lowestRank = m_TriInfos[nextTriangle.neighborIndex1].nRank;
            }
        }
        // End:0x30F
        if(nextTriangle.neighborIndex2 > -1)
        {
            // End:0x285
            if(pendingUpdateIndexes.Find(nextTriangle.neighborIndex2) == -1)
            {
                pendingUpdateIndexes.AddItem(nextTriangle.neighborIndex2);
            }
            // End:0x30F
            if(m_TriInfos[nextTriangle.neighborIndex2].nRank < lowestRank)
            {
                lowestRank = m_TriInfos[nextTriangle.neighborIndex2].nRank;
            }
        }
        // End:0x41B
        if(nextTriangle.neighborIndex3 > -1)
        {
            // End:0x391
            if(pendingUpdateIndexes.Find(nextTriangle.neighborIndex3) == -1)
            {
                pendingUpdateIndexes.AddItem(nextTriangle.neighborIndex3);
            }
            // End:0x41B
            if(m_TriInfos[nextTriangle.neighborIndex3].nRank < lowestRank)
            {
                lowestRank = m_TriInfos[nextTriangle.neighborIndex3].nRank;
            }
        }
        // End:0x482
        if(lowestRank < m_GrowthInfo.nMaxSpots)
        {
            m_TriInfos[pendingUpdateIndexes[UpdateIndex]].nRank = lowestRank + 1;
        }
        UpdateIndex++;
        // [Loop Continue]
        goto J0x8E;
    }
    //return;    
}

simulated event SetMomentumDirection(Vector projVelocity, Vector HitNormal)
{
    // End:0x26
    if(!IsZero(m_Settings.vBiasDirection))
    {
        return;
    }
    m_Settings.vBiasDirection = MirrorVectorByNormal(projVelocity, HitNormal);
    m_Settings.vBiasDirection = Normal(m_Settings.vBiasDirection);
    m_Settings.fUpFactor = m_Settings.vBiasDirection.Z;
    m_Settings.vBiasDirection.Z = 0.0000000;
    m_Settings.vBiasDirection = Normal(m_Settings.vBiasDirection);
    SetRotation(Rotator(m_Settings.vBiasDirection));
    //return;    
}

function Rotator AlignSpotByRotation(Vector HitNormal, Rotator rRotation)
{
    local Vector X, Y, Z, newY, newX;

    GetAxes(rRotation, X, Y, Z);
    newX = HitNormal Cross (X Cross HitNormal);
    newX = Normal(newX);
    newY = HitNormal Cross newX;
    newY = Normal(newY);
    return OrthoRotation(newX, newY, HitNormal);
    //return ReturnValue;    
}

function int AddNewPoint(Vector vLocation, Rotator rRotation, bool bAddEffectSpot, optional bool bSkipEligibilityCheck = false)
{
    local int I, newSpotIndex;
    local MolotovPointInfo newPointInfo;
    local MolotovEligibilityRecord eligibilityRecord;

    I = 0;
    J0x10:

    // End:0x144 [Loop If]
    if(I < m_PointInfos.Length)
    {
        // End:0x136
        if((Abs(m_PointInfos[I].vLocation.X - vLocation.X) < (m_Settings.fSpotRadius / 4.0000000)) && Abs(m_PointInfos[I].vLocation.Y - vLocation.Y) < (m_Settings.fSpotRadius / 4.0000000))
        {
            return I;
        }
        ++I;
        // [Loop Continue]
        goto J0x10;
    }
    newPointInfo.vLocation = vLocation;
    // End:0x295
    if(!bSkipEligibilityCheck)
    {
        eligibilityRecord = GetSpawnEligibility(vLocation, m_Settings.fSpotRadius / 16.0000000, m_Settings.fSpotHeight);
        // End:0x1FD
        if(!eligibilityRecord.bIsEligible)
        {
            return -1;
        }
        newPointInfo.vLocation.Z = eligibilityRecord.vLocation.Z;
        rRotation = AlignSpotByRotation(eligibilityRecord.vHitNormal, rRotation);
    }
    newPointInfo.rRotation = rRotation;
    newPointInfo.nEffectSpotIndex = -1;
    newPointInfo.fHeatLevel = 0.0000000;
    // End:0x3E0
    if(bAddEffectSpot)
    {
        newSpotIndex = SpawnNewSpot(newPointInfo.vLocation, newPointInfo.rRotation, m_Settings.fSpotRadius / 16.0000000, m_Settings.fSpotHeight, 1, 1);
        // End:0x3E0
        if((newSpotIndex >= 0) && newSpotIndex < 100)
        {
            newPointInfo.nEffectSpotIndex = newSpotIndex;
        }
    }
    m_PointInfos.AddItem(newPointInfo);
    return m_PointInfos.Length - 1;
    //return ReturnValue;    
}

function SetPointIntensity(int PointIndex, int nIntensityLevel)
{
    // End:0x80
    if(((((nIntensityLevel < 1) || nIntensityLevel > 3) || PointIndex < 0) || PointIndex >= m_PointInfos.Length) || m_PointInfos[PointIndex].nEffectSpotIndex == -1)
    {
        return;
    }
    r_EffectSpots[m_PointInfos[PointIndex].nEffectSpotIndex].nIntensityLevel = nIntensityLevel;
    //return;    
}

simulated function DeployComplete()
{
    local float fHexHalfLength, fCenterRadius;
    local MolotovEligibilityRecord eligibilityRecord;
    local Rotator rRotation;

    // End:0x1E
    if(m_bIsDeployed || m_bInDestroyedState)
    {
        return;
    }
    super(TgDeployable).DeployComplete();
    // End:0x19A
    if(int(Role) == int(ROLE_Authority))
    {
        fHexHalfLength = 6.0000000 * m_Settings.fSpotRadius;
        fCenterRadius = (Sqrt(3.0000000) * fHexHalfLength) / 2.0000000;
        eligibilityRecord = GetSpawnEligibility(Location, 0.0000000, m_Settings.fSpotHeight);
        // End:0x102
        if(!eligibilityRecord.bIsEligible)
        {
            rRotation = Rotation;            
        }
        else
        {
            rRotation = AlignSpotByRotation(eligibilityRecord.vHitNormal, Rotation);
        }
        SpawnNewSpot(Location, rRotation, fCenterRadius / 16.0000000, m_Settings.fSpotHeight, 4);
        SpawnInitialCenter();
        SpawnInitialStrands();
    }
    //return;    
}

function SpawnInitialCenter()
{
    local float fHexHalfLength, fCenterRadius, fTriLength;
    local Vector vUp, vLateral, vRotation, vInnerLocation, vInnerRotation, vLocation[18];

    local int nPointExists[18], I, NewPointIndex, skipCount, EdgeStart, EdgeEnd,
	    innerIndex, newTriIndex;

    local MolotovTriangleInfo newTriInfo;

    fTriLength = 2.0000000 * m_Settings.fSpotRadius;
    fHexHalfLength = 3.0000000 * fTriLength;
    fCenterRadius = (Sqrt(3.0000000) * fHexHalfLength) / 2.0000000;
    // End:0x1039
    if(((fTriLength > 0.0000000) && fHexHalfLength > 0.0000000) && fCenterRadius > 0.0000000)
    {
        vUp = vect(0.0000000, 0.0000000, 1.0000000);
        vLateral = m_Settings.vBiasDirection Cross vUp;
        vLocation[0] = (Location + (m_Settings.vBiasDirection * fCenterRadius)) - ((vLateral * fTriLength) * 1.5000000);
        vLocation[1] = (Location + (m_Settings.vBiasDirection * fCenterRadius)) - ((vLateral * fTriLength) * 0.5000000);
        vLocation[2] = (Location + (m_Settings.vBiasDirection * fCenterRadius)) + ((vLateral * fTriLength) * 0.5000000);
        vLocation[3] = (Location + (m_Settings.vBiasDirection * fCenterRadius)) + ((vLateral * fTriLength) * 1.5000000);
        vLocation[4] = (Location + ((m_Settings.vBiasDirection * fCenterRadius) * 0.6700000)) + ((vLateral * fTriLength) * 2.0000000);
        vLocation[5] = (Location + ((m_Settings.vBiasDirection * fCenterRadius) * 0.3300000)) + ((vLateral * fTriLength) * 2.5000000);
        vLocation[6] = Location + ((vLateral * fTriLength) * 3.0000000);
        vLocation[7] = (Location - ((m_Settings.vBiasDirection * fCenterRadius) * 0.3300000)) + ((vLateral * fTriLength) * 2.5000000);
        vLocation[8] = (Location - ((m_Settings.vBiasDirection * fCenterRadius) * 0.6700000)) + ((vLateral * fTriLength) * 2.0000000);
        vLocation[9] = (Location - (m_Settings.vBiasDirection * fCenterRadius)) + ((vLateral * fTriLength) * 1.5000000);
        vLocation[10] = (Location - (m_Settings.vBiasDirection * fCenterRadius)) + ((vLateral * fTriLength) * 0.5000000);
        vLocation[11] = (Location - (m_Settings.vBiasDirection * fCenterRadius)) - ((vLateral * fTriLength) * 0.5000000);
        vLocation[12] = (Location - (m_Settings.vBiasDirection * fCenterRadius)) - ((vLateral * fTriLength) * 1.5000000);
        vLocation[13] = (Location - ((m_Settings.vBiasDirection * fCenterRadius) * 0.6700000)) - ((vLateral * fTriLength) * 2.0000000);
        vLocation[14] = (Location - ((m_Settings.vBiasDirection * fCenterRadius) * 0.3300000)) - ((vLateral * fTriLength) * 2.5000000);
        vLocation[15] = Location - ((vLateral * fTriLength) * 3.0000000);
        vLocation[16] = (Location + ((m_Settings.vBiasDirection * fCenterRadius) * 0.3300000)) - ((vLateral * fTriLength) * 2.5000000);
        vLocation[17] = (Location + ((m_Settings.vBiasDirection * fCenterRadius) * 0.6700000)) - ((vLateral * fTriLength) * 2.0000000);
        I = 0;
        J0x756:

        // End:0x80C [Loop If]
        if(I < 18)
        {
            vRotation = vLocation[I] - Location;
            NewPointIndex = AddNewPoint(vLocation[I], Rotator(vRotation), false);
            // End:0x7E9
            if(NewPointIndex >= 0)
            {
                nPointExists[I] = 1;                
            }
            else
            {
                nPointExists[I] = 0;
            }
            ++I;
            // [Loop Continue]
            goto J0x756;
        }
        skipCount = 0;
        I = 0;
        J0x822:

        // End:0x1039 [Loop If]
        if(I < 18)
        {
            newTriIndex = -1;
            // End:0xD8E
            if((nPointExists[I] == 1) && nPointExists[(((I + 1) < 18) ? I + 1 : 0)] == 1)
            {
                EdgeStart = I - skipCount;
                EdgeEnd = EdgeStart + 1;
                vInnerLocation = GetNewSpotLocation(EdgeStart, EdgeEnd);
                // End:0xD8B
                if(!IsZero(vInnerLocation))
                {
                    vInnerRotation = vInnerLocation - Location;
                    innerIndex = AddNewPoint(vInnerLocation, Rotator(vInnerRotation), false, true);
                    // End:0xD8B
                    if(innerIndex >= 0)
                    {
                        newTriInfo.index1 = EdgeEnd;
                        newTriInfo.index2 = EdgeStart;
                        newTriInfo.index3 = innerIndex;
                        newTriInfo.neighborIndex1 = -1;
                        newTriInfo.neighborIndex2 = -2;
                        newTriInfo.neighborIndex3 = -2;
                        newTriInfo.nRank = 0;
                        newTriInfo.fHeatLevel = 0.0000000;
                        newTriInfo.vTriCenter = (m_PointInfos[newTriInfo.index1].vLocation + m_PointInfos[newTriInfo.index2].vLocation) + m_PointInfos[newTriInfo.index3].vLocation;
                        newTriInfo.vTriCenter /= 3.0000000;
                        newTriInfo.vCenterDirection = newTriInfo.vTriCenter - Location;
                        newTriInfo.vCenterDirection.Z = 0.0000000;
                        newTriInfo.vCenterDirection = Normal(newTriInfo.vCenterDirection);
                        m_TriInfos.AddItem(newTriInfo);
                        newTriIndex = m_TriInfos.Length - 1;
                        // End:0xCA8
                        if(m_PointInfos[EdgeEnd].nTriNeighbors.Find(newTriIndex) == -1)
                        {
                            m_PointInfos[EdgeEnd].nTriNeighbors.AddItem(newTriIndex);
                        }
                        // End:0xD18
                        if(m_PointInfos[EdgeStart].nTriNeighbors.Find(newTriIndex) == -1)
                        {
                            m_PointInfos[EdgeStart].nTriNeighbors.AddItem(newTriIndex);
                        }
                        // End:0xD88
                        if(m_PointInfos[innerIndex].nTriNeighbors.Find(newTriIndex) == -1)
                        {
                            m_PointInfos[innerIndex].nTriNeighbors.AddItem(newTriIndex);
                        }                        
                    }
                }                
            }
            else
            {
                // End:0xDB2
                if(nPointExists[I] == 0)
                {
                    skipCount++;
                }
            }
            // End:0xE17
            if(((I == 0) || I == 1) || I == 2)
            {
                m_CenterInfo.ChildrenFront[I] = newTriIndex;                
            }
            else
            {
                // End:0xE82
                if(((I == 3) || I == 4) || I == 5)
                {
                    m_CenterInfo.ChildrenFrontRight[I - 3] = newTriIndex;                    
                }
                else
                {
                    // End:0xEED
                    if(((I == 6) || I == 7) || I == 8)
                    {
                        m_CenterInfo.ChildrenBackRight[I - 6] = newTriIndex;                        
                    }
                    else
                    {
                        // End:0xF58
                        if(((I == 9) || I == 10) || I == 11)
                        {
                            m_CenterInfo.ChildrenBack[I - 9] = newTriIndex;                            
                        }
                        else
                        {
                            // End:0xFC3
                            if(((I == 12) || I == 13) || I == 14)
                            {
                                m_CenterInfo.ChildrenBackLeft[I - 12] = newTriIndex;                                
                            }
                            else
                            {
                                // End:0x102B
                                if(((I == 15) || I == 16) || I == 17)
                                {
                                    m_CenterInfo.ChildrenFrontLeft[I - 15] = newTriIndex;
                                }
                            }
                        }
                    }
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x822;
        }
    }
    //return;    
}

function SpawnInitialStrands()
{
    local int I, nEligibleRegions, nRegionEligibility[6];
    local Vector vRegionDirection[6];
    local float fRegionWeights[6], fWeightSum, fRunningProbability, fRandomChance;
    local bool bFoundRegion;

    I = 0;
    J0x0B:

    // End:0x78 [Loop If]
    if(I < 6)
    {
        nRegionEligibility[I] = 0;
        vRegionDirection[I] = vect(0.0000000, 0.0000000, 0.0000000);
        fRegionWeights[I] = 0.0000000;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x83:

    // End:0x3DF [Loop If]
    if(I < 3)
    {
        // End:0x11C
        if(m_CenterInfo.ChildrenFront[I] >= 0)
        {
            nRegionEligibility[0]++;
            vRegionDirection[0] += m_TriInfos[m_CenterInfo.ChildrenFront[I]].vCenterDirection;
        }
        // End:0x1A5
        if(m_CenterInfo.ChildrenFrontRight[I] >= 0)
        {
            nRegionEligibility[1]++;
            vRegionDirection[1] += m_TriInfos[m_CenterInfo.ChildrenFrontRight[I]].vCenterDirection;
        }
        // End:0x230
        if(m_CenterInfo.ChildrenBackRight[I] >= 0)
        {
            nRegionEligibility[2]++;
            vRegionDirection[2] += m_TriInfos[m_CenterInfo.ChildrenBackRight[I]].vCenterDirection;
        }
        // End:0x2BB
        if(m_CenterInfo.ChildrenBack[I] >= 0)
        {
            nRegionEligibility[3]++;
            vRegionDirection[3] += m_TriInfos[m_CenterInfo.ChildrenBack[I]].vCenterDirection;
        }
        // End:0x346
        if(m_CenterInfo.ChildrenBackLeft[I] >= 0)
        {
            nRegionEligibility[4]++;
            vRegionDirection[4] += m_TriInfos[m_CenterInfo.ChildrenBackLeft[I]].vCenterDirection;
        }
        // End:0x3D1
        if(m_CenterInfo.ChildrenFrontLeft[I] >= 0)
        {
            nRegionEligibility[5]++;
            vRegionDirection[5] += m_TriInfos[m_CenterInfo.ChildrenFrontLeft[I]].vCenterDirection;
        }
        I++;
        // [Loop Continue]
        goto J0x83;
    }
    nEligibleRegions = 0;
    I = 0;
    J0x3F5:

    // End:0x460 [Loop If]
    if(I < 6)
    {
        // End:0x452
        if(nRegionEligibility[I] > 0)
        {
            vRegionDirection[I] = Normal(vRegionDirection[I]);
            nEligibleRegions++;
        }
        I++;
        // [Loop Continue]
        goto J0x3F5;
    }
    // End:0x471
    if(nEligibleRegions <= 0)
    {
        return;
    }
    fWeightSum = 0.0000000;
    I = 0;
    J0x48B:

    // End:0x57F [Loop If]
    if(I < 6)
    {
        // End:0x4B7
        if(nRegionEligibility[I] == 0)
        {            
        }
        else
        {
            fRegionWeights[I] = ((vRegionDirection[I] Dot m_Settings.vBiasDirection) + float(1)) * 0.5000000;
            fRegionWeights[I] += m_Settings.fUpFactor;
            fRegionWeights[I] /= 2.0000000;
            fWeightSum += fRegionWeights[I];
        }
        I++;
        // [Loop Continue]
        goto J0x48B;
    }
    bFoundRegion = true;
    J0x58B:

    // End:0x6E2 [Loop If]
    if((bFoundRegion && nEligibleRegions > 0) && m_StrandInfos.Length < m_GrowthInfo.nMaxInitialStrands)
    {
        bFoundRegion = false;
        fRunningProbability = 0.0000000;
        fRandomChance = FRand() * fWeightSum;
        I = 0;
        J0x613:

        // End:0x6DF [Loop If]
        if(I < 6)
        {
            // End:0x6D1
            if(nRegionEligibility[I] > 0)
            {
                fRunningProbability += fRegionWeights[I];
                // End:0x6D1
                if(fRunningProbability > fRandomChance)
                {
                    SpawnStrandFromCenter(I);
                    nRegionEligibility[I] = 0;
                    nEligibleRegions--;
                    fWeightSum -= fRegionWeights[I];
                    bFoundRegion = true;
                    // [Explicit Break]
                    goto J0x6DF;
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x613;
        }
        J0x6DF:

        // [Loop Continue]
        goto J0x58B;
    }
    //return;    
}

function bool SpawnStrandFromCenter(int Region)
{
    local array<int> nEligibleIndexes;
    local int I, randIndex, triIndex;
    local MolotovStrandInfo newStrandInfo;

    triIndex = -1;
    // End:0x32
    if((Region < 0) || Region >= 6)
    {
        return false;
    }
    I = 0;
    J0x3D:

    // End:0x30E [Loop If]
    if(I < 3)
    {
        // End:0xC0
        if((Region == 0) && m_CenterInfo.ChildrenFront[I] >= 0)
        {
            nEligibleIndexes.AddItem(m_CenterInfo.ChildrenFront[I]);            
        }
        else
        {
            // End:0x133
            if((Region == 1) && m_CenterInfo.ChildrenFrontRight[I] >= 0)
            {
                nEligibleIndexes.AddItem(m_CenterInfo.ChildrenFrontRight[I]);                
            }
            else
            {
                // End:0x1A7
                if((Region == 2) && m_CenterInfo.ChildrenBackRight[I] >= 0)
                {
                    nEligibleIndexes.AddItem(m_CenterInfo.ChildrenBackRight[I]);                    
                }
                else
                {
                    // End:0x21B
                    if((Region == 3) && m_CenterInfo.ChildrenBack[I] >= 0)
                    {
                        nEligibleIndexes.AddItem(m_CenterInfo.ChildrenBack[I]);                        
                    }
                    else
                    {
                        // End:0x28F
                        if((Region == 4) && m_CenterInfo.ChildrenBackLeft[I] >= 0)
                        {
                            nEligibleIndexes.AddItem(m_CenterInfo.ChildrenBackLeft[I]);                            
                        }
                        else
                        {
                            // End:0x300
                            if((Region == 5) && m_CenterInfo.ChildrenFrontLeft[I] >= 0)
                            {
                                nEligibleIndexes.AddItem(m_CenterInfo.ChildrenFrontLeft[I]);
                            }
                        }
                    }
                }
            }
        }
        ++I;
        // [Loop Continue]
        goto J0x3D;
    }
    // End:0x320
    if(nEligibleIndexes.Length == 0)
    {
        return false;
    }
    randIndex = int(RandRange(0.0000000, float(nEligibleIndexes.Length)));
    triIndex = SpawnFromTriangle(nEligibleIndexes[randIndex]);
    // End:0x5B4
    if(triIndex >= 0)
    {
        newStrandInfo.vStartDirection = m_TriInfos[triIndex].vTriCenter - m_TriInfos[nEligibleIndexes[randIndex]].vTriCenter;
        newStrandInfo.vStartDirection.Z = 0.0000000;
        newStrandInfo.vStartDirection = Normal(newStrandInfo.vStartDirection);
        newStrandInfo.nHeadIndex = triIndex;
        newStrandInfo.nAllowableSize = 1;
        newStrandInfo.fAllowanceWeight = ((newStrandInfo.vStartDirection Dot m_Settings.vBiasDirection) + float(1)) * 0.5000000;
        newStrandInfo.fAllowanceWeight += m_Settings.fUpFactor;
        newStrandInfo.fAllowanceWeight /= 2.0000000;
        m_StrandInfos.AddItem(newStrandInfo);
        m_StrandInfos[m_StrandInfos.Length - 1].nStrandTrace.AddItem(triIndex);
    }
    return triIndex >= 0;
    //return ReturnValue;    
}

simulated function UpdateParticleParams(int spotIndex)
{
    local int I;
    local editinline ParticleSystemComponent PSC;

    // End:0x51
    if(((spotIndex < 0) || spotIndex >= 100) || c_SpotFX[spotIndex].Fx == none)
    {
        return;
    }
    // End:0x7C
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    super.UpdateParticleParams(spotIndex);
    I = 0;
    J0x9A:

    // End:0x2D3 [Loop If]
    if(I < c_SpotFX[spotIndex].Fx.c_PSCList.Length)
    {
        PSC = c_SpotFX[spotIndex].Fx.c_PSCList[I].c_PSC;
        // End:0x2C5
        if(PSC != none)
        {
            // End:0x2C5
            if(c_SpotFX[spotIndex].nFXIndex < 4)
            {
                PSC.SetFloatParameter('A_Spawn', float((((r_EffectSpots[spotIndex].nIntensityLevel == 3) && !m_bInDestroyedState) ? 1 : 0)));
                PSC.SetFloatParameter('B_Spawn', float((((r_EffectSpots[spotIndex].nIntensityLevel == 2) && !m_bInDestroyedState) ? 1 : 0)));
                PSC.SetFloatParameter('C_Spawn', float((((r_EffectSpots[spotIndex].nIntensityLevel == 1) && !m_bInDestroyedState) ? 1 : 0)));
            }
        }
        I++;
        // [Loop Continue]
        goto J0x9A;
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    local int I;

    super.DestroyIt(bSkipFx);
    // End:0x82
    if(m_bInDestroyedState)
    {
        m_StrandInfos.Length = 0;
        m_TriInfos.Length = 0;
        m_PointInfos.Length = 0;
        I = 0;
        J0x51:

        // End:0x82 [Loop If]
        if(I < 100)
        {
            UpdateParticleParams(I);
            ++I;
            // [Loop Continue]
            goto J0x51;
        }
    }
    //return;    
}

defaultproperties
{
    m_GrowthInfo=(nStrandAllotment=40,nMaxSpots=50,nMaxInitialStrands=3,fStrandGrowthFraction=0.2500000,bStrandsAreSaturated=false,nCenterGrowthVariance=2,nSpreadsPerTick=1)
    m_Settings=(vBiasDirection=(X=0.0000000,Y=0.0000000,Z=0.0000000),fUpFactor=0.0000000,fSpotRadius=36.8000000,fSpotHeight=10.0000000)
    m_bUsesEffectRefresh=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Molotov.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectSpots.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}