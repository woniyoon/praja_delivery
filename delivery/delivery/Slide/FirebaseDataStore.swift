







class Repository {
    let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchData() -> Entity {
        return dataStore.fetchData()
    }
}


















protocol DataStoreProtocol {
    func fetchData() -> Entity
}

class FirebaseDataStore: DataStoreProtocol {
    func fetchData() -> Entity {
        return Entity(id: 1, name: "Kento")
    }
}

class ApiDataStore: DataStoreProtocol {
    func fetchData() -> Entity {
        return Entity(id: 2, name: "Bruno")
    }
}

struct Entity {
    public let id: Int
    public let name: String
}
