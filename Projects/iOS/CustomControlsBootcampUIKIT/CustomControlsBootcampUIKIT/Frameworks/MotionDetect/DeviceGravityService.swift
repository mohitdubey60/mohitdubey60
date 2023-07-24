//
//  DeviceGravityService.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 15/07/23.
//

import Foundation
import CoreMotion
import Combine


class DeviceGravityService {
    unowned var motionManager: CMMotionManager
    
    private var isMonitoringDeviceMotion = false
    private var motionPublisher = PassthroughSubject<CMDeviceMotion?, Error>()
    private var deviceMotionMonitorList: Set<String> = Set<String>()
    
    init(motionManager: CMMotionManager) {
        self.motionManager = motionManager
    }
    
    private func startMonitorDeviceMotion() {
        if isMonitoringDeviceMotion ||
           motionManager.isDeviceMotionActive ||
           !motionManager.isDeviceMotionAvailable {
            if !motionManager.isDeviceMotionAvailable {
                motionPublisher.send(completion: .failure(DeviceMotionErrors.deviceMotionNotAvailable))
            }
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        isMonitoringDeviceMotion = true
        motionManager.startDeviceMotionUpdates(to: .main) {[weak self] motion, error in
            if let error {
                self?.isMonitoringDeviceMotion = false
                self?.motionPublisher.send(completion: .failure(error))
                return
            }
            
            self?.motionPublisher.send(self?.motionManager.deviceMotion)
        }
    }
    
    private func endMonitorDeviceMotion() {
        isMonitoringDeviceMotion = false
        motionManager.stopDeviceMotionUpdates()
    }
    
    func startMonitorDeviceMotion(for memoryAddress: String) -> PassthroughSubject<CMDeviceMotion?, Error> {
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
