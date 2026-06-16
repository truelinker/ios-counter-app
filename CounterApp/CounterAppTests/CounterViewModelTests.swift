import XCTest
@testable import CounterApp

final class CounterViewModelTests: XCTestCase {

    func testStartsAtZero() {
        let sut = CounterViewModel()
        XCTAssertEqual(sut.count, 0)
    }

    func testIncrementIncreasesCount() {
        let sut = CounterViewModel()
        sut.increment()
        XCTAssertEqual(sut.count, 1)
        sut.increment()
        XCTAssertEqual(sut.count, 2)
    }

    func testDecrementDecreasesCount() {
        let sut = CounterViewModel(count: 3)
        sut.decrement()
        XCTAssertEqual(sut.count, 2)
    }

    func testReset() {
        let sut = CounterViewModel(count: 5)
        sut.reset()
        XCTAssertEqual(sut.count, 0)
    }

    func testDecrementNeverGoesBelowZero() {
        let sut = CounterViewModel()
        XCTAssertEqual(sut.count, 0)
        sut.decrement()
        XCTAssertEqual(sut.count, 0, "Count must not go below zero")
        sut.decrement()
        XCTAssertEqual(sut.count, 0, "Repeated decrements must stay clamped at zero")
    }

    func testDoubleCount() {
        let zero = CounterViewModel()
        zero.doubleCount()
        XCTAssertEqual(zero.count, 0, "Doubling zero stays at zero")

        let three = CounterViewModel(count: 3)
        three.doubleCount()
        XCTAssertEqual(three.count, 6, "Doubling 3 yields 6")

        let sut = CounterViewModel(count: 5)
        sut.reset()
        sut.doubleCount()
        XCTAssertEqual(sut.count, 0, "Doubling after reset stays at zero")
    }

    func testDecrementClampsAfterReachingZero() {
        let sut = CounterViewModel(count: 1)
        sut.decrement()
        XCTAssertEqual(sut.count, 0)
        sut.decrement()
        XCTAssertEqual(sut.count, 0)
        sut.increment()
        XCTAssertEqual(sut.count, 1, "Counter still works normally after being clamped")
    }
}
