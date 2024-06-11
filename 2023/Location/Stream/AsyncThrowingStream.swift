import Foundation

extension AsyncThrowingStream where Failure == Error {
  init<S: AsyncSequence>(_ sequence: S) where S.Element == Element {
    let lock = NSLock()
    var iterator: S.AsyncIterator?
    self.init {
      lock.withLock {
        if iterator == nil {
          iterator = sequence.makeAsyncIterator()
        }
      }
      return try await iterator?.next()
    }
  }
}

extension AsyncSequence {
  func eraseToThrowingStream() -> AsyncThrowingStream<Element, Error> {
    AsyncThrowingStream(self)
  }
}
