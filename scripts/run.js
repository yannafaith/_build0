const main = async () => {
    const taskFactory = await hre.ethers.getContractFactory("TaskPortal");
    const taskContract = await taskFactory.deploy();
    await taskContract.deployed();
    console.log("taskPortal address: ", taskContract.address);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();