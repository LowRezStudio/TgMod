class OnlineImageDownloaderWebHelper extends Object
    native;

// Export UOnlineImageDownloaderWebHelper::execLoadImageFromTempDir(FFrame&, void* const)
native static function bool LoadImageFromTempDir(const string Filename, out array<byte> ImageData);

// Export UOnlineImageDownloaderWebHelper::execSaveImageToTempDir(FFrame&, void* const)
native static function bool SaveImageToTempDir(const string Filename, const array<byte> ImageData);
