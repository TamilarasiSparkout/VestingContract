const{ ethers }= require ("hardhat");
const args = require("./constructorArguments");


async function main() {

    // const [deployer] = await ethers.getSigners();
    // console.log("Deployer address is :", deployer.address);

    // const NewToken = await ethers.getContractFactory("NewToken");
    // const newtoken = await NewToken.deploy();
    // const NewTokenAddress = await newtoken.getAddress();

    // console.log("NewToken deployed to:", NewTokenAddress);


    //const[beneficiary] = await ethers.getSigners();

    console.log("Constructor arguments:", args);

    // const beneficiary= "0x4d2fc12F449390a467323781879641e4F832EAee";
    // const token = "0x49f95127E2A621bABa8732DaDa88DC1ee5069eaf";

    // console.log("Beneficiary address is :", beneficiary);

    const VestingToken = await ethers.getContractFactory("VestingToken");

    // const start = Math.floor(Date.now()/1000);// Date.now() function returns current time in milliseconds, div by 1000 to get in seconds
    // const cliff = 60* 1; // 1 min - beneficiary can't withdraw tokens until 1 min after start
    // const duration = 60* 10; // 10 min vesting - can withdraw full tokens after 10 mins from start

    const vesting = await VestingToken.deploy(...args);
   // console.log("Constructor args:", token, beneficiary, start, cliff, duration);

    const VestingTokenAddress = await vesting.getAddress();

    console.log("VestingTokenAddress deployed to:", VestingTokenAddress);

}

main().catch((error)=> {
console.error(error);
process.exitCode=1;
});

    

    