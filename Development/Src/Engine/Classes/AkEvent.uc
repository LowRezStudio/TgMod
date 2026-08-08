class AkEvent extends AkBaseSoundObject
    native
    config(Engine);

var () AkBank RequiredBank;
var () AkEvent m_FirstPersonEvent;
var () AkEvent m_ShutdownEvent;
var () bool m_bIgnoreOcclusion;
var () bool m_bForce1pAnd3p;
