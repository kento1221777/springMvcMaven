package com.zdrv.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zdrv.dao.MemberDao;
import com.zdrv.domain.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberDao dao;

	@GetMapping("/members")
	public String showPage(Model model) throws Exception {
		model.addAttribute("members", dao.selectAll());
		return "members";
	}

	@GetMapping("/api/members")
	@ResponseBody
	public List<Member> list() throws Exception {
		return dao.selectAll();
	}

	@PostMapping("/api/members")
	@ResponseBody
	public String add(
			@Valid @RequestBody Member member,
			Errors errors) {
		System.out.println(member.getName());
		if(errors.hasErrors()) {
			return "failed: validation error";
		}

		try {
			dao.insert(member);
		} catch (Exception e) {
			return "failed: database error";
		}
		System.out.println("sss");
		return "success";
	}


}
