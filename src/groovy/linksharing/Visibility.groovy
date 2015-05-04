package linksharing

enum Visibility {
    PUBLIC("Public"),
    PRIVATE("Private")

    String name

    Visibility(String s)
    {
        this.name=s
    }
 public String toString()
  {return this.name }
}
