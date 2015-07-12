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


    protected def inbox_search(User user,String description)
    {
        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        List<Resource> AllResource=Resource.createCriteria().list() {   // Second Searching Resources Of the Topics

            inList ('topic', top )
            ilike('description',"%"+description+"%")
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


protected def topic_list()
{

}

}
