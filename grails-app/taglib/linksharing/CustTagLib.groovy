
package linksharing

import com.sun.org.apache.xml.internal.security.utils.Base64
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

    def show={attrs ,body->


    }
}
