package linksharing

class ReadingItem {
Boolean isRead=true

    static belongsTo=[resource:Resource,user:User]
    static constraints = {
        resource(unique:"user")


    }
}
