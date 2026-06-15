import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CounterViewModel()

    var body: some View {
        VStack(spacing: 40) {
            Text("\(viewModel.count)")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .monospacedDigit()
                .accessibilityIdentifier("countLabel")

            HStack(spacing: 20) {
                Button {
                    viewModel.decrement()
                } label: {
                    Text("−")
                        .font(.title)
                        .frame(width: 64, height: 64)
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("decrementButton")

                Button {
                    viewModel.increment()
                } label: {
                    Text("+")
                        .font(.title)
                        .frame(width: 64, height: 64)
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("incrementButton")
            }

            Button("Reset") {
                viewModel.reset()
            }
            .accessibilityIdentifier("resetButton")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
