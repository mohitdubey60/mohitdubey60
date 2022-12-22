//
//  InstagramCardView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 19/12/22.
//

import SwiftUI

struct InstagramCardView: View {
    @State var scaleEffectValue: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(1...10, id: \.self) { index in
                        VStack {
                            HStack {
                                Image("parallexBanner")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 24))
                                    .frame(width: 44, height: 44)
                            }
                            .padding(.bottom, 4)
                            Image("parallexBanner")
                                .resizable()
                                .frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).width * 9/16)
                                .scaledToFill()
                                .scaleEffect(1 + scaleEffectValue)
                                .gesture(
                                    MagnificationGesture()
                                        .onChanged({ scale in
                                            withAnimation {
                                                let sc = scale - 1
                                                if sc > 0 {
                                                    scaleEffectValue = sc
                                                }
                                            }
                                        })
                                        .onEnded({ value in
                                            withAnimation {
                                                scaleEffectValue = 0
                                            }
                                        })
                                )
                            
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                    .frame(width: 44, height: 44)
                                Image(systemName: "square.and.pencil")
                                    .frame(width: 44, height: 44)
                                Image(systemName: "square.and.arrow.up")
                                    .frame(width: 44, height: 44)
                                
                                Spacer()
                                Image(systemName: "bookmark")
                                    .frame(width: 44, height: 44)
                            }
                            .font(.system(size: 24))
                        }
                        Divider()
                    }
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct InstagramCardView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramCardView()
    }
}
