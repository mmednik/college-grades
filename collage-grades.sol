// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
pragma experimental ABIEncoderV2;

contract grades {
    
    address public teacher;
    
    constructor () public {
        teacher = msg.sender;
    }
    
    // Associate student with your grade
    mapping (bytes32 => uint) Grades;
    
    // Grade review requests
    string [] gradeReviews;
    
    // Events
    event gradedStudent(bytes32, uint);
    event gradeReview(string);
    
    // Grade a student
    function gradeStudent(string memory _studentId, uint _grade) public TeacherRole(msg.sender) {
        
        bytes32 studentIdHash = keccak256(abi.encodePacked(_studentId));
        Grades[studentIdHash] = _grade;
        emit gradedStudent(studentIdHash, _grade);
        
    }
    
    modifier TeacherRole(address _address) {
        require(_address == teacher, "You do not have privileges to perform this operation.");
        _;
    }
    
    // Get student grades
    function getGrade(string memory _studentId) public view returns (uint) {
        
        bytes32 studentIdHash = keccak256(abi.encodePacked(_studentId));
        uint studentGrade = Grades[studentIdHash];
        return studentGrade;
        
    }
    
    // Request grade review
    function review(string memory _studentId) public {
        
        gradeReviews.push(_studentId);
        emit gradeReview(_studentId);
        
    }
    
    // Get grade reviews 
    function getReviews() public view TeacherRole(msg.sender) returns (string [] memory) {
        
        return gradeReviews;    
        
    }
    
}
