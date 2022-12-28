const main = async () => {
    const taskFactory = await hre.ethers.getContractFactory("TaskPortal");
    const taskContract = await taskFactory.deploy();
    const success = await taskContract.deployed();
    console.log("Contract deployed to:", success);
    console.log("taskPortal address: ", taskContract.address);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
};

runMain();