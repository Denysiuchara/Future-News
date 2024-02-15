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
                        } label: {
                            Text("Clear All")
                        }
                        .foregroundStyle(.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            
            // MARK: - Search
            VStack(alignment: .leading) {
                if selectedOption == .text {
                    Text("What we looking for?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        
                        TextField("Search destinations", text: $destination)
                            .fontDesign(.rounded)
                            .font(.subheadline)
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color(.systemGray4))
                    }
                } else {
                    CollapsedPickerView(title: "What we looking for?", description: "Add destination")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .text ? 120 : 60)
            .onTapGesture {
                withAnimation(.snappy) {
                    selectedOption = .text
                }
            }
            
            
            // MARK: - Date selection
            VStack(alignment: .leading) {
                if selectedOption == .dates {
                    Text("Selecting a time interval")
                        .padding(.top)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack {
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                        
                        Divider()
                        
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
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
            
            
            // MARK: - Publisher's selection
            VStack(alignment: .leading) {
                if selectedOption == .sources {
                    Text("Selecting publisher's")
                        .padding(.top)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    GridPublishers(selectedPublishers: $selectedPublishers)
                        .environmentObject(newsVM)
                } else {
                    CollapsedPickerView(title: "Who", description: "News Sources")
                }
            }
            .modifier(CollapsibleDestinationViewModifier())
            .frame(height: selectedOption == .sources ? 380 : 60)
            .onTapGesture {
                withAnimation(.snappy) {
                    selectedOption = .sources
                }
            }
            
            Spacer()
            
            Button {
                
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
