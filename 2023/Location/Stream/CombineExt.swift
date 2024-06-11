@preconcurrency import Combine

extension AnyPublisher where Failure == any Error {
  var stream: AsyncThrowingStream<Output, Failure> {
    return AsyncThrowingStream<Output, Failure> { continuation in
      let subscription = sink { result in
        switch result {
        case .finished:
          continuation.finish()
        case .failure(let error):
          continuation.finish(throwing: error)
        }
      } receiveValue: { value in
        continuation.yield(value)
      }
      continuation.onTermination = { _ in
        subscription.cancel()
      }
    }
  }
}
