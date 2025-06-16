package com.example.project.controller;
import java.io.IOException;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.project.dto.Board;
import com.example.project.dto.Member;
import com.example.project.dto.ProfileDto;
import com.example.project.dto.Req;
import com.example.project.dto.TrainerInfo;
import com.example.project.service.MemberService;
import com.example.project.service.ProfileService;
import com.example.project.service.TrainerInfoService;
import com.example.project.util.Util;

@Controller
public class UsrProfileController {

	private ProfileService profileService;
	private TrainerInfoService trainerInfoService;
	private MemberService memberService;
	private Req req;

	public UsrProfileController(ProfileService profileService, TrainerInfoService trainerInfoService, MemberService memberService, Req req) {
		this.profileService = profileService;
		this.trainerInfoService = trainerInfoService;
		this.memberService = memberService;
		this.req = req;
	}
	
	@GetMapping("/usr/profile/myPage")
	public String showMyProfile(Model model) {
		int loginedMemberId = req.getLoginedMember().getId();
		
	    ProfileDto profile = profileService.getProfileByMemberId(req.getLoginedMember().getId());

	    // 트레이너 정보 가져오기
	    if (req.getLoginedMember().getAuthLevel() == 2) {
	        TrainerInfo trainerInfo = trainerInfoService.getTrainerInfoByProfileId(loginedMemberId);
	        model.addAttribute("trainerInfo", trainerInfo);
	    }
	    
	    model.addAttribute("profile", profile);

	    return "usr/profile/myPage";
	}
	
	@PostMapping("/usr/profile/upload")
	public String profileUpload(MultipartFile profileImg) throws IOException {
		
		if (profileImg.isEmpty()) {
			return Util.jsReplace("파일이 선택되지 않았습니다", null);
		}
		this.profileService.updateProfileImg(profileImg, req.getLoginedMember().getId());
		
		return "redirect:/usr/profile/myPage";
	}
	
	@GetMapping("/usr/profile/image/{profileId}")
	@ResponseBody
	public Resource profileLoad(Model model, @PathVariable int profileId) throws IOException {
		
		ProfileDto profileDto = profileService.getProfileById(profileId);
		
		return new UrlResource("file:" + profileDto.getProfileImagePath());
	}
	
}