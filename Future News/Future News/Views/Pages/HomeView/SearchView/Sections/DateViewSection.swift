//
//  DateViewSection.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct DateViewSection: View {
    @Binding var selectedOption: DestinationSearchOptions
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            if selectedOption == .dates {
                Text("Selecting a time interval")
                    .padding(.top)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack {
                    DatePicker("From",
                               selection: $startDate,
                               in: ...endDate,
                               displayedComponents: .date)
                    
                    Divider()
                    
                    DatePicker("To",
                               selection: $endDate,
                               in: startDate...,
                               displayedComponents: .date)
                }
                .foregroundStyle(.gray)
                .font(.subheadline)
                .fontWeight(.semibold)
                
            } else {
                CollapsedPickerView(title: "When", description: "Add dates")
            }
        }
        .modifier(CollapsibleDestinationViewModifier())
        .frame(height: selectedOption == .dates ? 180 : 60)
        .onTapGesture {
            withAnimation(.snappy) {
                selectedOption = .dates
            }
        }
    }
}

#Preview {
    DateViewSection(selectedOption: .constant(.dates),
                    startDate: .constant(Date()),
                    endDate: .constant(Date()))
}
