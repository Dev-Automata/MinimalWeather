//
// Created by Кирилл Михайлин on 20.11.2021.
//

import Foundation

@propertyWrapper
struct Storage<T> {

    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.string(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AppData {

    @Storage(key: K.StorageKeys.city, defaultValue: "")
    static var city: String

}