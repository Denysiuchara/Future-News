//
//  EmptyNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.12.2023.
//

import SwiftUI

struct EmptyNewsView: View {
    var body: some View {
        ScrollView {
            
            // TODO: - Add more information in CardView, and add destination to tap
            GeometryReader { geo in
                ZStack {
                    GradientView(cornerRadius: 20)
                        .opacity(0.6)
                        .frame(width: geo.size.width * 0.90, height: geo.size.height)
                }
                .frame(width: geo.size.width)
            }
            .frame(height: 300)
            
            
            HStack {
                GradientView(cornerRadius: 50)
                    .frame(width: 200, height: 50)
                    .padding(.horizontal, 4)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
            
            ForEach(0..<2) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.newsRow)
                        .opacity(0.3)
                        .frame(width: 300, height: 120)
                        .padding([.top], 20)
                        .padding([.leading], 50)
                        .padding([.trailing], 8)
                        .shadow(radius: 10)
                    
                    VStack {
                        HStack {
                            GradientView(cornerRadius: 12)
                                .frame(width: 100, height: 100)
                            
                            GradientView(cornerRadius: 20)
                                .frame(width: 200, height: 50, alignment: .topLeading)
                            
                        }
                        HStack {
                            Spacer()
                            
                            GradientView(cornerRadius: 10)
                                .frame(width: 100, height: 20, alignment: .leading)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        //        .background(.backround)
        
    }
}

#Preview {
    EmptyNewsView()
}
