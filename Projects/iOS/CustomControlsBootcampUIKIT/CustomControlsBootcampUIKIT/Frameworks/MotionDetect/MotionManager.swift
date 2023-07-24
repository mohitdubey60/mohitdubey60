    //
    //  MotionService.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 14/07/23.
    //

import Foundation
import CoreMotion
import Combine

//Learn more at: https://www.advancedswift.com/get-motion-data-in-swift/
enum DeviceMotionErrors: Error {
    case deviceMotionNotAvailable
    case GyroNotAvailable
    case AccelerometerNotAvailable
}

class MotionManager {
    private let motionManager = CMMotionManager()
    private var gyroPublisher = PassthroughSubject<CMGyroData?, Error>()

    private let gravityService: DeviceGravityService
    private let gyroService: DeviceGyroService
    private let accelerometerService: DeviceAccelerometerService
    
    static let shared = MotionManager()
    init() {
        self.gravityService = DeviceGravityService(motionManager: motionManager)
        self.gyroService = DeviceGyroService(motionManager: motionManager)
        self.accelerometerService = DeviceAccelerometerService(motionManager: motionManager)
    }
    
    func startMonitorDeviceGravityMotion(for memoryAddress: String) -> PassthroughSubject<CMDeviceMotion?, Error> {
        return gravityService.startMonitorDeviceMotion(for: memoryAddress)
    }
    
    func endMonitorDeviceGravityMotion(for memoryAddress: String) {
        gravityService.endMonitorDeviceMotion(for: memoryAddress)
    }
    
    func startMonitorDeviceGyroMotion(for memoryAddress: String) -> PassthroughSubject<CMGyroData?, Error> {
        return gyroService.startMonitorDeviceMotion(for: memoryAddress)
    }
    
    func endMonitorDeviceGyroMotion(for memoryAddress: String) {
        gyroService.endMonitorDeviceMotion(for: memoryAddress)
    }
    
    func startMonitorDeviceAccelerometerMotion(for memoryAddress: String) -> PassthroughSubject<CMAccelerometerData?, Error> {
        return accelerometerService.startMonitorDeviceMotion(for: memoryAddress)
    }
    
    func endMonitorDeviceAccelerometerMotion(for memoryAddress: String) {
        accelerometerService.endMonitorDeviceMotion(for: memoryAddress)
    }
}
