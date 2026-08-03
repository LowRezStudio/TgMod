class TgGame_Domination extends TgGame_PointCapture
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var float m_fRespawnTime;

// Export UTgGame_Domination::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

function UpdateLockedPointStatus()
{
    local TgRepInfo_Game GRI;
    local int I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x134
    if(GRI != none)
    {
        I = 0;
        J0x36:

        // End:0x134 [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            CheckPointLocked(GRI.m_CPRIArray[I].r_OwningCapturePoint);
            // End:0x126
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                GRI.m_CPRIArray[I].r_OwningCapturePoint.UpdateLockEffects();
            }
            I++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

function CheckPointLocked(TgCapturePoint Point)
{
    local TgRepInfo_Game GRI;
    local int TaskforceIndex, I, WinningTaskForceNum;
    local bool bAllOwnedBySameTaskForce;
    local TgCapturePoint CCWNeighborPoint, CWNeighborPoint;

    // End:0xA7
    if(Point.r_RepInfo.r_nControlledByTaskForce == 0)
    {
        Point.r_RepInfo.r_bIsLocked = false;
        Point.r_RepInfo.bNetDirty = true;
        return;
    }
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D3
    if((GRI != none) && GRI.m_CPRIArray.Length > 0)
    {
        TaskforceIndex = GRI.m_CPRIArray[0].r_nControlledByTaskForce;
        bAllOwnedBySameTaskForce = true;
        I = 1;
        J0x14F:

        // End:0x1E4 [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            // End:0x1D6
            if(TaskforceIndex != GRI.m_CPRIArray[I].r_nControlledByTaskForce)
            {
                bAllOwnedBySameTaskForce = false;
                // [Explicit Break]
                goto J0x1E4;
            }
            I++;
            // [Loop Continue]
            goto J0x14F;
        }
        J0x1E4:

        // End:0x2D3
        if(bAllOwnedBySameTaskForce)
        {
            WinningTaskForceNum = GRI.m_CPRIArray[0].r_nControlledByTaskForce;
            // End:0x2D3
            if(WinningTaskForceNum != 0)
            {
                m_GameWinState = ((WinningTaskForceNum == 1) ? 2 : 1);
                GRI.r_Winner = GRI.GetTaskForce(WinningTaskForceNum);
                GRI.bNetDirty = true;
                CheckWinState();
                return;
            }
        }
    }
    // End:0x3B9
    if(Point.m_CapturePointIndex == 0)
    {
        CCWNeighborPoint = GRI.m_CPRIArray[GRI.m_CPRIArray.Length - 1].r_OwningCapturePoint;
        CWNeighborPoint = GRI.m_CPRIArray[Point.m_CapturePointIndex + 1].r_OwningCapturePoint;        
    }
    else
    {
        // End:0x49F
        if(Point.m_CapturePointIndex == (GRI.m_CPRIArray.Length - 1))
        {
            CCWNeighborPoint = GRI.m_CPRIArray[Point.m_CapturePointIndex - 1].r_OwningCapturePoint;
            CWNeighborPoint = GRI.m_CPRIArray[0].r_OwningCapturePoint;            
        }
        else
        {
            CCWNeighborPoint = GRI.m_CPRIArray[Point.m_CapturePointIndex - 1].r_OwningCapturePoint;
            CWNeighborPoint = GRI.m_CPRIArray[Point.m_CapturePointIndex + 1].r_OwningCapturePoint;
        }
    }
    // End:0x671
    if((CCWNeighborPoint.r_RepInfo.r_nControlledByTaskForce != Point.r_RepInfo.r_nControlledByTaskForce) && CCWNeighborPoint.r_RepInfo.r_nControlledByTaskForce != 0)
    {
        Point.r_RepInfo.r_bIsLocked = false;
        Point.r_RepInfo.bNetDirty = true;
        return;
    }
    // End:0x785
    if((CWNeighborPoint.r_RepInfo.r_nControlledByTaskForce != Point.r_RepInfo.r_nControlledByTaskForce) && CWNeighborPoint.r_RepInfo.r_nControlledByTaskForce != 0)
    {
        Point.r_RepInfo.r_bIsLocked = false;
        Point.r_RepInfo.bNetDirty = true;
        return;
    }
    Point.r_RepInfo.r_bIsLocked = true;
    Point.r_RepInfo.bNetDirty = true;
    //return;    
}

defaultproperties
{
    m_fRespawnTime=20.0000000
    m_GameType=TG_GAME_TYPE.TGT_DOMINATION
    GoalScore=500
}