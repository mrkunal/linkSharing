package linksharing

class DocumentResourceController {


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
            Resource resource=documentResource
            new ReadingItem(resource:resource, isRead: true, user: user).save()
            flash.message="Document Resource Shared Successfully"
            redirect(controller: "home",action: "dashboard")
        }

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



}
