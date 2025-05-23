import SwiftUI

class LaubergeAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [AchievementSG] = [
        AchievementSG(image: "achi1IconLauberge", achievedCount: 0, achievedMaxCount: 1, isAchieved: false),
        AchievementSG(image: "achi2IconLauberge", achievedCount: 0, achievedMaxCount: 1, isAchieved: false),
        AchievementSG(image: "achi3IconLauberge", achievedCount: 0, achievedMaxCount: 1, isAchieved: false),
        AchievementSG(image: "achi4IconLauberge", achievedCount: 0, achievedMaxCount: 1, isAchieved: false),
        AchievementSG(image: "achi5IconLauberge", achievedCount: 0, achievedMaxCount: 1, isAchieved: false)

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeySG"
    
    func achieveToggle(_ achive: AchievementSG) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    func achieveCheck(_ achive: AchievementSG) {
        guard let index = achievements.firstIndex(where: { $0.image == achive.image })
        else {
            return
        }
        
        if achievements[index].achievedCount < achievements[index].achievedMaxCount {
            achievements[index].achievedCount += 1
        } else {
            achievements[index].isAchieved = true
        }
    }
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([AchievementSG].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct AchievementSG: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var achievedCount: Int
    var achievedMaxCount: Int
    var isAchieved: Bool
}
