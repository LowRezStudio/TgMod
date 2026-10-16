interface OnlineChatInterface extends Interface;

delegate OnChatMessage(int Channel, string Sender, string Message);

function AddChatMessageDelegate(delegate<OnChatMessage> ChatDelegate);

function ClearChatMessageDelegate(delegate<OnChatMessage> ChatDelegate);

function SendChatMessage(int Channel, string Message);

function NotifyTeamChange(QWord PlayerUID, byte TeamID);
