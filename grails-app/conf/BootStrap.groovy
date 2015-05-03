import linksharing.*
class BootStrap {

    def init = { servletContext ->
   createUsers()
   createTopics()
}
    def destroy = {
    }
   
 void createUsers()
  {
 new User(firstName:"kunal",email:"kunalkumar284@gmail.com",userName:"kuku8",password:"kunal123",passwordConfirm:"kunal123",lastName:"kumar").save(failOnError:true)

new User(firstName:"amit",email:"amitgupta@gmail.com",userName:"amit8",password:"amit456",passwordConfirm:"amit456",lastName:"gupta").save(failOnError:true)

  }

 void createTopics() {
     List users = User.list()
     users.each { user ->
         5.times {
             Topic topic = new Topic(user:user,name: "Topic ${it + 1}", visibility:"Public").save(failOnError: true)

//          new Subscription(topic:Topic,seriousness:"Serious",user:user).save(failOnError: true)
         }
     }
 }




void createResources()
{}
void createReadingItems()
{}
void createRatings()
{}
void subscribeTopic()
{}

}
