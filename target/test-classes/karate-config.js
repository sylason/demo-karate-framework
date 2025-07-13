function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log("karate.env system property was:", env);
  if (!env) {
    env = "dev";
  }
  var config = {
    env: env,
    myVarName: "someValue",
    dummyjsonURL: "https://dummyjson.com/",
    saucedemoURL: "https://saucedemo.com/",
    saucedemoHomePageURL: "https://www.saucedemo.com/inventory.html",
  };
  if (env == "dev") {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == "e2e") {
    // customize
  }
  karate.configure("connectTimeout", 10000);
  karate.configure("readTimeout", 10000);
  karate.configure("driver", {
    type: "chrome",
    executable: "chrome", // Bạn có thể để Karate tự quản lý
  });

  return config;
}
