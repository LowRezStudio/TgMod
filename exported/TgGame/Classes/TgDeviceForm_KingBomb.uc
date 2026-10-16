class TgDeviceForm_KingBomb extends TgDeviceForm;

event BuildUp(int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional float fBuildupTime = 0.0000000)
{
    local TgPawn_BombKing BombKing;

    super.BuildUp(nFireMode, nEquipSlot, nSocketIndex, fBuildupTime);
    BombKing = TgPawn_BombKing(PawnOwner);
    // End:0x112
    if((BombKing != none) && BombKing.Mesh != none)
    {
        BombKing.Mesh.FxActivateIndependant('UltimateActivated', 0, BombKing.Location, Vector(BombKing.Rotation));
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_BombKing BombKing;

    logr("BOMB KING - KING BOMB START FIRE");
    BombKing = TgPawn_BombKing(PawnOwner);
    // End:0xCC
    if(BombKing != none)
    {
        BombKing.SwapToKingBombMesh();
        BombKing.m_WeaponMesh.Hide3PWeaponMesh();
        BombKing.HideHeadMesh();
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    Cleanup();
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}

event StopFire(int nFireModeNum)
{
    Cleanup();
    super.StopFire(nFireModeNum);
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    Cleanup();
    //return;    
}

function Cleanup()
{
    local TgPawn_BombKing BombKing;

    logr("BOMB KING - KING BOMB CLEAN UP");
    BombKing = TgPawn_BombKing(PawnOwner);
    // End:0xC7
    if(BombKing != none)
    {
        BombKing.SwapFromKingBombMesh();
        BombKing.m_WeaponMesh.Unhide3PWeaponMesh();
        BombKing.ShowHeadMesh();
    }
    //return;    
}
