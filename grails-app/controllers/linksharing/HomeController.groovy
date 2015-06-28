package linksharing

import grails.plugin.mail.MailService
import org.apache.commons.validator.routines.EmailValidator

class HomeController {
User user
MailService mailService
    def beforeInterceptor = {
        String userName= "${session["userName"]}"
        user=User.findByUserName(userName)

    if(user==null)
    {   flash.message="You Need to be logged in First"
        redirect(controller: 'login',action: 'index')}
    }
    def index() {


       // String userName= "${session["userName"]}"
       // user=User.findByUserName(userName)

        if(user!=null)
        {
            redirect(action:"dashboard")
        }
        else{redirect(controller: "login",action: "index")}
    }


 def dashboard()
  {   //String userName= "${session["userName"]}"
      //user=User.findByUserName(userName)
      def inbox_data=inbox_data()
      def trendingTopics=trending_topic()

      int subscription_total = Subscription.countByUser(user)

      int topic_total = Topic.countByCreatedBy(user)

      [resources:inbox_data,user:user,subscription_total:subscription_total,topic_total:topic_total,trendingTopics:trendingTopics,user:user]
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
                mailService.sendMail {
                    //  async true
                    to email
                    subject "Invitation"
                    body """ Hi,
                          You are invited by ${user.firstName}  to join this Topic ${topic.name}


                          """
                }

            }
            flash.message = "Invitations Successfully Sends."
            redirect(controller: 'home',action: 'dashboard')
          }
    }

    protected def trending_topic()
    {
        List<Topic> trendingTopics =Resource.createCriteria().list(max:5){
        projections{
            groupProperty ('topic')
        }
        count('topic','resCount')

        'topic' {
            eq('visibility',Visibility.PUBLIC)
        }
        order('resCount','desc')
    }*.getAt(0)


    }

    protected def inbox_data()
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

    def shareDocument()
    {
//        String userName= "${session["userName"]}"
//        user=User.findByUserName(userName)

        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        [topics:top]

    }


    def document_download()
  {
   Resource resource =Resource.findById(params['id'])

      def file = new File("${resource.filePath}")

      if (file.exists())
        {
            response.setContentType("application/octet-stream") // or or image/JPEG or text/xml or whatever type the file is
            response.setHeader("Content-disposition", "attachment;filename=\"${resource.fileName}\"")
            response.outputStream << file.bytes
        }
        else render "File Not Found ...Error!"

    }

    def document_create()
    {
//        String userName= "${session["userName"]}"
//        user=User.findByUserName(userName)

        def file = request.getFile('file')
        if(file.empty) {
            flash.message = "File cannot be empty"
        }
        else {
            DocumentResource documentResource=new DocumentResource()
            documentResource.topic=Topic.findById(params['topic'])
            String s=file.originalFilename+new Date()
            documentResource.description=params['description']
            documentResource.createdBy=user
            documentResource.fileName=file.originalFilename

            String path='web-app/document/'+"${documentResource.topic.id}/"

            File dir=new File(path)
            if( !dir.exists() ) {

                dir.mkdirs()
            }
            documentResource.filePath = path + s
            file.transferTo(new File(documentResource.filePath))

            documentResource.save(failOnError: true)
            redirect(controller: "home",action: "dashboard")
        }


    }


}
