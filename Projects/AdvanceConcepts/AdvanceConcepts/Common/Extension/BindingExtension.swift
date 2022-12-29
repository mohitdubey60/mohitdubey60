//
//  CoreDataExtension.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 26/12/22.
//

import SwiftUI

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
