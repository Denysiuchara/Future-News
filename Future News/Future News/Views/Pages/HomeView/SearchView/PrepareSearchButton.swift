//
//  PrepareSearchButton.swift
//  Future News
//
//  Created by Danya Denisiuk on 26.02.2024.
//

import SwiftUI

struct PrepareSearchButton: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    /// Storage for text field
    @Binding var destination: String
    
    /// Storage for Selected Publishers
    @Binding var selectedPublishers: Set<String>
    
    /// Storage for Start DatePicker
    @Binding var startDate: Date
    
    /// Storage for End DatePicker
    @Binding var endDate: Date
    
    /// Variable indicating whether the date is set
    @Binding var isStartDateSelected: Bool
    
    /// Variable for calling ResultView
    @Binding var isShowResultView: Bool
    
    /// Variable to invoke the alert.
    /// Describes whether the required fields are filled in.
    @Binding var isConditionMet: Bool
    
    /// Defines whether the button is pressed or not.
    @State private var wasPressedToButton: Bool = false
    
    /// Logic for the "if-else" inside the button.
    private var conditionForButton: Bool {
        // Если все поля заполнены
        (!destination.isEmpty && !isStartDateSelected && !selectedPublishers.isEmpty)
        
        // Если заполнена поисковая строка и выбрана дата
            || (!destination.isEmpty && !isStartDateSelected)
        
        // Если заполнена поисковая строка и выбраны источники
            || (!destination.isEmpty && !selectedPublishers.isEmpty)
    }
    
    var body: some View {
        Button {
            if conditionForButton {
                withAnimation {
                    adjustedFetch()
                    wasPressedToButton = true
                }
                lightFeedback()
            } else {
                withAnimation {
                    isConditionMet = false
                }
                heavyFeedback()
            }
        } label: {
            if wasPressedToButton {
                HStack {
                    Text("Matching search...")
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 17))
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.leading)
                }
                .frame(width: 200, height: 30, alignment: .center)
            } else {
                Text("Find")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.horizontal)
                    .frame(width: 130, height: 30, alignment: .center)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange)
                .shadow(radius: 5)
        }
        .onChange(of: newsVM.isNewDataLoaded) { _, newValue in
            if newValue == false {
                isShowResultView.toggle()
                wasPressedToButton = false
            }
        }
    }
    
    /// Функция для создания сильного тактильного фидбека
    private func heavyFeedback() {
        let heavyFeedback = UIImpactFeedbackGenerator(style: .heavy)
        heavyFeedback.prepare()
        heavyFeedback.impactOccurred()
    }
    
    /// Функция для создания слабого тактильного фидбека
    private func lightFeedback() {
        let lightFeedback = UIImpactFeedbackGenerator(style: .light)
        lightFeedback.prepare()
        lightFeedback.impactOccurred()
    }
    
    private func adjustedFetch() {
        newsVM
            .fetchNews(
                with: [
                    .text : destination,
                    .sort: "publish-time",
                    .latestPublishDate : endDate.convertToString(),
                    .earliestPublishDate : startDate.convertToString(),
                    .newsSources : selectedPublishers.map { "https://www.\($0)" }.joined(separator: ",")
                ],
                isCustomDate: true)
    }
}

#Preview {
    PrepareSearchButton(destination: .constant("Some Text"),
                        selectedPublishers: .constant([]),
                        startDate: .constant(Date()),
                        endDate: .constant(Date()),
                        isStartDateSelected: .constant(false),
                        isShowResultView: .constant(false),
                        isConditionMet: .constant(true))
        .environmentObject(NewsViewModel())
}
