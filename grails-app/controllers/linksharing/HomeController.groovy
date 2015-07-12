package linksharing

import grails.plugin.mail.MailService
import org.apache.commons.validator.routines.EmailValidator

class HomeController {
User user
MailService mailService
    def beforeInterceptor = {
        String userName= session.userName
        user=User.findByUserName(userName)

    if(user==null)
    {   flash.message="You Need to be login First"
        redirect(controller: 'login',action: 'index')
    return false
    }
    }
   SupportService supportService

    static defaultAction = "dashboard"

    def dashboard()
  {   //String userName= "${session["userName"]}"
      //user=User.findByUserName(userName)
      params.max = params.max ?: 5
      List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
          projections { property("topic") }
          eq('user', user)
      }

       List<Resource> readResource=ReadingItem.createCriteria().list {
          projections{
              property('resource')
          }
          eq('user',user)
      }
      List<Resource> inbox=Resource.createCriteria().list(params) {   // Second Searching Resources Of the Topics

          inList ('topic', top )
          not { inList('id',readResource.id)  }
          order("lastUpdated","desc")

      }

      int  inboxCount=Resource.createCriteria().count() {   // Second Searching Resources Of the Topics

          projections{ rowCount()}
          inList ('topic', top )
          not { inList('id',readResource.id)  }


      }

      def trendingTopics=supportService.trending_topic()
      List<Topic> subscribedTopic=Subscription.createCriteria().list ([max:5]){

          projections{
              property('topic')
          }
          eq('user',user)
      }


      [resources:inbox,
       resourcesTotal:inboxCount,user:user,
       trendingTopics:trendingTopics,user:user,subscribedTopic:subscribedTopic]
  }
    def inboxFilter()
    {
        params.max = params.max ?: 5
        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }

        List<Resource> readResource=ReadingItem.createCriteria().list {
            projections{
                property('resource')
            }
            eq('user',user)
        }
        List<Resource> inbox=Resource.createCriteria().list(params) {   // Second Searching Resources Of the Topics

            inList ('topic', top)
            not { inList('id',readResource.id)  }
            order("lastUpdated","desc")

        }

        int  inboxCount=Resource.createCriteria().count() {   // Second Searching Resources Of the Topics

            projections{ rowCount()}
            inList ('topic', top )
            not { inList('id',readResource.id)  }


        }
        render(template: 'inbox',model:[resources:inbox,
                                        resourcesTotal:inboxCount])

    }

   def search()
   {    User user= User.findByUserName(session['userName'])

        def inbox_data=supportService.inbox_search(user,params['search'])
       render(template: 'inbox' ,model:[resources: inbox_data])
   }

     def invitation()
    {
        def topics=Subscription.findAllByUser(user)
       // render params
        [subscribed: topics.topic,topic:params['topicId']]

    }

    def invite() {
        boolean valid=true
        List<String> emails
        emails = params['email'].toString().split(';')


        EmailValidator emailValidator = EmailValidator.getInstance()

        try{
            emails.each { email ->

                if (!emailValidator.isValid(email)) {
                   valid=false
                    throw new Exception()
                }

            }
        }
        catch(Exception e){
             flash.message="Not a Valid Email Id Set..!please Check ie. 'emailid@domain.com;emailid2@domain.com'"
             forward (controller: 'home',action:'invitation' )
        }

        if(valid) {
            Topic topic = Topic.findById(params['topic'])
            emails.each { email ->

                String key=(topic.id+"^"+email).toString().encodeAsBase64()
                mailService.sendMail {
                    //  async true
                    to email
                    subject "Invitation"
                    body """ Hi,
                          You are invited by ${user.firstName}  to join this Topic ${topic.name}
                          click the below link..for subscribe
                               http://localhost:8080/linksharing/subscription/permission/?key=${key}


                            Thanks

                            Regards
                            LinksharingTeam
                          """
                }

            }
            flash.message = "Invitations Successfully Sends."
            forward(controller: 'home',action: 'invitation')
          }
    }

    def logout()
    {
        session['userName']=null
        session['admin']=null

        redirect(controller: "login",action: "index")
    }




}
