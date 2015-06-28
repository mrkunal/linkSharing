package linksharing

class User {

  String email
  String userName
  String password
  String firstName
  String lastName
 
  byte[] photo
    String photoName
  Boolean admin=false
  Boolean active=true
  Date dateCreated
  Date lastUpdated






/*
 def beforeInsert = {
    password = password.encodeAsMD5()
} */



  static hasMany=[topics:Topic,subscriptions:Subscription,readingItems:ReadingItem,
                  resources:Resource,resourceRatings:ResourceRating]
   static constraints = {
       email(email:true,blank:false,unique:true,nullable:false)
       photo(nullable:true,maxSize:  1024*1024*4)
        photoName(nullable: true)
       userName(unique: true)
  }


}
