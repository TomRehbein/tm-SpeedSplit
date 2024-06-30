void Main() {
}

void Render() {
}

void Update(float dt) {
    GameState::Update();
    RunManager::Update();
    CheckPoint::Update();
    Map::Update();
}