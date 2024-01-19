//
//  AdvancedScrollView.swift
//  Future News
//
//  Created by Danya Denisiuk on 17.01.2024.
//

import SwiftUI

struct AdvancedScrollView<Content: View>: View {
    @Environment(\.screenSize) private var screenSize
    @State private var contentHeight: CGFloat = 0
    
    @Binding var scrollOffset: CGFloat
    
    @ViewBuilder var content: () -> Content

    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack {
                    ScrollView {
                        GeometryReader { insiderGeo in
                            Color
                                .clear
                                .frame(height: 0)
                                .preference(
                                    key: ViewOffsetKey.self,
                                    value: insiderGeo
                                        .frame(in: .named("scrollView"))
                                        .minY
                                )
                                .id("topSide")
                        }
                        
                        content()
                            .id("contentsId")
                            .background {
                                GeometryReader { contentGeo in
                                    Color.clear.preference(
                                        key: ViewHeightKey.self,
                                        value: contentGeo.size.height
                                    )
                                }
                            }
                    }
                    .scrollIndicators(.hidden)
                    .coordinateSpace(name: "scrollView")
                    .onPreferenceChange(ViewHeightKey.self) { value in
                        contentHeight = value
                    }
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        self.scrollOffset = min(
                            1,
                            max(0, -value / (contentHeight - geo.size.height))
                        )
                    }
                    
                    ZStack {
                        Button {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo("topSide", anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.foreground)
                                .frame(width: 55, height: 55)
                        }
                        .background {
                            Circle()
                                .fill(.newsRow)
                                .opacity(0.9)
                        }
                        .animation(.easeInOut, value: scrollOffset)
                    }
                    .animation(.default) { content in
                        content
                            .offset(y: scrollOffset == 1 ? 0 : 100)
                            .opacity(scrollOffset == 1 ? 1.0 : 0.0)
                    }
                    .frame(maxHeight: geo.size.height ,alignment: .bottom)
                }
            }
        }
    }
}
