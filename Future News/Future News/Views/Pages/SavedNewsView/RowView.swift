//
//  RowView.swift
//  Future News
//
//  Created by Danya Denisiuk on 13.02.2024.
//

import SwiftUI

struct RowView: View {
    @State var item: NewsEntity
    var rowViewOrientation: RowViewOrientation
    
    var body: some View {
        switch rowViewOrientation {
        case .vertical:
            VerticalViewRow(item: item)
        case .horizontal:
            HorizontalViewRow(item: item)
        }
    }
    
    enum RowViewOrientation {
        case vertical
        case horizontal
    }
}


fileprivate struct VerticalViewRow: View {
    @State var item: NewsEntity
    
    var body: some View {
        HStack {
            AsyncImage(url: item.imageURL_) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 10)
                    .frame(width: 90, height: 90)
                    .clipped()
            } placeholder: {
                Image("news-placeholder")
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 10)
                    .frame(width: 90, height: 90)
                    .clipped()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(item.title_)
                    .lineLimit(1)
                    .font(.system(size: 23))
                    .bold()
                    
                Text(item.text_)
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .lineLimit(2)
                
                Text(item.publishDate_.publishingDifference())
                    .font(.system(size: 15))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 7)
                .fill(.colorSet3)
                .shadow(radius: 3)
        }
    }
}


fileprivate struct HorizontalViewRow: View {
    @State var item: NewsEntity
    
    var body: some View {
        VStack {
            AsyncImage(url: item.imageURL_) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 10)
                    .frame(width: optimizeForDevice(iphone: 100,
                                                    ipad: 250),
                           height: optimizeForDevice(iphone: 80,
                                                     ipad: 170))
                    .padding(.horizontal)
                    .clipped()
            } placeholder: {
                Image("news-placeholder")
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 10)
                    .frame(width: optimizeForDevice(iphone: 100,
                                                    ipad: 250),
                           height: optimizeForDevice(iphone: 80,
                                                     ipad: 170))
                    .padding(.horizontal)
                    .clipped()
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                Text(item.title_)
                    .lineLimit(1)
                    .font(.system(size: 23))
                    .bold()
                    
                Text(item.text_)
                    .fontWeight(.medium)
                    .font(.system(size: 17))
                    .lineLimit(2)
                    .padding(.top, 2)
                
                Text(item.publishDate_.publishingDifference())
                    .font(.system(size: 15))
                    .padding(.top, 2)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 7)
                .fill(.colorSet3)
                .shadow(radius: 3)
        }
    }
    
    private func optimizeForDevice<T>(iphone: T, ipad: T) -> T {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return iphone
        default:
            return ipad
        }
    }
}
