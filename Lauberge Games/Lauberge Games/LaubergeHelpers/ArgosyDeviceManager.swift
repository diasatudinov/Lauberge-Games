//
//  ArgosyDeviceManager.swift
//  Lauberge Games
//
//  Created by Dias Atudinov on 19.05.2025.
//


import UIKit

class ArgosyDeviceManager {
    static let shared = ArgosyDeviceManager()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
