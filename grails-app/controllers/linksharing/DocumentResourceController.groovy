package linksharing

class DocumentResourceController {

    def scaffold=true

    def create()
    {
        String userName= "${session["userName"]}"
       User user=User.findByUserName(userName)

        List<Topic> top = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        [topics:top]

    }
    def save()
    {
        String userName= "${session["userName"]}"
        User user=User.findByUserName(userName)

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
            flash.message="Document Resource Shared Successfully"
            redirect(controller: "home",action: "dashboard")
        }

    }
}
