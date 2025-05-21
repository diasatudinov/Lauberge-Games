import UIKit

class LaubergeDeviceManager {
    static let shared = LaubergeDeviceManager()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
