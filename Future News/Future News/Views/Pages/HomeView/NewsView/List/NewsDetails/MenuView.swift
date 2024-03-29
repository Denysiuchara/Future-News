//
//  MenuView.swift
//  Future News
//
//  Created by Danya Denisiuk on 19.01.2024.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var isCoppied: Bool
    var sourceURL: URL
    
    var body: some View {
        Menu {
            Button("Go to source", systemImage: "safari") { goToURL(sourceURL) }
            Button("Copy link", systemImage: isCoppied ? "doc" : "doc.fill") { copyLink() }
        } label: {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
    }
    
    func goToURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(sourceURL) {
            UIApplication.shared.open(sourceURL)
        }
    }
    
    func copyLink() {
        UIPasteboard.general.string = sourceURL.absoluteString
        withAnimation(.bouncy) {
            isCoppied.toggle()
        }
    }
}

#Preview {
    MenuView(isCoppied: .constant(false), sourceURL: URL(string: "https://www.facebook.com/pvkshid/posts/pfbid02QU2pc58hJowb1HBAXFUUNDSdL5oKVLxui6guLgRhSzVPgMzpxcXrLsvPhDWTpiqwl")!)
}
