package linksharing

class Subscription {

    Date dateCreated
    Seriousness seriousness
    static belongsTo=[user:User,topic:Topic]


    enum Seriousness {
        Serious, verySerious, Casual
    }


    static constraints = {
       user(unique:true)
        seriousness(blank:false,nullable:false)
    }

String toString()
{
    return user+"-S-"+topic

}

}
