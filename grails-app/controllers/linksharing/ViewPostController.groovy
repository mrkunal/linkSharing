package linksharing

class ViewPostController {

  static defaultAction = "showPost"
    def showPost()
    {
        int a= (int)params['resource']
        render a
        //Resource res=Resource.findById((int)params['resource'])
       // [resource:res]

    }
}
