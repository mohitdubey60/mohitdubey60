    //
    //  DeviceMotionSwiftUIView.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 14/07/23.
    //

import SwiftUI

struct DeviceMotionSwiftUIView: View {
    @ObservedObject var deviceMotionViewModel: DeviceMotionSwiftUIViewModel
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Image("ZSJL2")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 400)
                        .clipped()
                        .mask {
                            RoundedRectangle(cornerRadius: 20)
                        }
                        .shadow(color: Color(uiColor: .systemGray), radius: 12)
                    
                    Circle()
                        .fill(.white.opacity(0.7))
                        .blur(radius: 20, opaque: false)
                        .frame(maxWidth: 100)
                        .offset(x: getOffsetX(deviceMotionViewModel.accelerometerMotionValue.xAxis) * 5, y: getOffsetX(deviceMotionViewModel.accelerometerMotionValue.yAxis) * -10)
                }
                
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 10) {
                        Text("Action . Super hero . DC . Adventure")
                    }
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 12)
                    
                    HStack(spacing: 10) {
                        Button {
//                            deviceMotionViewModel.startMonitoringDeviceAccelerometerMotion()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Play")
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(Color(uiColor: .black))
                            .background(Color(uiColor: .white))
                            .frame(width: 150, height: 50)
                            .cornerRadius(12)
                        }
                        
                        
                        Button {
//                            deviceMotionViewModel.endMonitoringDeviceAccelerometerMotion()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("My List")
                                Spacer()
                            }
                            .padding()
                            .foregroundColor(Color(uiColor: .white))
                            .background(Color(uiColor: .black))
                            .frame(width: 150, height: 50)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }
                .shadow(color: .white, radius: 12)
                .padding()
                
            }
            .frame(maxWidth: 400)
            .padding()
            .offset(x: getOffsetX(deviceMotionViewModel.accelerometerMotionValue.xAxis), y: getOffsetX(deviceMotionViewModel.accelerometerMotionValue.yAxis) * -1)
            .rotation3DEffect(.degrees(getRotationAngle(deviceMotionViewModel.accelerometerMotionValue.xAxis)), axis: (x: 1, y: 1, z: 0))
            .animation(.linear, value: deviceMotionViewModel.accelerometerMotionValue)
            
            Spacer()
            
            ScrollView(.horizontal) {
                HStack {
                    Spacer()
                    VStack {
                        Text("Device Accelerometer")
                            .font(.title2)

                        Button("Start Monitor Device") {
                            deviceMotionViewModel.startMonitoringDeviceAccelerometerMotion()
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Stop Monitor Device") {
                            deviceMotionViewModel.endMonitoringDeviceAccelerometerMotion()
                        }
                        .buttonStyle(.borderedProminent)

                        Text("Acclerometer X \(String(format: "%.2f", deviceMotionViewModel.accelerometerMotionValue.xAxis))")
                        Text("Acclerometer Y \(String(format: "%.2f", deviceMotionViewModel.accelerometerMotionValue.yAxis))")
                        Text("Acclerometer Z \(String(format: "%.2f", deviceMotionViewModel.accelerometerMotionValue.zAxis))")
                    }
                    .frame(minWidth: 250)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.6), lineWidth: 4)
                    }
                    Spacer()
                    VStack {
                        Text("Device Gyro")
                            .font(.title2)

                        Button("Start Monitor Device") {
                            deviceMotionViewModel.startMonitoringDeviceGyroMotion()
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Stop Monitor Device") {
                            deviceMotionViewModel.endMonitoringDeviceGyroMotion()
                        }
                        .buttonStyle(.borderedProminent)

                        Text("Gyro X \("")")
                        Text("Gyro Y \("")")
                        Text("Gyro Z \("")")
                    }
                    .frame(minWidth: 250)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.6), lineWidth: 4)
                    }
                    Spacer()
                    VStack {
                        Text("Device Motion")
                            .font(.title2)

                        Button("Start Monitor Device") {
                            deviceMotionViewModel.startMonitoringDeviceGravityMotion()
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Stop Monitor Device") {
                            deviceMotionViewModel.endMonitoringDeviceGravityMotion()
                        }
                        .buttonStyle(.borderedProminent)

                        Text("Gravity X \("")")
                        Text("Gravity Y \("")")
                        Text("Gravity Z \("")")
                    }
                    .frame(minWidth: 250)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.6), lineWidth: 4)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .padding()
    }
    
    func getOffsetX(_ value: Double) -> CGFloat {
        return value * 20
    }
    
    func getOffsetY(_ value: Double) -> CGFloat {
        return value * 20
    }
    
    func getRotationAngle(_ value: Double) -> Double {
        return value * 5
    }
}

struct DeviceMotionSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceMotionSwiftUIView(deviceMotionViewModel: DeviceMotionSwiftUIViewModel())
    }
}
