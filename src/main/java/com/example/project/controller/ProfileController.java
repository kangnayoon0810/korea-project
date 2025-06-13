package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.project.dto.FileDto;
import com.example.project.dto.Profile;
import com.example.project.dto.Req;
import com.example.project.dto.TrainerInfo;
import com.example.project.service.FileService;
import com.example.project.service.ProfileService;
import com.example.project.service.TrainerInfoService;

@Controller
public class ProfileController {

	private ProfileService profileService;
	private TrainerInfoService trainerInfoService;
	private FileService fileService;
	private Req req;

	public ProfileController(ProfileService profileService, TrainerInfoService trainerInfoService, FileService fileService, Req req) {
		this.profileService = profileService;
		this.trainerInfoService = trainerInfoService;
		this.fileService = fileService;
		this.req = req;
	}
	
	@GetMapping("/usr/profile/myPage")
	public String showMyProfile(Model model) {
		int loginedMemberId = req.getLoginedMember().getId();
		
	    Profile profile = profileService.getProfileByMemberId(req.getLoginedMember().getId());

	    if (profile == null) {
	        // 기본 프로필 생성
	        profileService.createDefaultProfile(loginedMemberId);
	        profile = profileService.getProfileByMemberId(loginedMemberId); // 다시 불러오기
	    }
	    // 트레이너 정보 가져오기
	    if (req.getLoginedMember().getAuthLevel() == 2) {
	        TrainerInfo trainerInfo = trainerInfoService.getTrainerInfoByProfileId(loginedMemberId);
	        model.addAttribute("trainerInfo", trainerInfo);
	    }

	    // 프로필 이미지 처리
	    FileDto profileImg = null;
	    Integer profileImageId = profile.getProfileImageId();

	    if (profileImageId != null) {
	        profileImg = fileService.getFileById(profileImageId);
	    }

	    String profileImageUrl = "/gen/default-profile.jpg"; // 기본 이미지 경로 (JPG로 변경)
	    if (profileImg != null) {
	        profileImageUrl = profileImg.getForPrintUrl();
	    }

	    model.addAttribute("profileImageUrl", profileImageUrl);
	    model.addAttribute("profile", profile);

	    return "usr/profile/myPage";
	}

	
}