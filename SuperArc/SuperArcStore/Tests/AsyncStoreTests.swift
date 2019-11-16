//
//  Copyright © 2019 An Tran. All rights reserved.
//
@testable import SuperArcStore
import XCTest

class AsyncStoreTests: XCTestCase {

    var stores: [AsyncStore] = [
        AsyncStore(store: FilesystemStore(name: "Cache")),
    ]

    override func setUp() {
        super.setUp()

        for store in stores {
            do {
                try store.reset()

            } catch {
                XCTFail("can't reset store: \(store.name)")
            }
        }
    }

    func testReadUnknownKey() {
        iterateStores { store, finish in
            store.read("key") { result in
                do {
                    try result.get()

                } catch {
                    XCTFail("error: \(error) in store: \(store.name)")
                }

                finish()
            }
        }
    }

    func testDeleteUnknownKey() {
        iterateStores { store, finish in
            store.delete("key") { result in
                do {
                    try result.get()

                } catch {
                    XCTFail("error: \(error) in store: \(store.name)")
                }

                finish()
            }
        }
    }

//    func testWriteThenRead() {
//        iterateStores { store, finish in
//            let target = "value"
//
//            Promise {
//                store.write("key", value: target, continuation: $0)
//
//            }.thenOnSuccess { _ -> Promise<StoreValue?> in
//                return Promise { store.read("key", continuation: $0) }
//
//            }.thenOnSuccess { storeValue in
//                XCTAssertNotNil(storeValue)
//
//                let value = String(storeValue: storeValue!)
//                XCTAssertEqual(value, target)
//
//            }.thenOnFailure { error in
//                XCTFail("error: \(error) in store: \(store.name)")
//
//            }.finally { _ in
//                finish()
//            }
//        }
//    }

//    func testWriteThenDeleteThenRead() {
//        iterateStores { store, finish in
//            let target = "value"
//
//            Promise {
//                store.write("key", value: target, continuation: $0)
//
//            }.thenOnSuccess { _ -> Promise<Void> in
//                return Promise { store.delete("key", continuation: $0) }
//
//            }.thenOnSuccess { _ -> Promise<StoreValue?> in
//                return Promise { store.read("key", continuation: $0) }
//
//            }.finally { result in
//                do {
//                    let storeValue = try result.value()
//                    XCTAssertNil(storeValue)
//                } catch {
//                    XCTFail("error: \(error) in store: \(store.name)")
//                }
//
//                finish()
//            }
//        }
//    }

//    func testWriteThenDeleteThenWriteThenRead() {
//        iterateStores { store, finish in
//            let target1 = "value1"
//            let target2 = "value2"
//
//            Promise {
//                store.write("key", value: target1, continuation: $0)
//
//            }.thenOnSuccess { _ -> Promise<Void> in
//                return Promise { store.delete("key", continuation: $0) }
//
//            }.thenOnSuccess { _ -> Promise<Void> in
//                return Promise { store.write("key", value: target2, continuation: $0) }
//
//            }.thenOnSuccess { _ -> Promise<StoreValue?> in
//                return Promise { store.read("key", continuation: $0) }
//
//            }.finally { result in
//                do {
//                    let storeValue = try result.value()
//                    XCTAssertNotNil(storeValue)
//
//                    let value = String(storeValue: storeValue!)
//                    XCTAssertEqual(value, target2)
//                } catch {
//                    XCTFail("error: \(error) in store: \(store.name)")
//                }
//
//                finish()
//            }
//        }
//    }

    func testResetEmptyStores() {
        for store in stores {
            do {
                try store.reset()
            } catch {
                XCTFail("error: \(error) in store: \(store.name)")
            }
        }
    }

//    func testWriteThenReadThenResetThenRead() {
//        iterateStores { store, finish in
//            let target = "value"
//
//            Promise {
//                store.write("key", value: target, continuation: $0)
//
//            }.thenOnSuccess { _ -> Promise<StoreValue?> in
//                return Promise { store.read("key", continuation: $0) }
//
//            }.finally { result in
//                do {
//                    let value = try result.value()
//                    XCTAssertNotNil(value)
//                } catch {
//                    XCTFail("error: \(error) in store: \(store.name)")
//                }
//                finish()
//            }
//        }
//
//        for store in stores {
//            do {
//                try store.reset()
//            } catch {
//                XCTFail("error: \(error) in store: \(store.name)")
//            }
//        }
//
//        iterateStores { store, finish in
//
//            Promise {
//                store.read("key", continuation: $0)
//
//            }.finally { result in
//                do {
//                    let value = try result.value()
//                    XCTAssertNil(value)
//                } catch {
//                    XCTFail("error: \(error) in store: \(store.name)")
//                }
//                finish()
//            }
//        }
//    }

//    func testOverwrite() {
//        iterateStores { store, finish in
//            let target1 = "value1"
//            let target2 = "value2"
//
//            Promise {
//                store.write("key", value: target1, continuation: $0)
//
//            }.thenOnSuccess { _ -> Promise<Void> in
//                return Promise { store.write("key", value: target2, continuation: $0) }
//
//            }.thenOnSuccess { _ -> Promise<StoreValue?> in
//                return Promise { store.read("key", continuation: $0) }
//
//            }.finally { result in
//                do {
//                    let storeValue = try result.value()
//                    XCTAssertNotNil(storeValue)
//
//                    if storeValue != nil {
//                        let value = String(storeValue: storeValue!)
//                        XCTAssertEqual(value, target2)
//                    }
//                } catch {
//                    XCTFail("error: \(error) in store: \(store.name)")
//                }
//
//                finish()
//            }
//        }
//    }


    // MARK: Private helpers

    private func iterateStores(_ call: @escaping (AsyncStore, @escaping () -> Void) -> Void) {

        let expectation = self.expectation(description: "expectation")
        var i = 0

        func step() {
            if i < stores.count {
                call(stores[i], step)
                i += 1
            } else {
                expectation.fulfill()
            }
        }
        step()

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    private static func iterate(_ interval: CountableRange<Int>, finish: @escaping () -> Void, call: @escaping (Int, @escaping () -> Void) -> Void) {

        var i = interval.lowerBound

        func step() {
            if interval.contains(i) {
                let arg = i
                i = (i + 1)

                call(arg, step)
            } else {
                finish()
            }
        }
        step()
    }
}
