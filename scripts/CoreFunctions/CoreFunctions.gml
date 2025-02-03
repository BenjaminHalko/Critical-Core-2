function DamageCore() {
    audio_play_sound(snFireHit, 1, false);
    ScreenShake(10, 20);
    oBackground.bgFlash = 1;
    with(oCore) {
        if (targetScale < 0.4) {
            timeSinceLastPurple = 3;
            shootDir = random(360);
        }
        hp = max(0, hp-coreHPDamage());
        targetScale -= coreTotalDamage();
        hpWaitHeal = coreWaitToHeal();
        hpHit += coreHPDamage();
        
        if (hp <= 0) {
            NextRound();
        }
    }
}