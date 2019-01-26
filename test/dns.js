const DNS = artifacts.require("DNS");

contract("DNS", accounts => {
  interface("Should claim a name", function(){
    const instance = await DNS.deployed();
    assert.equal(1,1, "should have 1");
  });
});
