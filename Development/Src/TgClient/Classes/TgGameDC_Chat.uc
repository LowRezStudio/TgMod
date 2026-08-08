class TgGameDC_Chat extends TgObject
    native(GameUI)
    config(Engine);

const PROCESS_MESSAGE_SECS = 2.0f;

enum TG_CHAT_PRIORITY {
    CHAT_PRIORITY_THROWAWAY,  // 0
    CHAT_PRIORITY_NORMAL,  // 1
    CHAT_PRIORITY_HIGH,  // 2
    CHAT_PRIORITY_INTERRUPT,  // 3
};

struct QueueMessage {
    var int Id;
    var TgGameDC_Chat.TG_CHAT_PRIORITY Priority;
    var bool bHasPlayedSound;
    var int VoicePackId;
    var int VoiceBotId;
    var int VoiceSkinId;
    var init string VoicePackCustomSuffix;
    var AkBaseSoundObject SoundObject;
    structdefaultproperties {}
};

struct MessageToken {
    var int msgId;
    var int MsgIdRed;
    var int MsgIdBlue;
    var init string Token;
    structdefaultproperties {}
};

var QueueMessage c_CurrentMessage;
var array<QueueMessage> c_QueuedMessages;
var float c_fProcessTime;
var array<TgChatData> c_DeferredMessages;
var array<MessageToken> m_MessageTokens;
var transient float m_fLastEnemyKilledAllyMessageTime;
var float m_fMinEnemyKilledAllyMessageTime;
var transient float m_fLastAllyKilledEnemyMessageTime;
var float m_fMinAllyKilledEnemyMessageTime;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Chat::execInitializeData(FFrame&, void* const)

native function AddChatMsg(string msg, string senderName, int nChannel, bool bIsFeedback, optional bool bIsVGS=false, optional int nMsgId=-1);  // Export UTgGameDC_Chat::execAddChatMsg(FFrame&, void* const)

native function AddLocalChatMsg(string msg, string senderName);  // Export UTgGameDC_Chat::execAddLocalChatMsg(FFrame&, void* const)

native function AddCombatMsg(string msg);  // Export UTgGameDC_Chat::execAddCombatMsg(FFrame&, void* const)

native function AddPopupMsg(string msg);  // Export UTgGameDC_Chat::execAddPopupMsg(FFrame&, void* const)

native function Update(float DeltaTime, optional bool bSkipCallback=false);  // Export UTgGameDC_Chat::execUpdate(FFrame&, void* const)

native function UpdateMessageSoundQueue();  // Export UTgGameDC_Chat::execUpdateMessageSoundQueue(FFrame&, void* const)

native function AddAlert(string Message);  // Export UTgGameDC_Chat::execAddAlert(FFrame&, void* const)

native function PlayMessageSound(int nMsgId, optional TgGameDC_Chat.TG_CHAT_PRIORITY ePriority=1);  // Export UTgGameDC_Chat::execPlayMessageSound(FFrame&, void* const)

native function PlayVGSSound(int nMsgId, int nPackId, int nBotId, int nSkinId, string customSuffix, optional int nSourcePlayerId=0);  // Export UTgGameDC_Chat::execPlayVGSSound(FFrame&, void* const)

native function PlayVGSPOTG(int nPackId, int nBotId, int nSkinId, string customSuffix);  // Export UTgGameDC_Chat::execPlayVGSPOTG(FFrame&, void* const)

native function PlayAnnouncerSound(int nMsgId);  // Export UTgGameDC_Chat::execPlayAnnouncerSound(FFrame&, void* const)

native function SubmitDeferredMessages(optional int nChannel=0);  // Export UTgGameDC_Chat::execSubmitDeferredMessages(FFrame&, void* const)

event string TokenReplace(string Message, string Token, string sValue) { }

defaultproperties
{
    m_MessageTokens[0]=(msgId=112949,MsgIdRed=112954,MsgIdBlue=112953,Token="`Yourteam")
    m_MessageTokens[1]=(msgId=112957,MsgIdRed=112955,MsgIdBlue=112958,Token="`Youhave")
    m_MessageTokens[2]=(msgId=112950,MsgIdRed=112960,MsgIdBlue=112959,Token="`Theenemy")
    m_MessageTokens[3]=(msgId=112952,MsgIdRed=112960,MsgIdBlue=112959,Token="`Your")
    m_MessageTokens[4]=(msgId=0,MsgIdRed=0,MsgIdBlue=0,Token="`CT")
    m_fMinEnemyKilledAllyMessageTime=5.0000000
    m_fMinAllyKilledEnemyMessageTime=5.0000000
}
