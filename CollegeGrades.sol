// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CollegeGrades {
    
    address public teacher;
    
    constructor() {
        teacher = msg.sender;
    }
    // Associate student with your grade
    mapping(bytes32 => uint) Grades;
    // Grade review requests
    string[] gradeReviews;
    // Events
    event GradedStudent(bytes32, uint);
    event GradeReview(string);
    // Grade a student
    function gradeStudent(
        string memory _studentId,
        uint _grade
    ) public teacherRole(msg.sender) {
        bytes32 studentIdHash = keccak256(abi.encodePacked(_studentId));
        Grades[studentIdHash] = _grade;
        emit GradedStudent(studentIdHash, _grade);
    }

    modifier teacherRole(address _address) {
        require(_address == teacher, "You do not have privileges to perform this operation.");
        _;
    }
    // Get student grades
    function getGrade(string memory _studentId) public view returns(uint) {
        bytes32 studentIdHash = keccak256(abi.encodePacked(_studentId));
        uint studentGrade = Grades[studentIdHash];
        return studentGrade;
    }
    // Request grade review
    function review(string memory _studentId) public {
        gradeReviews.push(_studentId);
        emit GradeReview(_studentId);
    }
    // Get grade reviews 
    function getReviews() public view teacherRole(msg.sender) returns(string[] memory) {
        return gradeReviews;    
    }
    
}