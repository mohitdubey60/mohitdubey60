//
//  AccelerometerService.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 15/07/23.
//

import Foundation
import CoreMotion
import Combine

class DeviceAccelerometerService {
    unowned var motionManager: CMMotionManager
    
    private var isMonitoringDeviceMotion = false
    private var motionPublisher = PassthroughSubject<CMAccelerometerData?, Error>()
    private var deviceMotionMonitorList: Set<String> = Set<String>()
    
    init(motionManager: CMMotionManager) {
        self.motionManager = motionManager
    }

    private func startMonitorDeviceMotion() {
        if  isMonitoringDeviceMotion ||
                motionManager.isAccelerometerActive ||
                !motionManager.isAccelerometerAvailable {
            motionPublisher.send(completion: .failure(DeviceMotionErrors.AccelerometerNotAvailable))
            return
        }
        
        isMonitoringDeviceMotion = true
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) {[weak self] acceleromerData, error in
            if let error {
                self?.motionPublisher.send(completion: .failure(error))
                self?.isMonitoringDeviceMotion = false
                return
            }
                
            self?.motionPublisher.send(acceleromerData)
        }
    }
    
    private func endMonitorDeviceMotion() {
        isMonitoringDeviceMotion = false
        motionManager.stopAccelerometerUpdates()
    }
    
    func startMonitorDeviceMotion(for memoryAddress: String) -> PassthroughSubject<CMAccelerometerData?, Error> {
        deviceMotionMonitorList.insert(memoryAddress)
        startMonitorDeviceMotion()
        return motionPublisher
    }
    
    func endMonitorDeviceMotion(for memoryAddress: String) {
        deviceMotionMonitorList.remove(memoryAddress)
        if deviceMotionMonitorList.count == 0 {
            endMonitorDeviceMotion()
        }
    }
}
