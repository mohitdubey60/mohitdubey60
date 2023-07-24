    //
    //  DeviceMotionSwiftUIViewModel.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 14/07/23.
    //

import SwiftUI
import Combine

struct MotionValues: Equatable {
    var xAxis: Double
    var yAxis: Double
    var zAxis: Double
}

class DeviceMotionSwiftUIViewModel: NSObject, ObservableObject {
    @Published var accelerometerMotionValue: MotionValues = MotionValues(xAxis: 0, yAxis: 0, zAxis: 0)
    
    private var memoryAddress: String {
        String(format: "%p", self)
    }
    private var subscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override init() {
        super.init()        
    }
    
    func startMonitoringDeviceGravityMotion() {
        let motionPublisher = MotionManager.shared.startMonitorDeviceGravityMotion(for: memoryAddress)
        motionPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Received data")
                    case .failure(let error):
                        print("Error in device Motion \(error.localizedDescription)")
                }
            } receiveValue: { motion in
                if let motion {
                    print("Value of motion is X: \(motion.gravity.x), Y: \(motion.gravity.y), Z: \(motion.gravity.z)")
                }
            }
            .store(in: &subscribers)
    }
    
    func endMonitoringDeviceGravityMotion() {
        MotionManager.shared.endMonitorDeviceGravityMotion(for: memoryAddress)
    }
    
    func startMonitoringDeviceGyroMotion() {
        let motionPublisher = MotionManager.shared.startMonitorDeviceGyroMotion(for: memoryAddress)
        motionPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Received data")
                    case .failure(let error):
                        print("Error in device Motion \(error.localizedDescription)")
                }
            } receiveValue: { motion in
                if let motion {
                    print("Value of Gyro motion is X: \(motion.rotationRate.x), Y: \(motion.rotationRate.y), Z: \(motion.rotationRate.z)")
                }
            }
            .store(in: &subscribers)
    }
    
    func endMonitoringDeviceGyroMotion() {
        MotionManager.shared.endMonitorDeviceGyroMotion(for: memoryAddress)
    }
    
    func startMonitoringDeviceAccelerometerMotion() {
        let motionPublisher = MotionManager.shared.startMonitorDeviceAccelerometerMotion(for: memoryAddress)
        motionPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Received data")
                    case .failure(let error):
                        print("Error in device Motion \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] motion in
                if let motion {
                    print("Value of Gyro motion is X: \(motion.acceleration.x), Y: \(motion.acceleration.y), Z: \(motion.acceleration.z)")
                    self?.accelerometerMotionValue = MotionValues(xAxis: motion.acceleration.x,
                                                                  yAxis: motion.acceleration.y,
                                                                  zAxis: motion.acceleration.z)
                }
            }
            .store(in: &subscribers)
    }
    
    func endMonitoringDeviceAccelerometerMotion() {
        MotionManager.shared.endMonitorDeviceAccelerometerMotion(for: memoryAddress)
        accelerometerMotionValue = MotionValues(xAxis: 0,
                                                yAxis: 0,
                                                zAxis: 0)
    }

    deinit {
        MotionManager.shared.endMonitorDeviceGravityMotion(for: memoryAddress)
        MotionManager.shared.endMonitorDeviceGyroMotion(for: memoryAddress)
        
        for subs in subscribers {
            subs.cancel()
        }
    }
}
