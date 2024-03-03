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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var newsVM: NewsViewModel
    
    /// Variable for calling ResultView
    @State private var isShowResultView = false
    
    /// Variable indicating whether the date is set
    @State private var isStartDateSelected = false
    
    /// Variable to invoke the alert.
    /// Describes whether the required fields are filled in.
    @State private var isConditionMet = true
    
    /// Responsible for the selected filter cell.
    @State private var selectedOption: DestinationSearchOptions = .text
    
    // MARK: - Storage property
    
    /// Storage for text field
    @State private var destination = ""
    
    /// Storage for Start DatePicker
    @State private var startDate = Date()
    
    /// Storage for End DatePicker
    @State private var endDate = Date()
    
    /// Storage for Selected Publishers
    @State private var selectedPublishers: Set<String> = []
    
    var body: some View {
        ZStack {
            Color
                .colorSet3
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                }
                .padding()
                
                SearchViewSection(selectedOption: $selectedOption,
                                  destination: $destination)
                
                // MARK: - Date selection
                DateViewSection(isStartDateSelected: $isStartDateSelected,
                                selectedOption: $selectedOption,
                                startDate: $startDate,
                                endDate: $endDate)
                
                
                // MARK: - Publisher's selection
                NewsSourcesViewSection(selectedOption: $selectedOption,
                                       selectedPublishers: $selectedPublishers)
                .environmentObject(newsVM)
                
                Spacer()
                
                PrepareSearchButton(destination: $destination,
                                    selectedPublishers: $selectedPublishers,
                                    startDate: $startDate,
                                    endDate: $endDate,
                                    isStartDateSelected: $isStartDateSelected,
                                    isShowResultView: $isShowResultView,
                                    isConditionMet: $isConditionMet)
                .environmentObject(newsVM)
                
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
            
            // MARK: - ALERT
            HStack {
                Text("First, set the parameters.")
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            .frame(height: 50)
            .background {
                VisualEffectView(style: .systemMaterial, alpha: 1.0)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
            }
            .offset(y: -100)
            .opacity(isConditionMet ? 0.0 : 1.0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .onChange(of: isConditionMet) { _, newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        isConditionMet = true
                    }
                }
            }
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
    DestinationSearchView()
        .environmentObject(NewsViewModel())
}

