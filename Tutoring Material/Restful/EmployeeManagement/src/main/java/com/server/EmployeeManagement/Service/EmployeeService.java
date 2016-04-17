package com.server.EmployeeManagement.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.server.EmployeeManagement.Database.DatabaseHelper;
import com.server.EmployeeManagement.Model.Employee;

public class EmployeeService {
	HashMap<Long, Employee> emps = (HashMap<Long, Employee>) DatabaseHelper.employeeMap;
	public Employee addEmployee(Employee emp){
		emp.setId(emps.size()+1);
		emps.put(emp.getId(), emp);
		return emp;
	}
	
	public ArrayList<Employee> getEmployeeList(){
		return new ArrayList<Employee>(emps.values());
	}
	

}
