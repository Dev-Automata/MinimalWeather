//
// Created by Кирилл Михайлин on 20.11.2021.
//

import Foundation

protocol SettingsStorage {
    func loadSettings() -> String?
    func saveSettings(city: String)
}

class StorageService: SettingsStorage {

    private var storage = UserDefaults.standard
    private var storageKey = K.StorageKeys.city

    func loadSettings() -> String? {
        return storage.string(forKey: K.StorageKeys.city)
    }

    func saveSettings(city: String) {
        storage.set(city, forKey: K.StorageKeys.city)
    }
}
