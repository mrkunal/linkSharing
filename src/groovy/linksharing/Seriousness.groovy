package linksharing;

public enum Seriousness {
    SERIOUS("Serious"),
    VERYSERIOUS("Very Serious"),
    CASUAL("Casual")

    String name

    Seriousness(String s) {
        this.name = s
    }
    public String toString()
     { return this.name }
}
