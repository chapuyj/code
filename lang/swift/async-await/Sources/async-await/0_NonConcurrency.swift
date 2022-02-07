import Foundation

class ClosureHell {
    
    func work(completion: () -> Void) {
        download(url: "jordanchapuy.com") { data in
            switch data {
            case let .success(data):
                resize(data: data) { resizedData in
                    store(data: resizedData) {
                        completion()
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

class AsyncWay {
    
    func work() async throws {
        let data = try await download(url: "jordanchapuy.com")
        let resizedData = await resize(data: data)
        await store(data: resizedData)
    }
}

// MARK: - Fake functions to ease examples

func download(url: String, completion: (Result<Data, Error>) -> Void) {
    completion(.success(Data()))
}
func download(url: String) async throws -> Data {
    return Data()
}

func resize(data: Data, completion: (Data) -> Void) {
    completion(data)
}
func resize(data: Data) async -> Data {
    return data
}

func store(data: Data, completion: () -> Void) {}
func store(data: Data) async {}
