//
//  ImageViewModel.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
//

import Foundation
import FetchImage
import SwiftUI

//MARK: Nuke FetchImage Wrapper

public struct ImageView: View {
    @ObservedObject var image: FetchImage

    public var body: some View {
        ZStack {
          Rectangle()
            .fill(Color.gray)
            .posterStyle(loaded: false, size: .medium)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
              .posterStyle(loaded: true, size: .medium)
        }

        // (Optional) Animate image appearance
        .animation(.default)

        // (Optional) Cancel and restart requests during scrolling
        .onAppear(perform: image.fetch)
        .onDisappear(perform: image.cancel)
    }
}


struct PosterStyle: ViewModifier {
    public enum Size {
        case small, medium, big, tv
        
        func width() -> CGFloat {
            switch self {
            case .small: return 53
            case .medium: return 100
            case .big: return 250
            case .tv: return 333
            }
        }
        func height() -> CGFloat {
            switch self {
            case .small: return 80
            case .medium: return 150
            case .big: return 375
            case .tv: return 500
            }
        }
    }
    
    let loaded: Bool
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .frame(width: size.width(), height: size.height())
            .cornerRadius(5)
            .opacity(loaded ? 1 : 0.1)
            .shadow(radius: 8)
    }
}

extension View {
    func posterStyle(loaded: Bool, size: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(loaded: loaded, size: size))
    }
}
