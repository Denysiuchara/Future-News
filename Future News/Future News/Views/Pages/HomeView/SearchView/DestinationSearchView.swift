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
    @State private var isStartDateSelected = false
    @State private var isConditionMet = true
    @State private var selectedOption: DestinationSearchOptions = .text
    
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
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
                        withAnimation(.snappy) {
                            isShow.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    if !destination.isEmpty || !selectedPublishers.isEmpty {
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
                DateViewSection(isStartDateSelected: $isStartDateSelected,
                                selectedOption: $selectedOption,
                                startDate: $startDate,
                                endDate: $endDate)
                
                
                // MARK: - Publisher's selection
                NewsSourcesViewSection(selectedOption: $selectedOption,
                                       selectedPublishers: $selectedPublishers)
                .environmentObject(newsVM)
                
                Spacer()
                
                Button {
                    if !destination.isEmpty || !isStartDateSelected || !selectedPublishers.isEmpty {
                        isShowResultView.toggle()
                    } else {
                        withAnimation {
                            isConditionMet = false
                        }
                        heavyFeedback()
                        lightFeedback()
                    }
                } label: {
                    Text("Find")
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.horizontal)
                }
                .padding()
                .frame(width: 150, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.orange)
                        .shadow(radius: 5)
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
    
    /// Функция для создания сильного тактильного фидбека
    func heavyFeedback() {
        let heavyFeedback = UIImpactFeedbackGenerator(style: .heavy)
            heavyFeedback.prepare()
            heavyFeedback.impactOccurred()
    }

    /// Функция для создания слабого тактильного фидбека
    func lightFeedback() {
        let lightFeedback = UIImpactFeedbackGenerator(style: .light)
        lightFeedback.prepare()
            lightFeedback.impactOccurred()
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

