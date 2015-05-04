import linksharing.*
class BootStrap {

    def init = { servletContext ->
   createUsers()
   createTopics()
        createResources()
createReadingItems()
    }
    def destroy = {
    }
   
 void createUsers()
  {
 new User(firstName:"kunal",email:"kunalkumar284@gmail.com",userName:"kuku8",password:"kunal123",lastName:"kumar").save(failOnError:true)

new User(firstName:"amit",email:"amitgupta@gmail.com",userName:"amit8",password:"amit456",lastName:"gupta").save(failOnError:true)

  }

 void createTopics() {
     List users = User.list()
     users.each { user ->
         5.times {
             Topic topic = new Topic(user:user,name: "Topic ${it + 1}", visibility:Visibility.PUBLIC).save(failOnError: true)

          new Subscription(topic:topic,seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true)
         }
     }
 }




void createResources()
{
List users =User.list()
    users.each {user ->

        def topics=Topic.findAllByUser(user)
        topics.each { topic->
            5.times
                    {
                        new LinkResource(createdBy:user,description:"Resource ${it} - ${topic} - ${user}"
                                ,topic:topic,url:"http://www.google.com").save(failOnError:true)

                        new DocumentResource(createdBy:user,description:"Resource ${it}- ${topic} - ${user}"
                                ,topic:topic,filePath:"C:\\users\\Desktop").save(failOnError:true)
                    }

        }
    }

}
void createReadingItems()
{
    int size=Resource.list().size();
    User.list().each { user ->
   3.times {
       Random random = new Random()

       new ReadingItem(resource: Resource.get(Math.abs(random.nextInt() % size)), isRead: true, user: user).save(failOnError: true)
   }
   }
    }
void createRatings()
{}
void subscribeTopic()
{}

}

