class TgStartPoint extends PlayerStart
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Collision);

var(Object) editconst int m_nMapObjectId;
var() int m_nStartGroup;
var() int m_nReturnMapType;
var() float m_fStartRating;
var() float m_fCurrentRating;
var() float m_fResetRating;
var() float m_fDecreaseRate;
var() array< Class<TgTeleporter> > m_ArrayOfFloats;
var() TgTeleporter m_TgTeleporter;

// Export UTgStartPoint::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

simulated function PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    LoadObjectConfig();
    //return;    
}

simulated function float GetRating(Controller Player)
{
    local float Rating;

    // End:0x21
    if(!bEnabled)
    {
        Rating = 0.0000000;        
    }
    else
    {
        Rating = m_fCurrentRating;
        // End:0x50
        if(bPrimaryStart)
        {
            Rating += float(100);
        }
    }
    return Rating;
    //return ReturnValue;    
}

simulated function AdjustRating()
{
    // End:0x4F
    if(m_fDecreaseRate != float(0))
    {
        m_fCurrentRating -= m_fDecreaseRate;
        // End:0x4F
        if(m_fCurrentRating < m_fResetRating)
        {
            m_fCurrentRating = m_fStartRating;
        }
    }
    //return;    
}

simulated function int GetStartGroupNumber()
{
    return m_nStartGroup;
    //return ReturnValue;    
}

defaultproperties
{
    m_fStartRating=90.0000000
    m_fCurrentRating=90.0000000
    m_fResetRating=10.0000000
    // Reference: CylinderComponent'TgGame.Default__TgStartPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PlayerStart.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}