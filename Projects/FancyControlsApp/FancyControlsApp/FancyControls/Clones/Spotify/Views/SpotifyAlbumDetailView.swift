    //
    //  SpotifyAlbumDetailView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 04/12/22.
    //

import SwiftUI

struct SpotifyAlbumDetailView: View {
    @State var viewWidth: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    @State var widthOfPlayButton: CGFloat = 240
    @State var isAppeared: Bool = false
    @State var navBarAlpha: CGFloat = 0
    private func setPlayButtonOffset(_ offset: CGFloat) -> CGFloat {
        if offset > -392 {
            return offset
        } else {
            return -392
        }
    }
    
    private func setPlayButtonWidth(_ offset: CGFloat) -> CGFloat {
        if offset > -202 {
            return 240
        } else if offset < -392 {
            return 50
        } else {
            let currentWidth = 392 - abs(offset)
            return 50 + currentWidth
        }
    }
    
    private func setNavigationBarAlpha() -> CGFloat {
        if widthOfPlayButton <= 100 && widthOfPlayButton >= 50 {
            let result = ((widthOfPlayButton - 50) / 5) * 0.1
            
            return result < 0 ? 0 : result
        }
        
        return 1
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                    //Layer 1
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    VStack {
                        Image("Diljit1")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                            .clipped()
                        
                        Text("G.O.A.T")
                            .font(.title)
                        Text("Singer: Diljit Dosanjh")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame(height: 400)
                    
                    Spacer()
                }
                
                    //Layer 2
                ScrollView {
                    GeometryReader {geometry -> AnyView? in
                        if isAppeared {
                            let offset = geometry.frame(in: .global).minY
                            DispatchQueue.main.async {
                                self.viewWidth = geometry.size.width
                                
                                scrollOffset = setPlayButtonOffset(offset)
                                let width = setPlayButtonWidth(offset)
                                
//                                if width == 50 {
//                                    withAnimation {
//                                        widthOfPlayButton = width
//                                    }
//                                } else if widthOfPlayButton == 50 {
//                                    withAnimation {
//                                        widthOfPlayButton = width
//                                    }
//                                } else {
                                    widthOfPlayButton = width
//                                }
                                
                                navBarAlpha = setNavigationBarAlpha()
                            }
                        }
                        
                        return nil
                    }
                    
                    VStack {
                        Spacer()
                            .frame(width: viewWidth, height: 400)
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 100)
                            .background(LinearGradient(colors: [.clear, .clear, .black], startPoint: .top, endPoint: .bottom))
                    }
                    .frame(height: 500)
                    .padding(.bottom, -10)
                    
                    
                    VStack {
                        ForEach(Range(1...20)) { index in
                            HStack {
                                HStack {
                                    ZStack {
                                        Image("Diljit1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                        .cornerRadius(10)
                                        
                                        Circle()
                                            .fill(.black.opacity(0.8))
                                            .frame(width: 30, height: 30)
                                            .overlay {
                                                Image(systemName: "play.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 15, height: 15)
                                                    .clipped()
                                            }
                                    }
                                        
                                    VStack(alignment: .leading) {
                                        Text("Song \(index)")
                                        Text("Singer: Diljit")
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Image(systemName: "ellipsis")
                            }
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                    .background(.black)
                    .padding(0)
                }
                
                    //Layer 3
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background {
                    LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all)
                            .opacity(navBarAlpha)
                    
                    LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all)
                        .opacity(1 - navBarAlpha)
                }
                
                    //Layer 4
                Button {
                    
                } label: {
                    VStack {
                        Spacer()
                            .frame(height: scrollOffset + 410)
                        HStack {
                            if widthOfPlayButton != 50 {
                                Text("PLAY")
                            } else {
                                Image(systemName: "play.fill")
                            }
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .background {
                            Color.green
                                .frame(width: widthOfPlayButton, height: 50)
                                .cornerRadius(25)
                                .shadow(radius: 10)
                        }
                    }
                }
                
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background {
                LinearGradient(colors: [.gray, .black, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                isAppeared = true
            }
        }
    }
}

struct SpotifyAlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyAlbumDetailView()
    }
}
