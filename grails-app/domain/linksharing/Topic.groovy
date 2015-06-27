package linksharing

class Topic {
   String name
    Date dateCreated
    Date lastUpdated
   Visibility visibility


    static belongsTo=[createdBy:User]
    static hasMany=[resources:Resource,subscriptions:Subscription]

    static constraints = {
        name(unique: "createdBy")
        visibility(blank:false,nullable:false)

    }


  
}
