//
//  TestingScrollView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI

struct TestingScrollView: View {
    var colors: [Color] = [.red, .yellow, .green, .yellow, .orange, .purple, .brown, .indigo, .gray,
                           .pink, .red, .yellow, .green, .yellow, .orange, .purple, .brown, .indigo,
                           .gray, .pink, .red, .yellow, .green, .yellow, .orange, .purple, .brown,
                           .indigo, .gray, .pink,]
    
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack {
                    ScrollView {
                        VStack {
                            GeometryReader { insiderGeo in
                                Color.clear.preference(key: ViewOffsetKey.self, value: insiderGeo.frame(in: .named("scrollView")).minY)
                            }
                            .frame(height: 0)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                                ForEach(colors.indices, id: \.self) { index in
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 180, height: 180)
                                        .foregroundStyle(colors[index])
                                        .opacity(0.9)
                                        .id(index)
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    .coordinateSpace(name: "scrollView")
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        self.scrollOffset = min(
                            1,
                            max(0, -value / (180 * CGFloat(colors.count) / 2 - geo.size.height))
                        )
                    }
                    
                    ZStack {
                        Group {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 40)
                                    .frame(width: 250, height: 55)
                                    .foregroundStyle(.white)
                                
                                HStack {
                                    Text("\(Int(scrollOffset * 100))%")
                                        .bold()
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.green)
                                        .frame(width: 150 * scrollOffset, height: 8)
                                        .animation(.easeIn, value: scrollOffset)
                                }
                                .padding(.leading, 20)
                                .opacity(scrollOffset > 0 && scrollOffset < 1 ? 1 : 0)
                            }
                        }
                        .opacity(scrollOffset > 0 ? 0.9 : 0)
                        
                        Button {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(0, anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .font(.title)
                                .bold()
                                .frame(width: 55, height: 55)
                        }
                        .offset(y: scrollOffset == 1 ? 0 : 100)
                        .animation(.easeInOut, value: scrollOffset)
                    }
                    .mask {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: scrollOffset > 0 && scrollOffset < 1 ? 250 : 55, height: 55)
                            .animation(.easeInOut, value: scrollOffset)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
    TestingScrollView()
}
