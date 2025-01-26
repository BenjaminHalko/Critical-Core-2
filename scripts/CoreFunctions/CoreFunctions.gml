function DamageCore() {
    audio_play_sound(snFireHit, 1, false);
    ScreenShake(20, 20);
    oBackground.bgFlash = 1;
    with(oCore) {
        
        hp = max(0, hp-coreHPDamage());
        targetScale -= coreTotalDamage();
        hpWaitHeal = coreWaitToHeal();
        
        if (hp <= 0) {
            NextRound();
        }
    }
}