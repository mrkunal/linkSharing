package linksharing

class ReadingItem {
Boolean isRead

    static belongsTo=[resource:Resource,user:User]
    static constraints = {
    }
}
