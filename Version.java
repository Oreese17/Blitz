//import javax.annotation.Nonnull;
//import javax.annotation.Nullable;
import java.util.Objects;
import java.util.Optional;

public class Version {
    private final int major, minor, patch, build;
    String type;

    // Ex. "2.14.1.1" --> major = "2", minor = "14", patch = "1", build = "1"
    // Hello World
    public Version(int major, int minor, int patch, int build, String type) {
        this.major = major;
        this.minor = minor;
        this.patch = patch;
        this.build = build;
        this.type = type; // Optional.ofNullable(type).map(String::trim).filter(t -> !t.isEmpty()).orElse(null);
    }

    public Version(String version) {
        //requireNonNull(version);
        //checkArgument(!Strings.isNullOrEmpty(version.trim()), "version must not be blank");

        String[] versionAndType = version.split(":");
        String[] versionParts = versionAndType[0].split("\\.");

        //checkArgument(versionParts.length <= 4, "version cannot have more than 4 parts (major.minor.patch.build)");
        //checkArgument(versionParts.length >= 2, "version must contain at least two parts (major.minor)");

        this.major = Integer.parseInt(versionParts[0]);
        this.minor = Integer.parseInt(versionParts[1]);
        this.patch = versionParts.length >= 3 ? Integer.parseInt(versionParts[2]) : 0;
        this.build = versionParts.length >= 4 ? Integer.parseInt(versionParts[3]) : 0;
        this.type = versionAndType.length == 1 ? null : versionAndType[1].trim();
    }

    public int getMajor() {
        return major;
    }

    public int getMinor() {
        return minor;
    }

    public int getPatch() {
        return patch;
    }

    public int getBuild() {
        return build;
    }

    public Optional<String> getType() {
        return Optional.ofNullable(type);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Version that = (Version) o;
        return major == that.major &&
                minor == that.minor &&
                patch == that.patch &&
                build == that.build &&
                Objects.equals(type, that.type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(major, minor, patch, build, type);
    }

    @Override
    public String toString() {
        return "" + major + "." + minor + "." + patch + "." + build + getType().map(t -> ":" + t).orElse("");
    }

    //@Override
    public int compareTo(Version other) {
        if (this == other) {
            return 0;
        }

        if (getMajor() != other.getMajor()) {
            return getMajor() - other.getMajor();
        }

        if (getMinor() != other.getMinor()) {
            return getMinor() - other.getMinor();
        }

        if (getPatch() != other.getPatch()) {
            return getPatch() - other.getPatch();
        }

        if (getBuild() != other.getBuild()) {
            return getBuild() - other.getBuild();
        }

        return 0;
    }

}