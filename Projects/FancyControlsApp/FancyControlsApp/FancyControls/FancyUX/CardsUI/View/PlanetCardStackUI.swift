    //
    //  PlanetCardStackUI.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 13/12/22.
    //

import SwiftUI

struct PlanetCardStackUI: View {
    @State var pacmanAnimate = false
    
    @State var lastCardWidthMultiplier: CGFloat = 0.3
    @State var lastCardOffset: CGFloat = -40
    @State var middleCardWidthMultiplier: CGFloat =  0.2
    @State var middleCardOffset: CGFloat = -20
    
    @State var isCardOpen = false
    
    @State var circle1XOffset: CGFloat = 150
    @State var circle1YOffset: CGFloat = 280
    @State var circle2XOffset: CGFloat = -150
    @State var circle2YOffset: CGFloat = -250
    @State var circle3XOffset: CGFloat = 100
    @State var circle3YOffset: CGFloat = -150
    @State var circle4XOffset: CGFloat = 200
    @State var circle4YOffset: CGFloat = -350
    @State var circle5XOffset: CGFloat = -100
    @State var circle5YOffset: CGFloat = 200
    
    @State var waterWaveHeight: CGFloat = 200
    @State var waveHeight: CGFloat? = nil
    @State var waveYOffset: CGFloat = 0
    
    @State var isDragging = false
    @State var viewState: CGSize = .zero
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                Spacer()
                cards
                    .frame(height: 300)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle(Text("Card Stack View"))
    }
}

struct PlanetCardStackUI_Previews: PreviewProvider {
    static var previews: some View {
        PlanetCardStackUI()
    }
}

extension PlanetCardStackUI {
    private func moveCircleOffset() {
        circle1XOffset = circle1XOffset * -1
        circle1YOffset = circle1YOffset * -1
        circle2XOffset = circle2XOffset * -1
        circle2YOffset = circle2YOffset * -1
        circle3XOffset = circle3XOffset * -1
        circle3YOffset = circle3YOffset * -1
        circle4XOffset = circle4XOffset * -1
        circle4YOffset = circle4YOffset * -1
        circle5XOffset = circle5XOffset * -1
        circle5YOffset = circle5YOffset * -1
    }
    
    private func expandCardStack(_ width: CGFloat) {
        lastCardWidthMultiplier = 0.1
        middleCardWidthMultiplier = 0.1
        let height = width  -  width * 0.4
        
        middleCardOffset = -1 * (height + 10)
        lastCardOffset = -1 * ((height * 2) + 20)
    }
    
    private func resetCardStack() {
        lastCardWidthMultiplier = 0.3
        middleCardWidthMultiplier = 0.2
        
        lastCardOffset = -40
        middleCardOffset = -20
    }
    
    private func moveWaveShapes() {
        waterWaveHeight = 400
        waveHeight = 200
        waveYOffset = -200
    }
    
    private func resetWaveShapes() {
        waterWaveHeight = 200
        waveHeight = nil
        waveYOffset = 0
    }
    
    private func dynamicBackgroundOnCardTap(_ width: CGFloat) {
        if isCardOpen {
            expandCardStack(width)
            moveCircleOffset()
            moveWaveShapes()
        } else {
            resetCardStack()
            moveCircleOffset()
            resetWaveShapes()
        }
    }
}

extension PlanetCardStackUI {
    var background: some View {
        ZStack {
            
            LinearGradient(colors: [.orange, .yellow, .blue, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                WaveShape()
                    .fill(LinearGradient(colors: [.blue, .cyan, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                
//                PacmanShape(mouthAngle: pacmanAnimate ? 20 : 0)
//                    .fill(.red)
//                    .frame(height: 50)
//                    .onAppear {
//                        withAnimation(Animation.easeIn(duration: 0.2).repeatForever()) {
//                            pacmanAnimate.toggle()
//                        }
//                    }
                
            }.frame(height: waveHeight)
            .offset(y: waveYOffset)
            .blur(radius: 5)
            
            VStack {
                Spacer()
                WaterShape()
                    .fill(LinearGradient(colors: [.green, .yellow, .brown], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: waterWaveHeight)
                    .blur(radius: 5)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
            ZStack {
                Circle()
                    .fill(RadialGradient(colors: [.pink, .blue], center: .center, startRadius: 0, endRadius: 200))
                    .frame(width: 200)
                    .offset(x: circle1XOffset, y: circle1YOffset)
                
                Circle()
                    .fill(RadialGradient(colors: [.yellow, .blue], center: .center, startRadius: 0, endRadius: 100))
                    .frame(width: 100)
                    .offset(x: circle2XOffset, y: circle2YOffset)
                
                Circle()
                    .fill(RadialGradient(colors: [.pink, .blue], center: .center, startRadius: 0, endRadius: 50))
                    .frame(width: 50)
                    .offset(x: circle3XOffset, y: circle3YOffset)
                
                Circle()
                    .fill(RadialGradient(colors: [.pink, .blue], center: .center, startRadius: 0, endRadius: 150))
                    .frame(width: 150)
                    .offset(x: circle4XOffset, y: circle4YOffset)
                
                Circle()
                    .fill(RadialGradient(colors: [.pink, .blue], center: .center, startRadius: 0, endRadius: 100))
                    .frame(width: 100)
                    .offset(x: circle5XOffset, y: circle5YOffset)
            }
            .blur(radius: 5)
        }
    }
}

extension PlanetCardStackUI {
    var cards: some View {
        GeometryReader { geometry in
            ZStack (alignment: .bottom) {
                let width = geometry.size.width
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 20)
                    
                    cardContent
                        .opacity(0.4)
                        .padding()
                }
                .frame(width: width - width * lastCardWidthMultiplier, height: width  - width * 0.4)
                .animation(isDragging ? .easeIn(duration: 0.8) : .spring())
                .offset(y: lastCardOffset)
                .offset(x: viewState.width, y: viewState.height)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 20)
                    
                    cardContent
                        .opacity(0.4)
                        .padding()
                }
                .frame(width: width - width * middleCardWidthMultiplier, height: width  - width * 0.4)
                .animation(isDragging ? .easeIn(duration: 0.6) : .spring())
                .offset(y: middleCardOffset)
                .offset(x: viewState.width, y: viewState.height)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 20)
                    cardContent
                        .opacity(0.4)
                        .padding()
                }
                .frame(width: width - width * 0.1, height: width  - width * 0.4)
                .offset(x: viewState.width, y: viewState.height)
                .animation(.spring())
                .gesture(DragGesture().onChanged({ value in
                    isDragging = true
                    viewState = value.translation
                }).onEnded({ _ in
                    isDragging = false
                    viewState = .zero
                }))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isCardOpen.toggle()
                        dynamicBackgroundOnCardTap(width)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    var cardContent: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.gray)
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                VStack {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 10)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 10)
                }
            }
            .padding(.top)
            
            Spacer()
            
            HStack {
                VStack {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                }
                
                VStack {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                }
                
                VStack {
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                    Capsule()
                        .fill(.gray)
                        .frame(height: 20)
                }
            }
            
            Spacer()
        }
    }
}
