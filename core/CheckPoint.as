namespace CheckPoint {
    uint preCPIdx = 0;

    void Update() {
        if (GameState::State != "game") return;

        auto app = GetApp();
        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        if (playground is null) return;

        auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
        if (player is null) return;


        MwFastBuffer<CGameScriptMapLandmark@> landmarks = playground.Arena.MapLandmarks;
        if(preCPIdx != player.CurrentLaunchedRespawnLandmarkIndex && landmarks.Length > player.CurrentLaunchedRespawnLandmarkIndex) {
			preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
			auto landmark = landmarks[preCPIdx];
			if (landmark.Waypoint is null) {
                return;
			} 
            
            if (landmark.Waypoint.IsFinish) {
                Finish();
			} else {
                CheckPoint();
            }
		}
    }

    void CheckPoint() {
        // checkpoint is reached. Get split time and update PB if needed
        print("Checkpoint reached");
    }

    void Finish() {
        // finish is reached. Get total time and update PB if needed
        print("Finish reached");
    }
}