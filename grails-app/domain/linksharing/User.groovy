package linksharing

class User {

  String email
  String userName
  String password
  String confirmPassword 
  String firstName
  String lastName
 
  byte[] photo
  Boolean admin=false
  Boolean active=false
  Date dateCreated
  Date lastUpdated



//  static transients =['confirmPassword']


  static hasMany=[topics:Topic,subscriptions:Subscription,readingItems:ReadingItem,
                  resources:Resource,resourceRatings:ResourceRating]
  static constraints = {
    email(email:true,blank:false,unique:true,nullable:false)
    photo(nullable:true)
  confirmPassword(nullable:false,password:true)
password(minSize: 6, maxSize: 16, nullable: false,password:true, blank: false, validator: {value, object ->
            if (!object.id && value != object.confirmPassword)
                return "user.password.mismatch"
        })

  }



  String toString()
  { return userName }
}
