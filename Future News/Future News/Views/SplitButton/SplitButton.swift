//
//  SplitButton.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct SplitButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 143, height: 35)
                        .foregroundStyle(.orange)
                    
                    CustomTrapezoid()
                        .rotationEffect(.degrees(180))
                        .frame(width: 95, height: 35)
                        .padding([.leading], 50)
                        .foregroundStyle(.black)
                    
                    Text("**Future  News**")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

#Preview {
    SplitButton {}
}
