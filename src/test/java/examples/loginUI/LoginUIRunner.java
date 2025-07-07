package examples.loginUI;
import com.intuit.karate.junit5.Karate;

class ProductsRunner {

    @Karate.Test
    Karate testLoginUI() {
        return Karate.run("loginUI").relativeTo(getClass());
    }
}
