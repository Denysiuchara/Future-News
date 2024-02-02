//
//  CustomTabView.swift
//  Future News
//
//  Created by Danya Denisiuk on 27.01.2024.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        ("house.fill", "Home"),
        ("bookmark.fill", "Favorites"),
        ("gearshape", "Settings")
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 80)
                .foregroundStyle(Color(.secondarySystemBackground))
                .opacity(0.95)
                .shadow(radius: 4)
            
            HStack {
                ForEach(0..<tabBarItems.count) { index in
                    Button {
                        tabSelection = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            
                            Image(systemName: tabBarItems[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text(tabBarItems[index].title)
                                .font(.caption)
                            
                            if index + 1 == tabSelection {
                                Capsule()
                                    .frame(height: 5)
                                    .foregroundStyle(.red)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y: -3)
                            } else {
                                Capsule()
                                    .frame(height: 5)
                                    .foregroundStyle(.clear)
                                    .offset(y: -3)
                            }
                        }
                        .foregroundStyle(index + 1 == tabSelection ? .red : .gray)
                    }
                }
            }
            .frame(height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1))
}
