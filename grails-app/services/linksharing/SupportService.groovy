package linksharing

import grails.transaction.Transactional

@Transactional
class SupportService {
    def supportService
    def serviceMethod() {

    }

    def subscribedTopics(User user)
    {
        List<Topic> subscriptions = Subscription.createCriteria().list() {
            projections { property("topic") }
            eq('user', user)
        }
        return subscriptions
    }

    def trending_topic() {
        List<Topic> trendingTopics = Resource.createCriteria().list(max: 5) {
            projections {
                groupProperty('topic')
            }
            count('topic', 'resCount')

            'topic' {
                eq('visibility', Visibility.PUBLIC)
            }
            order('resCount', 'desc')
        }*.getAt(0)
         return trendingTopics
    }

    protected def inbox_data(User user)
    {

        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        List<Resource> AllResource=Resource.createCriteria().list() {   // Second Searching Resources Of the Topics

            inList ('topic', top )
            order("lastUpdated","desc")
        }

        List<Resource> readResource=ReadingItem.createCriteria().list {
            projections{
                property('resource')
            }
            eq('user',user)
            inList('resource',AllResource)

        }
        Set rs=AllResource.toSet()
        Set rr=readResource.toSet()

        List resource=(rs-rr).toList()

        resource.sort{it.lastUpdated}
        resource.reverse(true)
        return resource
    }

    def topPost(Date date)
    {         List<Topic> top =Topic.findAllByVisibility("PUBLIC")

        List<Resource> Allresources=Resource.findAllByTopicInList(top)

        List<Resource> topposts=ResourceRating.createCriteria().list([max:5]) {
        projections{
            groupProperty("resource")
            sum("score",'sum')

        }
        order('sum','desc')
        inList('resource',Allresources)
        'resource'
                {
                    ge('lastUpdated', date)
                }
    }*.getAt(0)
    return topposts
    }

//    def subscriptionTotal(User user)
//    {  int subscription_total
//        if(session['userName']==user.userName||session['admin']==true) {
//            subscription_total = Subscription.countByUser(user)
//            return subscription_total
//        }
//        else
//        {
//        subscription_total=Subscription.createCriteria().count(){
//        projections{ rowCount()}
//            'topic' {
//                eq('visibility',Visibility.PUBLIC)
//
//            }
//        }
//            return subscription_total
//        }
//
//    }


}
