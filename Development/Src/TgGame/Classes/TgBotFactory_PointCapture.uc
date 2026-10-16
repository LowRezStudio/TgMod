class TgBotFactory_PointCapture extends TgBotFactory_Leashed
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement)
    config(Engine);

var transient TgCapturePoint m_CapturePoint;

native function BotDied(TgPawn Pawn, TgAIController aic);  // Export UTgBotFactory_PointCapture::execBotDied(FFrame&, void* const)

defaultproperties
{}
