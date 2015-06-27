package linksharing

import grails.transaction.Transactional

@Transactional
class BootstrapService {
def bootstrapService

    void init() {
       createUsers()
        createTopics()
        createResources()
        createReadingItems()
        createRatings()
        subscribeTopic()
    }

    void createUsers()
    {   File file=new File("web-app/images/img3.jpg")

        new User(firstName:"Kunal",email:"kunalkumar284@gmail.com",userName:"kunal",password:"kunal",lastName:"kumar",photoName:"image/jpg",photo:file.getBytes()).save(failOnError:true)

        new User(firstName:"Steve",email:"stevemartin@gmail.com",userName:"steve",password:"steve",lastName:"martin").save(failOnError:true)

        new User(firstName:"Admin",email:"linkadmin@gmail.com",userName:"admin",password:"admin",lastName:"linksharing",admin: true).save(failOnError:true)

        File file1=new File("web-app/images/img1.png")
         new User(firstName:"Robert",email:"robertpat@gmail.com",userName:"robert",password:"robert",lastName:"Pattinson",photoName:"image/png",photo:file1.getBytes()).save(failOnError:true)

        File file2=new File("web-app/images/img2.png")
         new User(firstName:"Katy",email:"katyperry@gmail.com",userName:"katy",password:"katy",lastName:"perry",photoName:"image/png",photo:file2.getBytes()).save(failOnError:true,flush: true)



    }

    void createTopics() {
        List users = User.list()
        users.each { user ->
            5.times {
                Topic topic = new Topic(createdBy: user,name: "Topic ${it + 1}", visibility:Visibility.PUBLIC).save(failOnError: true,flush:true)

                new Subscription(topic:topic,seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true,flush:true)
            }
            2.times {
                Topic topic = new Topic(createdBy: user,name: "Topic ${it + 6}", visibility:Visibility.PRIVATE).save(failOnError: true,flush:true)

                new Subscription(topic:topic,seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true,flush:true)
            }
        }
    }




    void createResources()
    {
        List users =User.list()
        users.each {User user ->

            List<Topic> topics=Topic.findAllByCreatedBy(user)
            topics.each {Topic topic->
                5.times
                        {
                            new LinkResource(createdBy:user,description:"Link Resource ${it} - ${topic} - ${user}"
                                    ,topic:topic,url:"http://www.google.com").save(failOnError:true, flush: true)

                            new DocumentResource(createdBy:user,description:"Document Resource ${it}- ${topic} - ${user}"
                                    ,topic:topic,filePath:"C:\\users\\Desktop").save(failOnError:true,flush:true)
                        }

            }
        }


    }
    void createReadingItems()
    { List users =User.list()
        int counter=0
        users.each { User user ->

            List<Subscription> sub = Subscription.findAllByUser(user)

            List<Resource> res = Resource.findAllByTopicInList(sub.topic)
            5.times {
                Random random = new Random()

                new ReadingItem(resource: Resource.get(Math.abs(random.nextInt(res.size() + 1))+res.size()*counter), isRead: true, user: user).save()
            }
            counter +=1

        }
    }
    void createRatings()
    {

    }
    void subscribeTopic()
    {
        List users =User.list()
        users.each {User user ->

            List<Topic> topics=Topic.createCriteria().list {

                ne("createdBy",user)
            }

            new Subscription(topic:topics.first(),seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true,flush:true)
            new Subscription(topic: topics.last(),seriousness:Seriousness.SERIOUS,user:user).save(failOnError: true,flush:true)
         }

    }
}
