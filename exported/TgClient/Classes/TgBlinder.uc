class TgBlinder extends Object
    native(GameUI);

// Export UTgBlinder::execDraw(FFrame&, void* const)
native function Draw(Canvas DestinationCanvas, float BlindnessFactor);
