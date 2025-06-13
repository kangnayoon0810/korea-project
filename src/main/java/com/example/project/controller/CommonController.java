package com.example.project.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dto.FileDto;
import com.example.project.dto.Req;
import com.example.project.service.FileService;
import com.example.project.util.Util;

@Controller
public class CommonController {


	private FileService fileService;
	private Req req;

	public CommonController(FileService fileService, Req req) {
		this.fileService = fileService;
		this.req = req;
	}
	
	@PostMapping("/usr/common/upload")
	@ResponseBody
	public String upload(MultipartFile file) {
		if (file.isEmpty()) {
			return Util.jsReplace("파일이 선택되지 않았습니다", null);
		}
		
		try {
			fileService.saveFile(file);
		} catch (IOException e) {
			e.printStackTrace();
			return Util.jsReplace("이미지를 업로드 하는데 문제가 발생했습니다", null);
		}
		
		return "/usr/profile/myPage";
	}
	
	@GetMapping("/usr/common/view")
	public String view(Model model) {
		
		List<FileDto> files = fileService.getFiles();
		
		model.addAttribute("files", files);
		
		return "usr/common/view";
	}
	
	@GetMapping("/usr/common/file/{fileId}")
	@ResponseBody
	public Resource fileLoad(Model model, @PathVariable("fileId") int id) throws IOException {
		
		FileDto fileDto = fileService.getFileById(id);
		
		return new UrlResource("file:" + fileDto.getSavedPath());
	}

}