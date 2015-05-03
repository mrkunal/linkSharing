package linksharing

class Topic {
   String name
    Date dateCreated
    Date lastUpdated
   Visibility visibility

    enum Visibility {Public,Private}

    static belongsTo=[user:User]
    static hasMany=[resource:Resource,subscription:Subscription]

    static constraints = {
        visibility(blank:false,nullable:false)
        user(unique:true)
    }


    String toString()
    { return user+"-"+name }
}
