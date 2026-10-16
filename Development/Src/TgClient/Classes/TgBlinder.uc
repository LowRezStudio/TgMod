class TgBlinder extends Object
    native(GameUI)
    config(Engine);

native function Draw(Canvas DestinationCanvas, float BlindnessFactor);  // Export UTgBlinder::execDraw(FFrame&, void* const)
