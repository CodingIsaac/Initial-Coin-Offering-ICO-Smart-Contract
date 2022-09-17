import { ethers } from "hardhat";

async function main() {
  const contract = await ethers.getContractFactory("DabbyICO");
//   const attachContract = await contract.attach("0x4458A3a6e063EAf915D7b4dbc1ae0FB524f7519f");


  const deployContract = await contract.deploy("0xAA5AC6134633183C81436499fb38748D128e039b");

  await deployContract.deployed();

  console.log("DabbyICO Token Deployed Here", deployContract.address);

  // Dabby Token Deployed Here 0x4458A3a6e063EAf915D7b4dbc1ae0FB524f7519f;
  // DabbyICO Token Deployed Here 0x98e236992030E2Fb76F75B8f5E264001472f121E without address
  // DabbyICO Token Deployed Here 0xD5f290e517B344Eb229D55d5EA147cc3746Df905 with address

//   


  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});