package linksharing

import grails.converters.JSON

class TopicController {

def create()
{

}

    def save()
    {
        String userName= "${session["userName"]}"
        User user=User.findByUserName(userName)
         Topic topic=new Topic(name: params['topicName'],user:user,visibility: Visibility.(params['visibility']))
        String result
        topic.createdBy=user

        if(topic.validate()==false)
        {render "false" }
        else {
            topic.save(failOnError: true)
            new Subscription(topic: topic, seriousness: Seriousness.SERIOUS, user: user).save(failOnError: true, flush: true)
        render "true"
        }

    }

    def show()
    {
        Topic topic=Topic.findById(params['topicId'])
        User user=User.findByUserName(session['userName'])
        if(topic==null||topic.visibility==Visibility.PRIVATE && Subscription.findByUserAndTopic(user,topic)==null && user.admin==false)
        {
            flash.message="Access Problem"
            redirect(controller: 'home',action: 'dashboard')
            return false

        }
        else
        {

            List<User> users =Subscription.createCriteria().list([max:10]) {
                projections{
                    property('user')
                }
                eq('topic',topic)

            }
            List<Resource> resources=Resource.findAllByTopic(topic,[max:10,sort:'lastUpdated',order:'desc'])

            [user: user,topic:topic,resources:resources,users:users]

        }

    }
    def search()
    {
        Topic topic=Topic.findById(params['topicId'])
        String searchString='%'+params['searchString'].toString().trim()+'%'

        List<Resource> resources=Resource.createCriteria().list {

            eq('topic',topic)
            ilike('description',searchString)
            order('lastUpdated','desc')
        }

        render (template: '/home/inbox',model:[resources: resources])

    }

    def list()
    {   User user=User.findByUserName(session['userName'])
        User viewUser=User.findById(params['uid'])
        String operation =params['operation']
        List<Topic> topics
       if(params['uid']==""&&user.admin==true)
       {   topics=Topic.list([sort:'name' ,order:'asc'])
       }
       else if(params['uid']!=""&&(user.admin==true||viewUser==user))
       {
         if(operation=='subscriptions')
         { topics=Subscription.createCriteria().list([sort:'topic.name',order:'asc']) {

             projections {
                 property('topic')
             }
             eq('user',viewUser)
         }

         }
           else if(operation=='topic')
         { topics=Topic.createCriteria().list([sort:'name',order:'asc']) {
             eq('createdBy',viewUser)

         }

         }

       }
        else
       {         if(operation=='subscriptions')
                {
                    topics=Subscription.createCriteria().list([sort:'name',order:'asc']) {

                        projections {
                            property('topic')
                        }
                        eq('user',viewUser)
                        'topic'
                                {
                                    eq('visibility',Visibility.PUBLIC)
                                }
                    }
                }
                else if(operation=='topic')
                {
                    topics=Topic.createCriteria().list([sort:'name',order:'asc']) {
                    eq('createdBy',viewUser)
                        eq('visibility',Visibility.PUBLIC)

                }
                }

       }
        List<Resource> resources=Resource.createCriteria().list {

            order('lastUpdated','desc')
            inList('topic',topics)

        }

            [topics:topics,resources: resources]
       // render topics

    }
   def delete()
   {
       Topic topic=Topic.findById(params['topicId'])
       User user=User.findByUserName(session['userName'])
       if(topic!=null && (user==topic.createdBy||user.admin==true))
       {   String path='web-app/document/'+topic.id       // for Deleting Associating document Resource
           def documentResource=new File(path)
           documentResource.deleteDir()
           topic.delete(flush: true)

       }
   }
    def changeName()
    {
        Topic topic=Topic.findById(params['topicId'])
        topic.name=params['topicName']
        topic.save(failOnError: true,flush: true)
         render true
    }



}
