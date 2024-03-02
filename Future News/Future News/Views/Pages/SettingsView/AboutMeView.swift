//
//  AboutMeView.swift
//  Future News
//
//  Created by Danya Denisiuk on 29.02.2024.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ZStack {
            Color
                .colorSet3
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hello, everyone!")
                        .font(.system(size: 40))
                        .bold()
                        .fontDesign(.rounded)
                    
                    Divider()
                    
                    Text("Thanks for trying out my app! This is an app I created to show off my skills. By making this app I have grown a lot as a programmer.")
                        .fontDesign(.rounded)
                    
                    Divider()
                    
                    Text("A little bit about me.")
                        .font(.system(size: 30))
                        .bold()
                        .fontDesign(.rounded)
                    VStack {
                        Image("my_photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("""
My name is Danya, I'm 21 years old and I'm an aspiring programmer.
I was born and live in Ukraine. I have a lot of hobbies, such as basketball, cooking, computer games, so I know what teamwork is. About my communication with people. I am quite sociable, I can find a common language with any person, but at the same time I am independent enough not to run to a middle developer every time I have a problem.
""")
                    .fontDesign(.rounded)
                    
                    Divider()
                    
                    Text("Contact:")
                        .font(.system(size: 30))
                        .bold()
                        .fontDesign(.rounded)
                    
                    HStack {
                        Image("github_logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        
                        Text("My GitHub:")
                            .fontDesign(.rounded)
                        
                        Button("https://github.com/Denysiuchara") {
                            goToURL("https://github.com/Denysiuchara")
                        }
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Image("facebook_logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        
                        Text("My FaceBook:")
                            .fontDesign(.rounded)
                        
                        Button("https://www.facebook.com/profile.php?id=100016582338639") {
                            goToURL("https://www.facebook.com/profile.php?id=100016582338639")
                        }
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Image("phone_logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        
                        Text("My Phone Number:")
                            .fontDesign(.rounded)
                        
                        Button("+380(98)647-54-67") {
                            call(to: "+380(98)647-54-67")
                        }
                        .lineLimit(1)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func goToURL(_ string: String) {
        guard let url = URL(string: string) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func call(to number: String) {
        guard let url = URL(string: "tel://\(number)") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


#Preview {
    AboutMeView()
}
