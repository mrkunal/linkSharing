package linksharing

class Resource {

    String description
    Date dateCreated
    Date lastUpdated
    User createdBy
    static belongsTo=[topic:Topic]

    static hasMany=[readingItems:ReadingItem,resourceRatings:ResourceRating]

    static mapping = {
        tablePerHierarchy false
        description type: 'text'
    }
    static constraints = {
       description(size:1..1024)
        createdBy(nullable:false,blank:false)
    }
}
