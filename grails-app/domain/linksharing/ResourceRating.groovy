package linksharing

class ResourceRating {

    int score
    static belongsTo=[user:User,resource:Resource]
    static constraints = {


    }


}
