class GameplayEventsHandler extends Object
    abstract
    native
    config(GameStats);

var config array<config int> EventIDFilter;
var config array<config GameStatGroup> GroupFilter;
var private transient GameplayEventsReader Reader;

function SetReader(GameplayEventsReader NewReader)
{
    Reader = NewReader;
    //return;    
}

// Export UGameplayEventsHandler::execPreProcessStream(FFrame&, void* const)
native event PreProcessStream();

event PostProcessStream()
{
    //return;    
}

event ResolveGroupFilters()
{
    local int EventIdx, FilterIdx;

    EventIdx = 0;
    J0x0B:

    // End:0x185 [Loop If]
    if(EventIdx < Reader.SupportedEvents.Length)
    {
        FilterIdx = GroupFilter.Find('Group', Reader.SupportedEvents[EventIdx].StatGroup.Group);
        // End:0x177
        if(FilterIdx != -1)
        {
            // End:0x177
            if(Reader.SupportedEvents[EventIdx].StatGroup.Level > GroupFilter[FilterIdx].Level)
            {
                AddFilter(Reader.SupportedEvents[EventIdx].EventID);
            }
        }
        EventIdx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function AddFilter(int EventID)
{
    // End:0x36
    if(EventIDFilter.Find(EventID) == -1)
    {
        EventIDFilter.AddItem(EventID);
    }
    //return;    
}

function RemoveFilter(int EventID)
{
    EventIDFilter.RemoveItem(EventID);
    //return;    
}
