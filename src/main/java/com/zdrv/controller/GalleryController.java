package com.zdrv.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/gallery")
public class GalleryController {

	@GetMapping
	public String show(
			HttpServletRequest request,
			Model model) {
		File directory = new File(request.getServletContext().getRealPath("/uploads") + "/");
		File[] files = directory.listFiles();
		model.addAttribute("files", files);
		return "gallery";
	}

	@PostMapping
	public String upfile(
			HttpServletRequest request,
			@RequestParam("upfile") MultipartFile upfile,
			Model model) throws IOException, ServletException {

		if(!upfile.isEmpty()) {
			File file = new File(request.getServletContext().getRealPath("/uploads") + "/" + upfile.getOriginalFilename());
			System.out.println(file);
			byte[] bytes = upfile.getBytes();
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(file));
			stream.write(bytes);
			stream.close();
		}

		// あとはGetリクエスト時と同じ
		return show(request, model);
	}

}
