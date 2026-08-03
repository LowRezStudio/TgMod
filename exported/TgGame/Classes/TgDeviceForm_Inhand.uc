class TgDeviceForm_Inhand extends TgDeviceForm
    native(Devices);

var int m_nAmmoCount;
var int m_nMaxAmmoCount;
var float m_fPreviousAmmoPerc;
var float m_fCurrentAmmoPerc;

final simulated function OnAmmoCountUpdated(int nAmmoCount, int nMaxAmmoCount)
{
    m_nAmmoCount = nAmmoCount;
    m_nMaxAmmoCount = nMaxAmmoCount;
    // End:0x86
    if(nMaxAmmoCount > 0)
    {
        m_fPreviousAmmoPerc = m_fCurrentAmmoPerc;
        m_fCurrentAmmoPerc = float(nAmmoCount) / float(nMaxAmmoCount);
        UpdateAmmoCountFx(m_fPreviousAmmoPerc, m_fCurrentAmmoPerc);
    }
    //return;    
}

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc)
{
    //return;    
}

simulated function OnWeaponMeshUpdated()
{
    local TgPawn_Character PawnChar;

    PawnChar = TgPawn_Character(PawnOwner);
    // End:0x71
    if(PawnChar != none)
    {
        OnAmmoCountUpdated(PawnChar.r_nInHandCurrentAmmo, PawnChar.r_nInHandMaxAmmo);
    }
    //return;    
}
