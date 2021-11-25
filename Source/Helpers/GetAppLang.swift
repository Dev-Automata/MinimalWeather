//
// Created by Кирилл Михайлин on 26.11.2021.
//

import Foundation

/// Get preferred language
func getAppLang(_ defaultLang: String) -> String {
    let appLangs = Locale.preferredLanguages.first
    if let firstLang = appLangs?.split(separator: "-").first  {
        return String(firstLang)
    }

    return defaultLang
}