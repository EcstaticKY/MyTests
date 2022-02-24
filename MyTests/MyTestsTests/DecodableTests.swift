//
//  DecodableTests.swift
//  MeBoxTests
//
//  Created by Kanyan Zheng on 2022/2/21.
//

import XCTest

struct InternalItem: Decodable, Equatable {
    let x: String
}

struct Item: Decodable, Equatable {
    let s: String
    let time: Date
    let items: [InternalItem]
    
    enum RootKeys: String, CodingKey {
        case s = "r"
        case newTime
        case items = "myItems"
    }
    
    enum NewTimeKeys: String, CodingKey {
        case time = "aTime"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        s = try container.decode(String.self, forKey: .s)
        items = try container.decode([InternalItem].self, forKey: .items)
        
        let timeContainer = try container.nestedContainer(keyedBy: NewTimeKeys.self, forKey: .newTime)
        time = try timeContainer.decode(Date.self, forKey: .time)
    }
    
    init(s: String, time: Date, items: [InternalItem]) {
        self.s = s
        self.time = time
        self.items = items
    }
}

class DecodableTests: XCTestCase {
    
    func test() {
        let items = makeItems()
        let data = try! JSONSerialization.data(withJSONObject: items.jsons)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decodedModels = try! decoder.decode([Item].self, from: data)
        XCTAssertEqual(decodedModels, items.models)
    }
    
    private func makeItems() -> (models: [Item], jsons: [[String: Any]]) {
        var items = (models: [Item](), jsons: [[String: Any]]())
        (0..<2).forEach { _ in
            let item = makeItem()
            items.models.append(item.model)
            items.jsons.append(item.json)
        }
        return items
    }
    
    private func makeItem() -> (model: Item, json: [String: Any]) {
        let time = Date(timeIntervalSince1970: 1644635317)
        let item = Item(s: UUID().uuidString, time: time, items: [InternalItem(x: "uu")])
        let json: [String: Any] = [
            "r": item.s,
            "s": "any",
            "newTime": [
                "aTime": time.ISO8601Format(),
                "timeInterval": time.timeIntervalSince1970
            ],
            "myItems": [
                [
                    "x": "uu"
                ]
            ]
        ]
        
        return (item, json)
    }
}
