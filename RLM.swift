import RealmSwift

struct RLM {
    fileprivate static let main = try! RealmSwift.Realm()
    static func write(closure: (Void) -> Void) {
        try! main.write(closure)
    }
    static func add(_ object: Object) {
        main.add(object)
    }
    static func objects<T: Object>(_ type: T.Type) -> Results<T> {
        return main.objects(type)
    }
    
}
