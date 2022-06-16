//
//  BundleExtension.swift.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import Foundation

extension Bundle {
    func dataFromResource(_ resource: String) -> Data {
        guard let url = url(forResource: resource,
                                withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(resource) from bundle.")
        }
        return data
    }
}
