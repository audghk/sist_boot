package kr.co.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {
	
	@GetMapping("/")
	public String hello() {
		return "hello";
	}
	@GetMapping("/model_data")//boot에서는 .do 잘 안붙임~
	public String sendData(Model model) {
		String[] names= {"박시현","이명화","우미연","정명호","홍박사"};
		model.addAttribute("data", names);
		
		return "day0620/use_model";
	}
	@PostMapping("/param")
	public String param(String name) {
		
		System.out.println("이름 -------"+name);
		
		return "day0620/result";
	}
}
