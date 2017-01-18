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
}
