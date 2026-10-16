class GFxFSCmdHandler_Kismet extends GFxFSCmdHandler
    native(UISequence);

// Export UGFxFSCmdHandler_Kismet::execFSCommand(FFrame&, void* const)
native event bool FSCommand(GFxMoviePlayer Movie, GFxEvent_FSCommand Event, string Cmd, string Arg);
