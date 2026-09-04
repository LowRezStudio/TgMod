class TgAIBehaviorAction_PurchaseBurnCards extends TgAIBehaviorAction
    hidecategories(Object)
    config(Engine);

var () int BurnCardId;
var () int DesiredRank;
var () bool bDontPay;

defaultproperties
{
    TitleName="PurchaseBurnCards"
    NodeToken=1048709
}
