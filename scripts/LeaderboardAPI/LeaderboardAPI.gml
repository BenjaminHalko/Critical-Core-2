/// @desc Get the current leaderboards
function LeaderboardGet(_page=undefined) {
    if (global.gxGames) {
        gxc_challenge_get_global_scores(function(_status, _result) {
            if (_status == 200 and array_length(_result.data.scores) > 0) {
                var _pageData = _result.data.pagination;
                var _scores = _result.data.scores;
                
                if (_pageData.currPage == 0) {
                    scores = [];
                }
            
                for(var i = 0; i < array_length(_scores); i++) {
                    var _scoreData = _scores[i];
                    var _index = i + _pageData.currPage * _pageData.numPerPage;
                    array_push(scores, {
                        name: _scoreData.player.username,
                        points: _scoreData.score,
                        userID: _scoreData.player.userId
                    });
                }
                
                array_sort(scores, function(_ele1,_ele2){
                    return (_ele2.points - _ele1.points)
                });
                
                global.highscore = scores[0].points;
                
                if (_pageData.currPage+1 != _pageData.totalPages) {
                    LeaderboardGet(_pageData.currPage + 1);
                } else if (!oLeaderboardAPI.moved) {
                    PositionLeaderboard();
                }
            }
        }, {challengeId: GXG_CHALLENGE_ID, page: _page});
    } else
	   FirebaseRealTime(FIREBASE_LEADERBOARD_URL).Path("/").Read();
}

/// @desc Post a score to the leaderboards
/// @param {struct} score
function LeaderboardPost() {
	var _score = {
		name: global.username,
		points: global.score,
		level: global.round,
        userID: global.userID
	}
	
	if (_score.points > global.pb) {
		global.pb = _score.points;
		if (!global.noInternet)
			Save("score", "score", _score.points);
		oGUI.newPB = true;
	}
	with(oLeaderboardAPI) {
		var _index = array_find_index(scores, function(_val) {
            if (global.gxGames)
                return _val.userID == global.userID;
			return _val.name == global.username;
		});
		
		if _index == -1 or scores[_index].points < _score.points {
			if (_index == -1) array_push(scores, _score);
			else {
				scores[_index].points = _score.points;
				scores[_index].level = _score.level;
			}
			
			array_sort(scores, function(_ele1,_ele2) {
				return (_ele2.points - _ele1.points)
			});
			
			global.highscore = scores[0].points;
			
            if (global.gxGames) {
                gxc_challenge_submit_score(_score.points, LeaderboardGet, {challengeId: GXG_CHALLENGE_ID});
            } else if (!global.noInternet) {
    			FirebaseRealTime(FIREBASE_LEADERBOARD_URL).Path(_score.name).Set(json_stringify({
    				points: _score.points,
    				level: _score.level
    			}));
            }
		}
	}
}