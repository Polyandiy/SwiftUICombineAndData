//
//  TrackableScrollView.swift
//  SwiftUICombineAnd Data
//
//  Created by Поляндий on 13.11.2023.
//

import SwiftUI

struct TrackableScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let offsetChanges: (CGPoint) -> Void
    let content: Content
    
    init(axes: Axis.Set = .vertical, offsetChanges: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.offsetChanges = offsetChanges
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axes) {
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in:
                        .named("scrollView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanges)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    
}
