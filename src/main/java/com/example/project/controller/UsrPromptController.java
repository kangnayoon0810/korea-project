package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UsrPromptController {

	@GetMapping("/usr/prompt/selectLogin")
	public String selectLogin() {
		return "usr/prompt/selectLogin";
	}
}