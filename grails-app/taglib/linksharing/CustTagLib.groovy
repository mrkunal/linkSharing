
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
        out<<sb.toString()
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

            out<< sb
    }

    def show={attrs ,body->


    }
}
