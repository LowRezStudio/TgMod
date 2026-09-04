class MicroTransactionBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

enum EMicroTransactionDelegate
{
    MTD_PurchaseQueryComplete,      // 0
    MTD_PurchaseComplete,           // 1
    MTD_MAX                         // 2
};

enum EMicroTransactionResult
{
    MTR_Succeeded,                  // 0
    MTR_Failed,                     // 1
    MTR_Canceled,                   // 2
    MTR_RestoredFromServer,         // 3
    MTR_MAX                         // 4
};

struct native PurchaseInfo
{
    var string Identifier;
    var string DisplayName;
    var string DisplayDescription;
    var string DisplayPrice;
    var string CurrencyType;

    structdefaultproperties
    {
        Identifier=""
        DisplayName=""
        DisplayDescription=""
        DisplayPrice=""
        CurrencyType=""
    }
};

var array<PurchaseInfo> AvailableProducts;
var string LastError;
var string LastErrorSolution;

// Export UMicroTransactionBase::execInit(FFrame&, void* const)
native event Init();

// Export UMicroTransactionBase::execQueryForAvailablePurchases(FFrame&, void* const)
native event bool QueryForAvailablePurchases();

// Export UMicroTransactionBase::execIsAllowedToMakePurchases(FFrame&, void* const)
native event bool IsAllowedToMakePurchases();

// Export UMicroTransactionBase::execBeginPurchase(FFrame&, void* const)
native event bool BeginPurchase(int Index);

// Export UMicroTransactionBase::execGetProductIndex(FFrame&, void* const)
native event int GetProductIndex(string Identifier);
