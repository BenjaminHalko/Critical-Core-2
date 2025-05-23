function GameStart() {
	instance_create_layer(room_width/2,room_height/2,"Core",oCore);
	global.lives = 3;
	global.score = 0;
	global.round = 1;
	global.inGame = true;
	global.nextRound = false;
	oGUI.newPB = false;
	Respawn();
    
    for(var i = 0; i < 5; i++) {
        var _dist = 25;
        var _dir = i * 360 / 5 + 90;
        with(instance_create_layer(oPlayer.x + lengthdir_x(_dist, _dir), oPlayer.y + lengthdir_y(_dist, _dir), "Bubbles", oBubble)) {
            mass = 150;
            if (i == 0) {
                state = BUBBLE_STATE.WEAPON;
            }
        }
    }
}

function GameEnd() {
	instance_destroy(oCore);
	instance_destroy(pEntity);
	LeaderboardPost();
    GotoLeaderboard();
}

function ReturnToMenu() {
	if (global.noInternet) {
		global.username = $"Player {array_length(oLeaderboardAPI.scores) + 1}";
		for(var i = 0; i < array_length(oLeaderboardAPI.scores); i++) {
			var _name = $"Player {i + 1}";
			for(var j = 0; j < array_length(oLeaderboardAPI.scores); j++) {
				if (oLeaderboardAPI.scores[j].name == _name) {
					_name = "";
					break;	
				}
			}
			
			if (_name != "") {
				global.username = _name;
				break;
			}
		}
	}
	global.inGame = false;
	global.gameOver = false;
	global.nextRound = false;
	global.roundIntro = false;
	oGUI.newPB = false;
	oGUI.moveTutorial = false;
	oGUI.alarm[1] = -1;
	instance_destroy(oCore);
	instance_destroy(pEntity);
	instance_destroy(oPlayerTrail);
	instance_destroy(oScore);
    with(oLeaderboardAPI) {
        draw = false;
    }
    
    if (!instance_exists(oMenu))
	   instance_create_layer(0, 0, "GUI", oMenu);
}

function Respawn() {
	instance_destroy(pEntity);
	instance_create_layer(room_width/2,0,"Player",oPlayer);
	RoundStart();
	global.gameOver = false;
}

function RoundStart() {
	global.nextRound = false;
	global.roundIntro = true;
	with (oCore) {
		playerHasMoved = false;
		shootDir = 0;
		flipShootDir = !flipShootDir;
	}
	call_later(global.gameOver ? 60 : 90, time_source_units_frames, function() {
		if (global.inGame) {
			global.roundIntro = false;
			if (!global.gameOver) oGUI.alarm[1] = 180;
		}
	})
	with(oCore) {
		targetScale = getCoreStart();
        hp = 1;
        hpHit = 0;
	}
}

function PositionLeaderboard() {
	with(oLeaderboardAPI) {
		var _index = array_find_index(scores, function(_val) {
			return _val.name == global.username;
		});
		
		if (_index != -1) {
			scoreOffsetTarget = max(0, min(_index-5, array_length(scores)-scoresPerPage));
			scoreOffset = scoreOffsetTarget;
		} else {
			scoreOffsetTarget = 0;
			scoreOffset = 0;
		}	
	}
}

function GotoLeaderboard() {
    with(oLeaderboardAPI) {
        moved = false;
        draw = true;
        disableSelect = true;
    }
	PositionLeaderboard();
}