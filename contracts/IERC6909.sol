// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IERC6909 {
    function balanceOf(address owner, uint id) external view returns (uint amount);
    function allowance(address owner, address operator, uint id) external view returns (uint amount);
    function isOperator(address owner, address operator) external view returns (bool);

    function transfer(address receiver, uint id, uint amount) external returns (bool success);
    function transferFrom(
        address owner, 
        address receiver, 
        uint id, 
        uint amount
    ) external returns (bool success);
    function approve(address operator, uint id, uint amount) external returns (bool success);
    function setOperator(address operator, bool approved) external returns (bool success);

    event Transfer(
        address operator, 
        address indexed caller, 
        address indexed receiver, 
        uint indexed id, 
        uint amount
    );
    event OperatorSet(address indexed owner, address indexed operator, bool approved);
    event Approval(address indexed owner, address indexed spender, uint indexed id, uint amount);
}
