    //
    //  RatingsView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 20/12/22.
    //

import SwiftUI

struct RatingsView: View {
    @State var rating: Int = 0
    var body: some View {
        VStack {
            Text("Rate us 5 ⭐️")
                .font(.system(size: 20))
            starRatingView
                .overlay {
                    starOverlay
                        .mask(starRatingView)
                }
        }
    }
    
    var starOverlay: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.yellow)
                    .frame(width: geometry.size.width * CGFloat(rating) / 10)
            }
            .allowsHitTesting(false)
            
        }
        .allowsHitTesting(false)
    }
    
    var starRatingView: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .onTapGesture {
                        withAnimation {
                            rating = index * 2
                            if rating <= 2 {
                                HapticManager.shared.impact(type: .heavy)
                            } else if rating <= 4 {
                                HapticManager.shared.impact(type: .rigid)
                            } else if rating <= 6 {
                                HapticManager.shared.impact(type: .medium)
                            } else if rating <= 8 {
                                HapticManager.shared.impact(type: .light)
                            } else {
                                HapticManager.shared.impact(type: .soft)
                            }
                        }
                    }
            }
        }
        .frame(width: 250, height: 44)
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView()
    }
}
