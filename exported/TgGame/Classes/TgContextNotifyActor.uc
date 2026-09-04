class TgContextNotifyActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

const CONTEXT_NOTIFY_ATTACK_SPECIALFX = 2928;
const CONTEXT_NOTIFY_DEFEND_SPECIALFX = 2929;
const CONTEXT_NOTIFY_BE_CAREFUL_SPECIALFX = 2930;
const CONTEXT_NOTIFY_PING_SPECIALFX = 2954;

// Export UTgContextNotifyActor::execSetContextNotifyType(FFrame&, void* const)
native function SetContextNotifyType(int ContextId);

defaultproperties
{
    LifeSpan=8000000.0000000
}