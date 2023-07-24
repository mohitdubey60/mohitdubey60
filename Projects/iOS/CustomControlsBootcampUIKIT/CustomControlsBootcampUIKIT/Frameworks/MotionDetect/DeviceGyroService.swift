//
//  DeviceGyroService.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 15/07/23.
//

import Foundation
import Combine
import CoreMotion

class DeviceGyroService {
    unowned var motionManager: CMMotionManager
    
    private var isMonitoringDeviceMotion = false
    private var motionPublisher = PassthroughSubject<CMGyroData?, Error>()
    private var deviceMotionMonitorList: Set<String> = Set<String>()
    
    init(motionManager: CMMotionManager) {
        self.motionManager = motionManager
    }
    
    private func startMonitorDeviceMotion() {
        if  isMonitoringDeviceMotion ||
            motionManager.isGyroActive ||
            !motionManager.isGyroAvailable {
            motionPublisher.send(completion: .failure(DeviceMotionErrors.GyroNotAvailable))
            return
        }
        
        isMonitoringDeviceMotion = true
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: .main) {[weak self] gyroData, error in
            if let error {
                self?.isMonitoringDeviceMotion = false
                self?.motionPublisher.send(completion: .failure(error))
                return
            }
            
            self?.motionPublisher.send(gyroData)
        }
    }
    
    private func endMonitorDeviceMotion() {
        isMonitoringDeviceMotion = false
        motionManager.stopGyroUpdates()
    }
    
    func startMonitorDeviceMotion(for memoryAddress: String) -> PassthroughSubject<CMGyroData?, Error> {
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
