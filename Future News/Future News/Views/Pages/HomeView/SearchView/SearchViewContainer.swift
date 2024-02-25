//
//  SearchViewContainer.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import SwiftUI

struct SearchViewContainer: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @State var showDestinationSearchView: Bool = false
    
    var body: some View {
        VStack {
            SearchView()
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        showDestinationSearchView.toggle()
                    }
                }
                .zIndex(1.0)
            
            Text("The quota has been exhausted!")
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.red)
                        .frame(width: 250, height: 40, alignment: .bottom)
                        .shadow(radius: 3)
                }
                .offset(y: newsVM.isFailedStatusCode ? 0 : -40)
                .animation(.bouncy(duration: 0.7), value: newsVM.isFailedStatusCode)
                .animation(.default) { content in
                    content
                        .frame(height: newsVM.isFailedStatusCode ? 15 : 0)
                        .opacity(newsVM.isFailedStatusCode ? 1.0 : 0.0)
                }
        }
        .sheet(isPresented: $showDestinationSearchView) {
            DestinationSearchView()
                .environmentObject(newsVM)
        }
    }
}

#Preview {
    SearchViewContainer()
        .environmentObject(NewsViewModel())
}
