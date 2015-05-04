package linksharing

class Resource {
   // String title
    String description
    Date dateCreated
    Date lastUpdated
    User createdBy
    static belongsTo=[topic:Topic]

    static hasMany=[readingItems:ReadingItem,resourceRatiings:ResourceRating]


    static constraints = {
       description(size:1..1024)
     //   title(unique:'topic')
        createdBy(nullable:false,blank:false)
    }
}
