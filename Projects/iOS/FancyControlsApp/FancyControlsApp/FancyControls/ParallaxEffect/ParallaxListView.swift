    //
    //  ParallaxListView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 04/12/22.
    //

import SwiftUI

struct ParallaxListView: View {
    let articleContent1 =
"""
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum.

Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
"""
    
    let articleContent2 = """
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum.

Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum.

Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum.

Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
"""
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .top) {
                    GeometryReader { geometry  in
                        let minY = geometry.frame(in: .global).minY
                            //Banner image
                        if minY <= 0 {
                            Image("parallexBanner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(y: minY / 14)
                                .clipped()
                        } else {
                            Image("parallexBanner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height + minY)
                                .clipped()
                                .offset(y: -minY)
                        }
                        
                            //Title and Subtitle
                        VStack {
                            Spacer()
                                .frame(height: 430)
                            HStack(spacing: 0) {
                                Image("parallexBanner")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .clipped()
                                
                                HStack(spacing: 0) {
                                    VStack (alignment: .leading, spacing: 0) {
                                        Spacer()
                                        Text("Johne Doe")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text("author")
                                            .font(.title3)
                                        Spacer()
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .frame(height: 100)
                            .padding()
                            .background {
                                LinearGradient(colors: [Color(uiColor: UIColor.systemPink), .clear], startPoint: .top, endPoint: .bottom)
                                    .cornerRadius(10)
                            }
                            .shadow(color: Color(uiColor: UIColor.systemPink), radius: 20)
                            .padding(.horizontal)
                        }
                    }
                }
                .frame(height: 550)
                
                    //Content
                VStack(alignment: .leading) {
                    Text("Lorem ipsum dolor sit amet")
                        .font(.custom("AvenirNext-Bold", size: 30))
                        .lineLimit(nil)
                        .padding(.top, 10)
                    Text("3 min read • 22. November 2019")
                        .font(.custom("AvenirNext-Regular", size: 15))
                        .foregroundColor(.gray)
                    Text(articleContent1)
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .lineLimit(nil)
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                    //StoryPAge Image
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 300)
                        .overlay {
                            ImageContainerView(imageName: "parallexBanner")
                                .cornerRadius(10)
                                .clipped()
                        }
                    
                    Text(articleContent2)
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .lineLimit(nil)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                }
                .frame(width: 350)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageContainerView: View {
    var imageName: String
    var body: some View {
        Color.clear
            .overlay (
                //Parallax effect by changing the offset y
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geometry.size.height + 40)
                        .offset(y: -minY / 14)
                }
            )
            .clipped()
    }
}

struct ParallaxListView_Previews: PreviewProvider {
    static var previews: some View {
        ParallaxListView()
    }
}
