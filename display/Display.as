namespace Display {
    void Render() {
        if (!UI::IsGameUIVisible()) return;

        auto app = cast<CTrackMania>(GetApp());
        if (app.Editor !is null) return;

        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoFocusOnAppearing;

        if (!UI::IsOverlayShown()) {
            windowFlags |= UI::WindowFlags::NoMove;
        }

        if (app.CurrentPlayground !is null) {
            UI::Begin("SpeedSplit", windowFlags);
            UI::BeginGroup();
            RenderHeader();
            RenderTable();
            UI::EndGroup(); 
            UI::End();
        }
    }

    void RenderHeader(bool showHeader = true, bool showSeparator = true) {
        if (!showHeader) return;

        UI::Text("SpeedSplit");
        if (showSeparator) {
            UI::Separator();
        }
    }

    void RenderTable() {
        UI::BeginTable("SpeedSplitTable", 3, UI::TableFlags::Resizable | UI::TableFlags::BordersInnerV | UI::TableFlags::NoHostExtendX | UI::TableFlags::NoPadOuterX | UI::TableFlags::NoBordersInBody | UI::TableFlags::NoBordersInBodyUntilResize);
        if (Map::pbSplits.Length == 0) {
            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("No splits found");
        } else {
            RenderSplits();
        }
        UI::EndTable();
    }

    void RenderSplits() {
        for (uint i = 0; i < Map::pbSplits.Length; i++) {
            uint currentSplit = 0;
            if (Map::currentSplits.Length > i) {
                currentSplit = Map::currentSplits[i];
            }
            RenderSplit(i + 1, currentSplit, Map::pbSplits[i]);
        }
    }

    void RenderSplit(uint splitIndex = 0, uint splitTime = 0, uint pbTime = 0) {
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text(splitIndex + ". CP");
        UI::TableNextColumn();
        UI::Text("" + splitTime);
        UI::TableNextColumn();
        UI::Text("" + pbTime);
    }
}