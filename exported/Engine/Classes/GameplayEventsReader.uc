class GameplayEventsReader extends GameplayEvents
    native;

var transient array<GameplayEventsHandler> RegisteredHandlers;

// Export UGameplayEventsReader::execOpenStatsFile(FFrame&, void* const)
native function bool OpenStatsFile(string Filename);

// Export UGameplayEventsReader::execCloseStatsFile(FFrame&, void* const)
native function CloseStatsFile();

// Export UGameplayEventsReader::execSerializeHeader(FFrame&, void* const)
protected native function bool SerializeHeader();

event RegisterHandler(GameplayEventsHandler NewHandler)
{
    local int AddIndex;

    // End:0x89
    if(RegisteredHandlers.Find(NewHandler) == -1)
    {
        AddIndex = RegisteredHandlers.Length;
        RegisteredHandlers.Length = RegisteredHandlers.Length + 1;
        RegisteredHandlers[AddIndex] = NewHandler;
        NewHandler.SetReader(self);
    }
    //return;    
}

event UnregisterHandler(GameplayEventsHandler ExistingHandler)
{
    local int RemoveIndex;

    RemoveIndex = RegisteredHandlers.Find(ExistingHandler);
    // End:0x68
    if(RemoveIndex != -1)
    {
        RegisteredHandlers.Remove(RemoveIndex, 1);
        ExistingHandler.SetReader(none);
    }
    //return;    
}

// Export UGameplayEventsReader::execProcessStreamStart(FFrame&, void* const)
private native final function ProcessStreamStart();

// Export UGameplayEventsReader::execProcessStream(FFrame&, void* const)
native function ProcessStream();

// Export UGameplayEventsReader::execProcessStreamEnd(FFrame&, void* const)
private native final function ProcessStreamEnd();

// Export UGameplayEventsReader::execGetSessionID(FFrame&, void* const)
native function string GetSessionID();

// Export UGameplayEventsReader::execGetTitleID(FFrame&, void* const)
native function int GetTitleID();

// Export UGameplayEventsReader::execGetPlatform(FFrame&, void* const)
native function int GetPlatform();

// Export UGameplayEventsReader::execGetSessionTimestamp(FFrame&, void* const)
native function string GetSessionTimestamp();

// Export UGameplayEventsReader::execGetSessionStart(FFrame&, void* const)
native function float GetSessionStart();

// Export UGameplayEventsReader::execGetSessionEnd(FFrame&, void* const)
native function float GetSessionEnd();

// Export UGameplayEventsReader::execGetSessionDuration(FFrame&, void* const)
native function float GetSessionDuration();
