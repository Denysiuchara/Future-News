//
//  SettingsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct SettingsView: View {
    // TODO: Add theme toggle
    @State private var isDark = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink("Notification setting") {
                        // TODO: - Add Notification
                    }
                    
                    Toggle(isDark ? "Dark Theme" : "Light theme", isOn: $isDark)
                    
                    NavigationLink("Change news language") {
                        // TODO: - Add choice news language
                    }
                    
                } header: {
                    Label {
                        Text("Environment Setting")
                    } icon: {
                        Image(systemName: "pencil.circle.fill")
                    }
                } footer: {
                    Divider()
                }

                
                Section {
                    NavigationLink {
                        // TODO: - Add an introduction
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
