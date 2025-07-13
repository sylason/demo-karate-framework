// package API;

// import static org.junit.jupiter.api.Assertions.assertEquals;

// import org.junit.jupiter.api.Test;

// import com.intuit.karate.Results;
// import com.intuit.karate.Runner;

// class ExamplesTest {

//     @Test
//     void testParallel() {
//         Results results = Runner.path("classpath:API")
//                 //.outputCucumberJson(true)
//                 .parallel(5);
//         assertEquals(0, results.getFailCount(), results.getErrorMessages());
//     }

// }
