class TgAnimBlendByFireMode extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

var() int m_nDefaultFireMode;
var() TgObject.TG_EQUIP_POINT m_EquipPoint;

simulated function SelectFireMode(int FireMode)
{
    // End:0xA7
    if((FireMode >= 0) && FireMode < Children.Length)
    {
        // End:0x7E
        if((FireMode != (m_nDefaultFireMode - 1)) && Children[FireMode].Anim == none)
        {
            SetDefaultFiremode();            
        }
        else
        {
            SetActiveChild(FireMode, GetBlendTime(FireMode));
        }        
    }
    else
    {
        SetDefaultFiremode();
    }
    //return;    
}

simulated function SetDefaultFiremode()
{
    // End:0x4F
    if((m_nDefaultFireMode >= 0) && m_nDefaultFireMode < Children.Length)
    {
        SetActiveChild(m_nDefaultFireMode, GetBlendTime(m_nDefaultFireMode));
    }
    //return;    
}

defaultproperties
{
    m_nDefaultFireMode=1
    DefaultBlendTime=0.1000000
    Children=/* Array type was not detected. */
}