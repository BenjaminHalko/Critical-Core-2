/// @desc

scores = [];

draw = false;
scoreOffset = 0;
scoreOffsetTarget = 0;

scoresPerPage = 8;
disableSelect = false;

global.highscore = 0;
global.gxGames = !is_undefined(gxc_get_query_param("game"));
global.userID = "";

if (!global.gxGames) {
    LeaderboardGet();
    listener = FirebaseRealTime(FIREBASE_LEADERBOARD_URL).Path("/").Listener();
    room_goto_next();
} else {
    gxc_profile_get_info(function(_status, _result)
    {
        if (_status == 200)
        {
            global.userID = _result.data.userId;
            global.username = _result.data.username;
        } else {
            listener = FirebaseRealTime(FIREBASE_LEADERBOARD_URL).Path("/").Listener();
            global.gxGames = false;
        }
        
        LeaderboardGet();
        room_goto_next();
    });
}