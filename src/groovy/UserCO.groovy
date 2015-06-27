/**
 * Created by ubuntu on 20/6/15.
 */
package linksharing

import grails.validation.Validateable

@Validateable
class UserCO {
    String email
    String userName
    String password
    String confirmPassword
    String firstName
    String lastName

}
