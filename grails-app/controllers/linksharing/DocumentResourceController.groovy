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
        Resource resource=Resource.findById(params['resourceId'])
            [resource:resource,topics:top]

    }
    def save()
    {   String userName= "${session["userName"]}"
        User user=User.findByUserName(userName)
        DocumentResource resourceAlready =DocumentResource.findById(params['resourceId'])
        def file = request.getFile('file')
        if(file.empty && resourceAlready==null) {
            flash.message = "Some Error Occured"
            redirect(controller: "documentResource",action: "create")
        }
        else if(resourceAlready==null) {
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
            redirect(controller: "documentResource",action: "create")
        }
        else if(resourceAlready!=null)
        {

            if(!file.empty)
            {
                String prevpath=resourceAlready.filePath
                new File(prevpath).delete()

                resourceAlready.fileName=file.originalFilename
                String path='web-app/document/'+"${resourceAlready.topic.id}/"
                String s=file.originalFilename+new Date()

                File dir=new File(path)
                if( !dir.exists() ) {

                    dir.mkdirs()
                }
                resourceAlready.filePath = path + s
                file.transferTo(new File(resourceAlready.filePath))

            }
            resourceAlready.description=params['description']
            resourceAlready.save(failOnError: true,flush: true)
            flash.message="Changes Successfully Made."
            redirect(controller: 'documentResource',action: 'create')

        }

    }


    def document_download()
  {
      Resource resource =Resource.findById(params['id'])

      def file = new File("${resource.filePath}")

      if (file.exists())
        {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"${resource.fileName}\"")
            response.outputStream << file.bytes
        }
        else render "File Not Found ...Error!"

    }



}
