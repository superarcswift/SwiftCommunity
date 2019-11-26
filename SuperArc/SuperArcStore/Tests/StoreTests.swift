//
//  Copyright © 2019 An Tran. All rights reserved.
//

@testable import SuperArcStore
import XCTest

class StoreTests: XCTestCase {

    private var storeSpecs: [StoreSpec] = [
        StoreSpec(store: MemoryStore(name: "Memory"), isTransient: true),
        StoreSpec(store: FilesystemStore(name: "Filesystem")),
    ]

    func testReadUnknownKey() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let storeValue = try store1.read("key")
                XCTAssertNil(storeValue)

                XCTAssertTrue(storeSpec.store(store1, hasKeys: []))

            } catch {
                XCTFail("error: \(error) in store: \(store1.name)")
            }
        }
    }

    func testDeleteUnknownKey() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                try store1.delete("key")

                XCTAssertTrue(storeSpec.store(store1, hasKeys: []))

            } catch {
                XCTFail("error: \(error) in store: \(store1.name)")
            }
        }
    }

    func testWriteThenRead() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let target = "value"

                try store1.write("key", value: target)

                let storeValue1 = try store1.read("key")
                XCTAssertNotNil(storeValue1)

                let value1 = String(storeValue: storeValue1!)
                XCTAssertEqual(value1, target)

                XCTAssertTrue(storeSpec.store(store1, hasKeys: ["key"]))

                let store2 = storeSpec.secondStore

                let storeValue2 = try store2.read("key")
                XCTAssertNotNil(storeValue2)

                let value2 = String(storeValue: storeValue2!)
                XCTAssertEqual(value2, target)

                XCTAssertTrue(storeSpec.store(store2, hasKeys: ["key"]))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    func testWriteThenDeleteThenRead() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let target = "value"

                try store1.write("key", value: target)
                try store1.delete("key")

                let storeValue1 = try store1.read("key")
                XCTAssertNil(storeValue1)

                XCTAssertTrue(storeSpec.store(store1, hasKeys: []))

                let store2 = storeSpec.secondStore

                let storeValue2 = try store2.read("key")
                XCTAssertNil(storeValue2)

                XCTAssertTrue(storeSpec.store(store2, hasKeys: []))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    func testWriteThenDeleteThenWriteThenRead() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let target1 = "value1"
                try store1.write("key", value: target1)

                try store1.delete("key")

                let target2 = "value2"
                try store1.write("key", value: target2)

                let storeValue1 = try store1.read("key")
                XCTAssertNotNil(storeValue1)

                let value1 = String(storeValue: storeValue1!)
                XCTAssertEqual(value1, target2)

                XCTAssertTrue(storeSpec.store(store1, hasKeys: ["key"]))

                let store2 = storeSpec.secondStore

                let storeValue2 = try store2.read("key")
                XCTAssertNotNil(storeValue2)

                let value2 = String(storeValue: storeValue2!)
                XCTAssertEqual(value2, target2)

                XCTAssertTrue(storeSpec.store(store2, hasKeys: ["key"]))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    func testOverwrite() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let target1 = "value1"
                try store1.write("key", value: target1)

                let target2 = "value2"
                try store1.write("key", value: target2)

                let storeValue1 = try store1.read("key")
                XCTAssertNotNil(storeValue1)

                let value1 = String(storeValue: storeValue1!)
                XCTAssertEqual(value1, target2)

                XCTAssertTrue(storeSpec.store(store1, hasKeys: ["key"]))

                let store2 = storeSpec.secondStore

                let storeValue2 = try store2.read("key")
                XCTAssertNotNil(storeValue2)

                let value2 = String(storeValue: storeValue2!)
                XCTAssertEqual(value2, target2)

                XCTAssertTrue(storeSpec.store(store2, hasKeys: ["key"]))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    func testMultiOverwrite() {
        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                func key(_ i: Int) -> String {
                    return "key_" + String(i)
                }
                for i in 0..<100 {
                    try store1.write(key(i % 10), value: Data(count: (i / 10 + 1) * 10))
                }

                for i in 0..<10 {
                    guard let value = try store1.read(key(i)) else {
                        XCTFail("expected non-nil value")
                        return
                    }
                    XCTAssertEqual(value.data.count, 100)
                }

                var keys = Set<String>()
                for i in 0..<10 {
                    keys.insert(key(i))
                }

                XCTAssertTrue(storeSpec.store(store1, hasKeys: keys))

                let store2 = storeSpec.secondStore

                for i in 0..<10 {
                    guard let value = try store2.read(key(i)) else {
                        XCTFail("expected non-nil value")
                        return
                    }
                    XCTAssertEqual(value.data.count, 100)
                }

                XCTAssertTrue(storeSpec.store(store2, hasKeys: keys))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    func testMultiWriteThenRead() {

        func indexed(_ name: String, _ i: Int) -> String {
            return name + "_" + String(i)
        }

        for storeSpec in storeSpecs {
            let store1 = storeSpec.firstStore
            do {
                let interval = 0..<10

                for i in interval {
                    try store1.write(indexed("key", i), value: indexed("value", i))
                }

                for i in interval {
                    let storeValue = try store1.read(indexed("key", i))
                    XCTAssertNotNil(storeValue)

                    let value = String(storeValue: storeValue!)
                    XCTAssertEqual(value, indexed("value", i))
                }

                var keys = Set<String>()
                for i in interval {
                    keys.insert(indexed("key", i))
                }
                XCTAssertTrue(storeSpec.store(store1, hasKeys: keys))

                let store2 = storeSpec.secondStore

                for i in interval {
                    let storeValue = try store2.read(indexed("key", i))
                    XCTAssertNotNil(storeValue)

                    let value = String(storeValue: storeValue!)
                    XCTAssertEqual(value, indexed("value", i))
                }

                XCTAssertTrue(storeSpec.store(store2, hasKeys: keys))

            } catch {
                XCTFail("error: \(error)")
            }
        }
    }

    // MARK: Internals

    private class StoreSpec {

        let ctor: () -> StoreProtocol
        let isTransient: Bool
        let supportsKeys: Bool
        var storedFirstStore: StoreProtocol?

        init(store: @autoclosure @escaping () -> StoreProtocol, isTransient: Bool = false, supportsKeys: Bool = false) {
            ctor = store
            self.isTransient = isTransient
            self.supportsKeys = supportsKeys
        }

        var firstStore: StoreProtocol {
            storedFirstStore = ctor()
            try! storedFirstStore!.reset()
            return storedFirstStore!
        }

        var secondStore: StoreProtocol {
            if isTransient {
                return storedFirstStore!
            } else {
                return ctor()
            }
        }

        func store(_ store: StoreProtocol, hasKeys keys: Set<String>) -> Bool {
            guard supportsKeys else {
                return true
            }
            return try! store.keys == keys
        }
    }

}
