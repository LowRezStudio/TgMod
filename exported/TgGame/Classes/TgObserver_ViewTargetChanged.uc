interface TgObserver_ViewTargetChanged extends Interface
    abstract
    native(View);

// Export UTgObserver_ViewTargetChanged::execOnViewTargetChanged(FFrame&, void* const)
native function OnViewTargetChanged(optional Actor aNewViewTarget);
