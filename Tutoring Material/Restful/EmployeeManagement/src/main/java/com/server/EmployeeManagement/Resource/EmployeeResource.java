package com.server.EmployeeManagement.Resource;


import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;



import com.server.EmployeeManagement.Model.Employee;
import com.server.EmployeeManagement.Service.EmployeeService;

@Path("employees")
@Consumes(MediaType.APPLICATION_JSON)
public class EmployeeResource {
	EmployeeService service = new EmployeeService();
	
	@GET
	@Produces(MediaType.TEXT_PLAIN)
	public String getRequest(){
		return "got request";
	}
	
	
//	@GET
//	public ArrayList<Employee> getEmployeeList(){
//		
//		return service.getEmployeeList();
//	}
//	@POST
//	public Employee addEmployee(Employee emp){
//		return service.addEmployee(emp);
//	}

}
