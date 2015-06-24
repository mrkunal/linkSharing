package linksharing

class ResourceRating {

    int score
    static belongsTo=[user:User,resource:Resource]
    static constraints = {

        user(unique:"resource")
        score(min:0,max:5)

    }


}
