//
//  XCTestCase+percySnapshot.swift
//  https://github.com/mfazekas/percy-ios-uitest-helpers/Swift/XCTestCase+percySnapshot.swift
//
//  Created by Miklos Fazekas on 30/10/16.
//  Copyright © 2016 Miklos Fazekas. All rights reserved.
//

import Foundation
import XCTest

@objc protocol XCTestCasePrivate {
    typealias ObjCBlock = @convention(block) ()->Void
    @objc func startActivity(withTitle: String!, block:ObjCBlock) -> Void;
}

extension XCTestCase {
    func percySnapshot(path: String) -> Void {
        let app = XCUIApplication()
        app.perform(Selector(("_waitForQuiescence")))
        (self as AnyObject).startActivity!(withTitle:"io.percy/\(path)", block:{() in
            app.perform(Selector(("_waitForQuiescence")))
        })
    }
}
