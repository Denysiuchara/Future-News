//
//  DestinationSearchView.swift
//  Future News
//
//  Created by Danya Denisiuk on 12.12.2023.
//

import SwiftUI

enum DestinationSearchOptions {
    case text
    case sources
    case dates
}

struct DestinationSearchView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @Binding var isShow: Bool
    
    @State private var isShowResultView = false
    @State private var selectedOption: DestinationSearchOptions = .text
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedPublishers: Set<String> = []
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.snappy) {
                        isShow.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                if !destination.isEmpty {
                    Button {
                        destination = ""
                        selectedPublishers = []
                        startDate = Date()
                        endDate = Date()
                    } label: {
                        Text("Clear All")
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            
            SearchViewSection(selectedOption: $selectedOption,
                              destination: $destination)
            
            // MARK: - Date selection
            DateViewSection(selectedOption: $selectedOption,
                            startDate: $startDate,
                            endDate: $endDate)
            
            
            // MARK: - Publisher's selection
            NewsSourcesViewSection(selectedOption: $selectedOption,
                                   selectedPublishers: $selectedPublishers)
            .environmentObject(newsVM)
            
            Spacer()
            
            Button {
                isShowResultView.toggle()
            } label: {
                Text("Find")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.horizontal)
            }
            .padding()
            .frame(width: 210, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange)
            }
            
            Spacer()
                .frame(height: 20)
        }
        .fullScreenCover(isPresented: $isShowResultView) {
            ResultView(destination: destination,
                       startDate: startDate,
                       endDate: endDate,
                       selectedPublishers: selectedPublishers)
            .environmentObject(newsVM)
        }
    }
}

struct CollapsibleDestinationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}

#Preview {
    DestinationSearchView(isShow: .constant(false))
        .environmentObject(NewsViewModel())
}
