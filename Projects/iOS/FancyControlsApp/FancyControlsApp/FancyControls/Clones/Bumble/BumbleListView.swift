    //
    //  BumbleListView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 19/12/22.
    //

import SwiftUI

struct BumbleListView: View {
    @State var xOffset: CGFloat = 0
    @State var imageName: String = ""
    
    @State var isButtonVisble = false
    
    var body: some View {
        ZStack {
            ZStack {
                Image("parallexBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 600)
            }
            .frame(width: 300, height: 600)
            .cornerRadius(10)
            .offset(x: xOffset)
            .rotationEffect(Angle(degrees: getRotationAngle(x: xOffset)))
            .scaleEffect(1 - getScale(x: xOffset))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            xOffset = value.translation.width
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            xOffset = 0
                        }
                    })
            )
            
            bumbleButton
            
        }
    }
    
    var bumbleButton: some View {
        VStack {
            Circle()
                .fill(.white)
                .overlay {
                    Image(systemName: xOffset > 0 ? "checkmark" : "xmark")
                        .resizable()
                        .padding()
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 2)
                        }
                }
            
        }
        .scaleEffect(getButtonScale(scale: xOffset))
        .foregroundColor(.yellow)
        .frame(width: 80, height: 80)
        .offset(x: getButtonOffset(x: xOffset))
//        .opacity(isButtonVisble ? 1 : 0)
    }
    
    func getButtonScale(scale value: CGFloat) -> Double {
        if abs(value) * 2 < 400 {
            return Double(abs(value * 2)) / Double(400)
        } else {
            return 1
        }
    }
    
    func getButtonOffset(x offsetX: CGFloat) -> Double {
        if offsetX < 0 {
            isButtonVisble = true
            let result = Double(-300) + abs(offsetX)
            return result > 0 ? 0 : result
        } else if offsetX > 0 {
            isButtonVisble = true
            let result = Double(300) - abs(offsetX)
            return result < 0 ? 0 : result
        } else {
            isButtonVisble = false
            return 0
        }
    }
    
    func getRotationAngle(x value: CGFloat) -> Double {
        return Double(value) / 20
    }
    
    func getScale(x value: CGFloat) -> Double {
        return abs(xOffset * 0.0008)
    }
}

struct BumbleListView_Previews: PreviewProvider {
    static var previews: some View {
        BumbleListView()
    }
}
