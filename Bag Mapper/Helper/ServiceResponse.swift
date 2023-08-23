//
//  File.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation

struct ServiceResponse<T>{
	var isSuccess : Bool
	var message : String
	var data : T?
	
	static func success(_ message : String,_ data : T?)-> ServiceResponse{
		var response = ServiceResponse(isSuccess: true, message: message)
		response.data = data
		return response
	}
	
	static func error(_ message : String)-> ServiceResponse{
		return ServiceResponse(isSuccess: false, message: message)
	}
}
