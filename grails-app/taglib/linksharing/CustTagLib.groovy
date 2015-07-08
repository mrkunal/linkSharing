
package linksharing

import com.sun.org.apache.xml.internal.security.utils.Base64
import groovy.time.TimeCategory
import sun.misc.BASE64Encoder

class CustTagLib {
    static defaultEncodeAs = [taglib: 'none']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    static namespace = "gt"

    def pic = { attrs ->

        StringBuilder sb = new StringBuilder()
       def homeImage = resource(dir:'images',file:'def_avatar2.png')
        def id = attrs.uid

        User user = User.findById(id)

       if((user.photo==null)) {
        sb << """

        <img src="${createLinkTo(dir: 'images', file: 'def_avatar2.png')}" width="120" height="130" class="img-rounded"/>

        """
        }
        else{
          sb << "<img src='data:${user.photoName};base64,"
          sb << Base64.encode(user?.photo)
          sb << "' width='120' height='130' class=\"img-rounded\"/>"

            }

        out << g.link(controller: 'user', action: 'show', params: [uid: user.id]){sb.toString()}
        //out<< "<g:link controller: 'user' action :'show' params:[present:'yes']>"
        //out<<sb.toString()
       //out<< "</g:link>"
    }
    def time={ attrs->
        StringBuilder sb=new StringBuilder()
        Date resource_time=attrs.time
        Date current=new Date()

        int mon=TimeCategory.minus(current,resource_time).months
        int day=TimeCategory.minus(current,resource_time).days
        int hour=TimeCategory.minus(current,resource_time).hours
        int min=TimeCategory.minus(current,resource_time).minutes

        if((mon>0)||(day>3))
        { sb<<resource_time.dateString() }
        else if ((day<4 )&&(day>0))
        { sb<<day+" days ago"}
        else if(hour>0)
        { sb<<hour +" hours ago"}
        else
        { sb<<min +" mins ago" }

            out<<sb                             //    deployment time
            //out<< resource_time             //      compile time
    }

    def ExactTime={ attrs->
        StringBuilder sb=new StringBuilder()
        Date resource_time=attrs.time

        def day=resource_time.toLocaleString()

        out<<day                             //    deployment time
        //out<< resource_time             //      compile time
    }
    def subscriptionCount={ attrs,body->
        def id = attrs.uid
        def userName =session['userName']

        User showUser=User.findById(id)
        User loggedUser=User.findByUserName(userName)
        int subscriptionTotal=0
       if(showUser==loggedUser || loggedUser.admin==true)
        {                                             // Each Topic Counting Subscribers
            subscriptionTotal =Subscription.createCriteria().get{
                projections { rowCount() }

                eq("user",showUser)

            }
        }
        else{
            subscriptionTotal =Subscription.createCriteria().get{
                projections { rowCount() }
                'topic'{
                    eq('visibility',Visibility.PUBLIC)

                }
                eq("user",showUser)

            }

        }
        out<<subscriptionTotal

        }


    def postCount={ attrs,body->
        def id = attrs.uid
        def userName =session['userName']

        User showUser=User.findById(id)
        User loggedUser=User.findByUserName(userName)
        int postTotal=0
        if(showUser==loggedUser || loggedUser.admin==true)
        {                                             // Each Topic Counting Subscribers
            postTotal =Resource.createCriteria().get{
                projections { rowCount() }

                eq("createdBy",showUser)

            }
        }
        else{
            postTotal =Resource.createCriteria().get{
                projections { rowCount() }
                'topic'{
                    eq('visibility',Visibility.PUBLIC)

                }
                eq("createdBy",showUser)

            }

        }
        out<<postTotal

    }
    def description={
        attrs,body->
            Resource resource=Resource.findById(attrs.rid)

              int length = resource.description.length()
              if (length > 150) {
                  length = 150
              }

              out << resource.description.substring(0, length)+"..."

          }
    def topicCount=
    {   attrs,body->
        User user=User.findById(attrs.uid)
        int topic_total
        if(session['userName']==user.userName||session['admin']==true) {
            topic_total = Topic.countByCreatedBy(user)

        }
        else
        {
            topic_total=Topic.countByCreatedByAndVisibility(user,Visibility.PUBLIC)



        }
        out<< topic_total
    }

    def show={attrs ,body->

    }

    def topicSubscriptionCount={
        attrs,body->
            Topic topic=Topic.findById(attrs.tid)
            int subscription_total

           subscription_total= Subscription.countByTopic(topic)
       out<<subscription_total
    }
    def topicPostCount={
        attrs,body->
            Topic topic=Topic.findById(attrs.tid)
            int post_total
            post_total=Resource.countByTopic(topic)
            out<<post_total
    }
}
