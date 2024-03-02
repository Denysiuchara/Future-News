//
//  SettingsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink {
                        AboutMeView()
                    } label: {
                        Label {
                            Text("About me!")
                        } icon: {
                            Image(systemName: "person")
                        }
                        
                    }
                } header: {
                    Text("Other")
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
