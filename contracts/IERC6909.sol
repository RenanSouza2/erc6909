// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

interface IERC6909 {
    function balanceOf(address owner, uint256 id) external view returns (uint256 amount);
    function allowance(address owner, address operator, uint256 id) external view returns (uint256 amount);
    function isOperator(address owner, address operator) external view returns (bool);

    function transfer(address receiver, uint256 id, uint256 amount) external returns (bool success);
    function transferFrom(
        address owner, 
        address receiver, 
        uint256 id, 
        uint256 amount
    ) external returns (bool success);
    function approve(address operator, uint256 id, uint256 amount) external returns (bool success);
    function setOperator(address operator, bool approved) external returns (bool success);

    event Transfer(
        address operator, 
        address indexed caller, 
        address indexed receiver, 
        uint256 indexed id, 
        uint256 amount
    );
    event OperatorSet(address indexed owner, address indexed operator, bool approved);
    event Approval(
        address indexed owner, 
        address indexed spender, 
        uint256 indexed id, 
        uint256 amount
    );
}
