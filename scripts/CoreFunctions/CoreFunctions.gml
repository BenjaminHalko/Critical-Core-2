function DamageCore() {
    live_auto_call
    
    audio_play_sound(snFireHit, 1, false);
    ScreenShake(20, 20);
    with(oCore) {
        bgFlash = 1;
        hp = max(0, hp-coreHPDamage());
        targetScale -= coreTotalDamage();
        hpWaitHeal = coreWaitToHeal();
        
        if (hp <= 0) {
            NextRound();
        }
    }
}