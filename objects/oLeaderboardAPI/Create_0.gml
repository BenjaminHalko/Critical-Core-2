/// @desc

scores = [];

draw = false;
scoreOffset = 0;
scoreOffsetTarget = 0;

scoresPerPage = 8;
disableSelect = false;

global.highscore = 0;
global.gxGames = true;
global.userID = "";

LeaderboardGet();

if (!global.gxGames)
    listener = FirebaseRealTime(FIREBASE_LEADERBOARD_URL).Path("/").Listener();
else {
    global.username = "Player";
    gxc_profile_get_info( function(_status, _result)
    {
       if (_status == 200)
       {
            global.userID = _result.data.userId;
            global.username = _result.data.username;
       }
    });

}