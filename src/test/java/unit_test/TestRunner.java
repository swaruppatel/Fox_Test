package unit_test;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate testTags() {
        return Karate.run("classpath:e2e/").tags("@e2e");
    }

}