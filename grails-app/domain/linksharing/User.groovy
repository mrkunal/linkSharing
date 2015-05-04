package linksharing

class User {

  String email
  String userName
  String password
  String firstName
  String lastName
  byte[] photo
  Boolean admin=false
  Boolean active=false
  Date dateCreated
  Date lastUpdated



  static transient passwordConfirm


  static hasMany=[topics:Topic,subscriptions:Subscription,readingItems:ReadingItem,
                  resources:Resource,resourceRatings:ResourceRating]
  static constraints = {
    email(email:true,blank:false,unique:true,nullable:false)
    photo(nullable:true)
    password(password:true,nullable:false,blank:false)

   /*   Can be used with passwordConfirm

     passwordConfirm validator:{val,obj->
      obj.password==val
    }
         */
  }



  String toString()
  { return userName }
}
