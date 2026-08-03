class TgDevice_MarkAndRecall extends TgDevice
    hidecategories(Navigation);

var Vector m_markedLocation;
var Rotator m_markedRotation;
var bool m_bMarked;

simulated function FireAmmunition()
{
    // End:0x7D
    if(!m_bMarked)
    {
        // End:0x6E
        if(Instigator != none)
        {
            m_markedLocation = Instigator.Location;
            m_markedRotation = Instigator.Rotation;
        }
        m_bMarked = true;        
    }
    else
    {
        // End:0xCE
        if(Instigator != none)
        {
            Instigator.SetLocation(m_markedLocation);
            Instigator.SetRotation(m_markedRotation);
        }
        m_bMarked = false;
    }
    //return;    
}
