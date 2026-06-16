import Foundation

/// Owns the counter state. The SwiftUI view holds none of this state itself.
final class CounterViewModel: ObservableObject {
    @Published private(set) var count: Int

    init(count: Int = 0) {
        self.count = max(0, count)
    }

    /// Increase the count by one.
    func increment() {
        count += 1
    }

    /// Decrease the count by one, never going below zero.
    func decrement() {
        count = max(0, count - 1)
    }

    /// Triple the current count.
    func tripleCount() {
        count *= 3
    }

    /// Reset the count back to zero.
    func reset() {
        count = 0
    }
}
