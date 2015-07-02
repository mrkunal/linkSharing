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
      def inbox_data=supportService.inbox_data(user)
      def trendingTopics=supportService.trending_topic()
      List<Topic> subscribedTopic=Subscription.createCriteria().list ([max:5]){

          projections{
              property('topic')
          }
          eq('user',user)
      }


      [resources:inbox_data,user:user,trendingTopics:trendingTopics,user:user,subscribedTopic:subscribedTopic]
  }

     def invitation()
    {
       def topics=Subscription.findAllByUser(user)
        [subscribed: topics.topic]
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
             redirect (controller: 'home',action:'invitation' )
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
                               http://localhost:8080/linksharing/subscription/permission/?key=${key}

                          """
                }

            }
            flash.message = "Invitations Successfully Sends."
            redirect(controller: 'home',action: 'dashboard')
          }
    }

    def logout()
    {
        session['userName']=null
        session['admin']=null
        flash.message="Successfully Log Out"
        redirect(controller: "login",action: "index")
    }




}
