package linksharing

class ReadingItem {
Boolean isRead=false

    static belongsTo=[resource:Resource,user:User]
    static constraints = {
        resource(unique:"user")
    }
}
