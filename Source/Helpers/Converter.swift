//
// Created by Кирилл Михайлин on 20.11.2021.
//

import Foundation

class Converter {

    static var shared: Converter = Converter()

    private init() {}

    /// Convert hectopascal to mmHg
    func convertPressure(hPa: Int) -> Int {
        let result = Double(hPa) / 1.3332239
        return Int(round(result))
    }
}
