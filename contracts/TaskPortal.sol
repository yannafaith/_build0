pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract TaskPortal {
    event TaskCreated(address indexed from, string task, uint256 pledge, uint256 timestamp);
    event TaskCompleted(address indexed from, string task, uint256 pledge, uint256 timestamp);

    struct Task  {
        uint256 id;
        address sender;
        string task;
        uint256 pledge;
        uint256 timestamp;
    }

    Task task;

    uint256 openTaskCnt;
    uint256 closedTaskCnt;

    Task[] openTasks;
    Task[] closedTasks;

    constructor() payable {}

    function newTask(string memory _task) public payable {
        require(msg.value>0);
        task = Task(openTaskCnt+1, msg.sender, _task, msg.value, block.timestamp);
        openTasks.push(task);
        openTaskCnt += 1;
        console.log("%s sent %k!", msg.sender, msg.value);
        emit TaskCreated(msg.sender, _task, msg.value, block.timestamp);
    }

    function getTaskCnt() public view returns (uint256) {
        return closedTaskCnt + openTaskCnt;
    }

    function getOpenTasks() public view returns (Task[] memory) {
        return openTasks;
    }

}