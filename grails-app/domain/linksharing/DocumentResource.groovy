package linksharing

class DocumentResource extends Resource{
String filePath
String fileName
    static constraints = {


    filePath(blank:false,nullable:true)
    fileName(nullable: true)
    }

}
