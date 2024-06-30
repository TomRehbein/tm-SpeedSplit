namespace Checkpoint {
    uint preCPIdx = 0;

    void Update() {
        if (GameState::State != "game") return;

        auto app = GetApp();

        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        auto player = cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);

        MwFastBuffer<CGameScriptMapLandmark@> landmarks = playground.Arena.MapLandmarks;
        if(preCPIdx != player.CurrentLaunchedRespawnLandmarkIndex && landmarks.Length > player.CurrentLaunchedRespawnLandmarkIndex) {
			preCPIdx = player.CurrentLaunchedRespawnLandmarkIndex;
			auto landmark = landmarks[preCPIdx];
			if (landmark.Waypoint is null) {
				// print("START BLOCK TMNEXT");
			} else if (landmark.Waypoint.IsFinish || landmark.Waypoint.IsMultiLap) {
				// Map::HandleCheckpoint();
				// print("FINISH or MULTILAP BLOCK TMNEXT");
			} else {
				// Map::HandleCheckpoint();
			}
		}
    }

    void CheckPoint() {
        // checkpoint is reached. Get split time and update PB if needed
    }
}