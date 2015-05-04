package linksharing

class Topic {
   String name
    Date dateCreated
    Date lastUpdated
   Visibility visibility


    static belongsTo=[user:User]
    static hasMany=[resources:Resource,subscriptions:Subscription]

    static constraints = {
        visibility(blank:false,nullable:false)
        user(unique:'name')
    }


    String toString()
    { return name }
}
