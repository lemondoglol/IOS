//
//  Document.swift
//  circles
//
//  Created by Admin on 3/29/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit

// retrieve contents from CircleContainer
class Document: UIDocument {
    
    var container: CircleContainer?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return container?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let data = contents as? Data {
            container = CircleContainer(json: data)
        }
    }
}

