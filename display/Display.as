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
        UI::BeginTable("SpeedSplitTable", 2, UI::TableFlags::Resizable | UI::TableFlags::BordersInnerV | UI::TableFlags::NoHostExtendX | UI::TableFlags::NoPadOuterX | UI::TableFlags::NoBordersInBody | UI::TableFlags::NoBordersInBodyUntilResize);
        RenderSplit();
        UI::EndTable();
    }

    void RenderSplit() {
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("1. CP");
        UI::TableNextColumn();
        UI::Text("Time");
    }
}