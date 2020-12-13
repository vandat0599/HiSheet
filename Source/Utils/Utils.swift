//
//  Utils.swift
//  HiSheet
//
//  Created by Đạt on 12/14/20.
//

import Foundation

class Utils {
    static var resourcesBundle: Bundle? = {
        Bundle(url: URL(fileURLWithPath: Bundle(for: LottieSheetViewController.self).path(forResource: "HiSheet", ofType: "bundle")!))
    }()
}
