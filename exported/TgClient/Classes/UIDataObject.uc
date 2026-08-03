class UIDataObject extends UIData
    native(UIData);

const UIDATA_DECKSET = 54;
const UIDATA_CARDPROP = 1710;
const UIDATA_DECKNAME = 1783;
const UIDATA_DECKPROP = 1784;
const UIDATA_DECKSIZE = 5;
const UIDATA_ACTIVESET = 5;
const UIDATA_NUMTEMPLATEDECKS = 1;
const UIDATA_MAXCUSTOMDECKS = 5;
const UIDATA_NUMTALENTS = 3;
const UIDATA_GROUPSIZE = 4;
const UIDATA_BURNSIZE = 3;
const UIDATA_SETSIZE = 3;
const ITEM_TENCENT_FILLER = 19094;

enum UICardDeckType
{
    UIDT_OWNED,                     // 0
    UIDT_LOCKED,                    // 1
    UIDT_INDECK,                    // 2
    UIDT_POINTS,                    // 3
    UIDT_MAX                        // 4
};

struct native ItemGroup
{
    var int nId[4];
    var UIDataItem pItem;

    structdefaultproperties
    {
        nId[0]=0
        nId[1]=0
        nId[2]=0
        nId[3]=0
        pItem=none
    }
};

struct native UIDataDeck
{
    var int nId;
    var bool bTemplate;
    var init string sName;
    var init string sDesc;
    var int nDevice[5];

    structdefaultproperties
    {
        nId=0
        bTemplate=false
        sName=""
        sDesc=""
        nDevice[0]=0
        nDevice[1]=0
        nDevice[2]=0
        nDevice[3]=0
        nDevice[4]=0
    }
};

struct native ProductInfo
{
    var string ProductID;
    var string ProductName;
    var string ProductDescription;
    var string ProductImage;
    var string DisplayListPrice;
    var string DisplayPrice;
    var float ListPrice;
    var float Price;
    var string CurrencyCode;
    var string SignedOffer;

    structdefaultproperties
    {
        ProductID=""
        ProductName=""
        ProductDescription=""
        ProductImage=""
        DisplayListPrice=""
        DisplayPrice=""
        ListPrice=0.0000000
        Price=0.0000000
        CurrencyCode=""
        SignedOffer=""
    }
};
