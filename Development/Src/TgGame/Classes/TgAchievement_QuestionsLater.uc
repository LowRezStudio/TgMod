class TgAchievement_QuestionsLater extends TgAchievement
    native(Achievement)
    config(Engine);

var bool bTakenDamageYet;
var bool bHasHitAllEnemies;
var array<int> EnemyPawnsHit;
