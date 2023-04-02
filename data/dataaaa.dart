import 'dart:convert';
import 'dart:io';

void generateJsonData() {
  final users = [
    {
      "id": 1,
      "name": "John Smith",
      "email": "john@example.com",
      "password": "password123",
      "role": "student"
    },
    {
      "id": 2,
      "name": "Jane Doe",
      "email": "jane@example.com",
      "password": "password456",
      "role": "teacher"
    }
  ];

  final knowledge = [
    {
      "id": 1,
      "name": "Programming",
      "description": "The art of writing computer programs"
    },
    {
      "id": 2,
      "name": "Mathematics",
      "description": "The study of numbers and their properties"
    }
  ];

  final courses = [
    {
      "id": 1,
      "name": "Introduction to Programming",
      "description": "Learn the basics of programming",
      "knowledge": 1,
      "teacher": 2
    },
    {
      "id": 2,
      "name": "Advanced Mathematics",
      "description": "A deep dive into complex math concepts",
      "knowledge": 2,
      "teacher": 2
    }
  ];

  final subjects = [
    {
      "id": 1,
      "name": "Computer Science",
      "description": "The study of computers and computing",
      "courses": [1]
    },
    {
      "id": 2,
      "name": "Mathematics",
      "description": "The study of numbers and their properties",
      "courses": [2]
    }
  ];

  final data = {
    "users": users,
    "knowledge": knowledge,
    "courses": courses,
    "subjects": subjects,
  };

  final json = jsonEncode(data);
  final file = File('path/to/file.json');
  file.writeAsStringSync(json);
}
