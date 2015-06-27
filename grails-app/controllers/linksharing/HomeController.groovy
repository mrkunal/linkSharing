package linksharing

class HomeController {
User user
    def index() {
        String userName= "${session["userName"]}"
        user=User.findByUserName(userName)

        if(user!=null)
        {
            redirect(action:"dashboard")
        }
        else{redirect(controller: "login",action: "index")}
    }


 def dashboard()
  {   String userName= "${session["userName"]}"
      user=User.findByUserName(userName)
      def inbox_data=inbox_data()


      int subscription_total = Subscription.countByUser(user)

      int topic_total = Topic.countByCreatedBy(user)

      [resources:inbox_data,user:user,subscription_total:subscription_total,topic_total:topic_total]
  }

/*
def shareLink()
 {
     String userName= "${session["userName"]}"
     user=User.findByUserName(userName)

     List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
         projections { property("topic") }
         eq('user', user)
     }
         [topics:top]

 }
*/

    /*def link_create()
    {
        String userName= "${session["userName"]}"
        user=User.findByUserName(userName)

        LinkResource linkResource=new LinkResource()
        linkResource.topic=Topic.findById(params['topic'])
        linkResource.url=params['url']
        linkResource.createdBy=user
        linkResource.description=params['description']
        if(!linkResource.validate()) {
         flash.message="Error while Sharing"
            redirect(controller: "home", action: "dashboard")
        }
        else {
            linkResource.save(failOnError: true)
            redirect(controller: "home", action: "dashboard")
        }
        }*/

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
        String userName= "${session["userName"]}"
        user=User.findByUserName(userName)

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
        else render "Error!"

    }

    def document_create()
    {
        String userName= "${session["userName"]}"
        user=User.findByUserName(userName)

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
