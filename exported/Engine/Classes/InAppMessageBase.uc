class InAppMessageBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

enum EInAppMessageInterfaceDelegate
{
    IAMD_InAppSMSUIComplete,        // 0
    IAMD_InAppEmailComplete,        // 1
    IAMD_MAX                        // 2
};

// Export UInAppMessageBase::execInit(FFrame&, void* const)
native event Init();

// Export UInAppMessageBase::execShowInAppSMSUI(FFrame&, void* const)
native event bool ShowInAppSMSUI(optional string InitialMessage);

// Export UInAppMessageBase::execShowInAppEmailUI(FFrame&, void* const)
native event bool ShowInAppEmailUI(optional string InitialSubject, optional string InitialMessage);
