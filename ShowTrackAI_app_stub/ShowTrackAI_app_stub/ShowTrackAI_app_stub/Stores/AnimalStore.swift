//
//  AnimalStore.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

import Foundation
import Combine

final class AnimalStore: ObservableObject {
    @Published var animals: [Animal] = [
        .init(name: "Bella", breed: "Angus"),
        .init(name: "Max",   breed: "Hereford")
    ]
}
