import RealmSwift

class Item: Object {
    
    dynamic var detail: String = ""
    dynamic var firstStep: String = ""
    dynamic var finishedCondition: String = ""
    
    override class func primaryKey() -> String? {
        return "detail"
    }
    override class func indexedProperties() -> [String] {
        return ["firstStep","finishedCondition"]
    }
    
    static func create() -> Item {
        let item = Item()
        Realm.write {
            Realm.add(item)
        }
        return item
    }
}
