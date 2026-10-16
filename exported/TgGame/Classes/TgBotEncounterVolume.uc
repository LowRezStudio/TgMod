class TgBotEncounterVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var(BotFactory) const array<TgBotFactory> m_Factories;
var int m_nPlayers;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x31
    if(int(Role) == int(ROLE_Authority))
    {
        SetTimer(1.0000000, true, 'CheckTouching');
    }
    //return;    
}

function CheckTouching()
{
    local TgPawn P;
    local TgBotFactory Factory;
    local int I, Count;

    Count = 0;
    // End:0x52
    foreach TouchingActors(Class'TgGame.TgPawn', P)
    {
        // End:0x51
        if(P.IsHumanControlled())
        {
            Count++;
        }        
    }    
    // End:0x225
    if(Count != m_nPlayers)
    {
        // End:0x11C
        if(Count <= 0)
        {
            I = 0;
            J0x84:

            // End:0x119 [Loop If]
            if(I < m_Factories.Length)
            {
                Factory = m_Factories[I];
                // End:0x10B
                if((Factory != none) && Factory.bRespawn)
                {
                    Factory.EndEncounter();
                }
                I++;
                // [Loop Continue]
                goto J0x84;
            }            
        }
        else
        {
            I = 0;
            J0x127:

            // End:0x225 [Loop If]
            if(I < m_Factories.Length)
            {
                Factory = m_Factories[I];
                // End:0x217
                if(Factory != none)
                {
                    // End:0x1D8
                    if(!Factory.bAutoSpawn || Factory.nCurrentCount <= 0)
                    {
                        Factory.StartEncounter(self);                        
                    }
                    else
                    {
                        Factory.ContinueEncounter();
                    }
                    // End:0x217
                    if((m_nPlayers <= 1) && Count > 1)
                    {
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x127;
            }
        }
    }
    m_nPlayers = Count;
    //return;    
}

defaultproperties
{
    BrushColor=(R=200,G=50,B=0,A=255)
    bColored=true
    // Reference: BrushComponent'TgGame.Default__TgBotEncounterVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    CollisionComponent=BrushComponent0
}