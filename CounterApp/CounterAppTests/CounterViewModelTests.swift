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

    func testDecrementClampsAfterReachingZero() {
        let sut = CounterViewModel(count: 1)
        sut.decrement()
        XCTAssertEqual(sut.count, 0)
        sut.decrement()
        XCTAssertEqual(sut.count, 0)
        sut.increment()
        XCTAssertEqual(sut.count, 1, "Counter still works normally after being clamped")
    }

    func testSetCountToPositiveValue() {
        let sut = CounterViewModel()
        sut.setCount(5)
        XCTAssertEqual(sut.count, 5)
    }

    func testSetCountToZero() {
        let sut = CounterViewModel(count: 4)
        sut.setCount(0)
        XCTAssertEqual(sut.count, 0)
    }

    func testSetCountClampsNegativeToZero() {
        let sut = CounterViewModel()
        sut.setCount(-3)
        XCTAssertEqual(sut.count, 0, "Negative values must be clamped to zero")
    }

    func testSetCountOverridesExistingValue() {
        let sut = CounterViewModel(count: 2)
        sut.setCount(10)
        XCTAssertEqual(sut.count, 10, "setCount sets an absolute value, not a relative adjustment")
    }
}
