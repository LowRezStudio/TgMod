class TgSpawnGate extends DynamicBlockingVolume
    native(Volumes)
    hidecategories(Navigation,Object,Display);

enum ESpawnGateType
{
    SPGT_Standard,                  // 0
    SPGT_Attackers,                 // 1
    SPGT_Defenders,                 // 2
    SPGT_MAX                        // 3
};

var() TgSpawnGate.ESpawnGateType m_eSpawnGateType;
var() Emitter m_StandardEmitter;
var() TgEmitter_TeamColor m_TeamColoredEmitter;
var() bool m_bStartActive;
var bool m_bGateOpen;
var() int m_nCurrentTaskforce;

// Export UTgSpawnGate::execGetCurrentTaskforce(FFrame&, void* const)
native function int GetCurrentTaskforce();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x24
    if(m_bStartActive)
    {
        Activate();        
    }
    else
    {
        Deactivate();
    }
    //return;    
}

simulated function Activate()
{
    // End:0x2E
    if(m_StandardEmitter != none)
    {
        m_StandardEmitter.Activate();
    }
    // End:0x5C
    if(m_TeamColoredEmitter != none)
    {
        m_TeamColoredEmitter.Deactivate();
    }
    m_bGateOpen = false;
    bEnabled = true;
    SetCollision(true, true);
    //return;    
}

simulated function Deactivate()
{
    // End:0x2E
    if(m_StandardEmitter != none)
    {
        m_StandardEmitter.Deactivate();
    }
    // End:0x5C
    if(m_TeamColoredEmitter != none)
    {
        m_TeamColoredEmitter.Activate();
    }
    m_bGateOpen = true;
    // End:0x8A
    if((GetCurrentTaskforce()) <= 0)
    {
        bEnabled = false;
        SetCollision(false, false);
    }
    //return;    
}

simulated function ToggleTeamColors()
{
    // End:0x76
    if(m_TeamColoredEmitter != none)
    {
        m_TeamColoredEmitter.nTaskForce = ((m_TeamColoredEmitter.nTaskForce == 1) ? 2 : 1);
        m_TeamColoredEmitter.SetPSCChannels();
    }
    //return;    
}

defaultproperties
{
    m_bStartActive=true
    bColored=true
    // Reference: BrushComponent'TgGame.Default__TgSpawnGate.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__DynamicBlockingVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}