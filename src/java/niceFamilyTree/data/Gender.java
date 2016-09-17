package nicefamilytree.data;

/**
 * Created by MaryJoOon on 7/1/2016.
 */

public enum Gender {

    MALE("Male"), FEMALE("Female");

    private Gender(String name) {
        this.name = name;
    }

    private String name;

    public String getName() {
        return this.name;
    }
}