//
//  GridPublishers.swift
//  Future News
//
//  Created by Danya Denisiuk on 13.12.2023.
//

import SwiftUI


extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color (red: red, green: green, blue: blue)
    }
}

struct SubjectChip: View {
    let subgject: String
    @State private var isTapped = false
    @State private var randomColor = Color.white.opacity(0.1)
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                isTapped.toggle()
                
                if isTapped {
                    randomColor = Color.random()
                } else {
                    randomColor = Color.white.opacity(0.1)
                }
            }
        } label: {
            Text(subgject)
                .padding(10)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isTapped ? randomColor : .white.opacity(0.1))
                }
                .fontWeight(.black)
                .fontDesign(.rounded)
        }
    }
}

struct SubjectView: View {
    let subjects = ["TSN.UA", "Wall Stree Journal", "BBC", "RBC", "Censor", "The New York", "Aljazeera", "CNN", "Washigton Post", "CNBC", "ABC News"]
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Programming Languages:")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 20)
                
                ForEach(subjects.indices, id: \.self) { index in
                    HStack {
                        ForEach(0..<3, id: \.self) { columnIndex in
                            let chipIndex = index * 4 + columnIndex
                            if chipIndex < subjects.count {
                                SubjectChip(subgject: subjects[chipIndex])
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SubjectView()
}

#Preview {
    SubjectChip(subgject: "Something")
}
