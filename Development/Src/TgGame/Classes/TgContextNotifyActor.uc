class TgContextNotifyActor extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const CONTEXT_NOTIFY_ATTACK_SPECIALFX = 2928;

const CONTEXT_NOTIFY_DEFEND_SPECIALFX = 2929;

const CONTEXT_NOTIFY_BE_CAREFUL_SPECIALFX = 2930;

const CONTEXT_NOTIFY_PING_SPECIALFX = 2954;

native function SetContextNotifyType(int ContextId);  // Export UTgContextNotifyActor::execSetContextNotifyType(FFrame&, void* const)

defaultproperties
{
    LifeSpan=8000000.0000000
}
